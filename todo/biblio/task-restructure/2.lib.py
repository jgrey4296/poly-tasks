#!/usr/bin/env -S uv run --script
"""
Utility script to restructure library pdfs to group by decade

"""
# ruff: noqa:
from __future__ import annotations

# Imports:
# ##-- stdlib imports
import datetime
import enum
import functools as ftz
import itertools as itz
import logging as logmod
import pathlib as pl
import re
import time
import collections
import contextlib
import hashlib
from copy import deepcopy
from uuid import UUID, uuid1
from weakref import ref
import atexit # for @atexit.register
import faulthandler
# ##-- end stdlib imports

import shutil
import math
import sys
import tqdm
import bibble as BM
import bibble._interface as API
from bibble.io import Writer, Reader
import task_utils as _util

# ##-- types
# isort: off
# General
import abc
import collections.abc
import typing
import types
from typing import cast, assert_type, assert_never
from typing import Generic, NewType, Never
from typing import no_type_check, final, override, overload
# Protocols and Interfaces:
from typing import Protocol, runtime_checkable
# isort: on
# ##-- end types

# ##-- type checking
# isort: off
if typing.TYPE_CHECKING:
    from typing import Final, ClassVar, Any, Self
    from typing import Literal, LiteralString
    from typing import TypeGuard
    from collections.abc import Iterable, Iterator, Callable, Generator
    from collections.abc import Sequence, Mapping, MutableMapping, Hashable

    from jgdv import Maybe
## isort: on
# ##-- end type checking

##-- logging
logging = logmod.getLogger(__name__)
##-- end logging

from os import environ

# Vars:
BIBLIO_ROOT    : Final[pl.Path]          = pl.Path(environ['POLYGLOT_ROOT'])
MAIN_DIR       : Final[pl.Path]          = BIBLIO_ROOT / "main"
LIB_ROOT       : Final[pl.Path]          = pl.Path(environ['BIBLIO_LIB'])
NEW_ROOT       : Final[pl.Path]          = pl.Path(LIB_ROOT.parent / "pdfs_structured")

GLOB_STR       : Final[str]              = "*.bib"
CHUNK_SIZE     : Final[int]              = 100
CENTURY_RANGE  : Final[tuple[int, int]]  = (1200, 2100)

##--| Argparse
import argparse
parser = argparse.ArgumentParser(
    prog="polyglot task restructure [lib]",
    description="Parse bibtex files and retarget their referenced files into new {century}/{decade}/{year} structure.",
)
parser.add_argument("--window", default=-1, type=int)
parser.add_argument("--collect", default=False, action="store_true")
parser.add_argument("--new-root", default=NEW_ROOT)
parser.add_argument("--dry-run", default=False, action="store_true")
parser.add_argument("targets", nargs='*')
##--| Body

def build_reader_and_writer() -> tuple[Reader, API.Writer_p]:
    stack     = BM.PairStack()
    extra     = BM.metadata.DataInsertMW()
    stack.add(read=[extra],
              write=[BM.failure.FailureHandler()])
    stack.add(BM.bidi.BraceWrapper(),
              # BM.bidi.BidiPaths(lib_root=LIB_ROOT),
              )

    stack.add(write=[extra])
    reader = Reader(stack)
    writer = Writer(stack)
    return reader, writer

def retarget_entries(lib, base:pl.Path, decade:pl.Path) -> None:
    """ eg: entry.file=1999/author/name.pdf
    -> entry.file=1900/1990/1999/author/name.pdf
    """
    print(f"-- Retargeting Entries for: {base}")
    for entry in tqdm.tqdm(lib.entries):
        for key,val in entry.fields_dict.items():
            if "file" not in key:
                continue
            assert(isinstance(val.value, str))
            file       = pl.Path(val.value)
            if file.is_relative_to(decade):
                continue
            target     = decade / file
            val.value  = target

def main():
    print("---- [Lib]")
    args, _ = parser.parse_known_args()
    targets  = [pl.Path(x) for x in args.targets if bool(x)]
    if args.collect:
        collected = []
        for x in targets:
            collected += _util.collect(pl.Path(x), glob=GLOB_STR)
        else:
            targets = collected
            print("- Collected: {len(targets)} entries")

    if not pl.Path(args.new_root).exists():
        print("- Error: New Lib Root does not exist yet")
        sys.exit(1)

    print(f"- Retargeting {len(targets)} bibtex entries")
    reader, writer  = build_reader_and_writer()
    for bib in _util.window_collection(args.window, targets):
        new_prefix  = _util.year_to_prefix(int(bib.stem))
        lib         = reader.read(bib)
        retarget_entries(lib, bib, new_prefix)
        if args.dry_run:
            continue
        else:
            writer.write(lib, file=bib)
    else:
        pass

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
