#!/usr/bin/env python3
"""


"""
# ruff.ignore.in.file
from __future__ import annotations

# Imports:
# ##-- stdlib imports
from copy import deepcopy
from uuid import UUID, uuid1
from weakref import ref
from asyncio import (
     create_task, gather, sleep, timeout, shield,
     to_thread, current_task, all_tasks,
     TaskGroup,
     CancelledError,
)
import asyncio
import collections
import contextlib
import datetime
import enum
import faulthandler
import functools as ftz
import hashlib
import itertools as itz
import logging as logmod
import pathlib as pl
import re
import time
# ##-- end stdlib imports

from os import environ
import sys
import tqdm
import argparse
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

# Vars:
BIBLIO_ROOT  : Final[pl.Path]  = pl.Path(environ['POLYGLOT_ROOT'])
MAIN_DIR     : Final[pl.Path]  = BIBLIO_ROOT / "main"
LIB_ROOT     : Final[pl.Path]  = pl.Path(environ['BIBLIO_LIB'])
NEW_ROOT     : Final[pl.Path]  = pl.Path(LIB_ROOT.parent / "pdfs_structured")

GLOB_STR     : Final[str]      = "*.bib"

##--| Argparse
parser = argparse.ArgumentParser(
    prog="polyglot task restructure [files]",
    description="Retarget library directories into new {century}/{decade}/{year} structure.",
)

parser.add_argument("--window", default=-1, type=int)
parser.add_argument("--collect", default=False, action="store_true")
parser.add_argument("--new-root", default=NEW_ROOT)
parser.add_argument("--dry-run", default=False, action="store_true")
parser.add_argument("--copy", default=False, action="store_true")
parser.add_argument("targets", nargs='*')

# Body:

def retarget_files(dir:pl.Path, root:pl.Path, *, dry:bool=False, copy:bool=False) -> None:
    if dir.is_file():
        print(f"- Skipping file: {dir}")
        return
    if not dir.exists():
        print(f"- Error: target does not exist: {dir}")
        return
    rel_path  = dir.relative_to(LIB_ROOT)
    stem      = dir.stem
    prefix    = _util.year_to_prefix(int(stem))
    target    = pl.Path(root, prefix, stem)
    assert(not target.exists())
    print(f"-- {dir} -> {target}")
    if dry:
        return
    elif copy:
        dir.copy(target)
    else:
        dir.rename(target)

def main():
    print("---- [Files]")
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

    print("- Retargeting Actual Files...")
    if args.dry_run:
        print("- (Dry Run)")

    for bib in _util.window_collection(args.window, targets):
        base = bib.stem
        dir  = LIB_ROOT / base
        retarget_files(dir, args.new_root,
                       dry=args.dry_run,
                       copy=args.copy)

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
