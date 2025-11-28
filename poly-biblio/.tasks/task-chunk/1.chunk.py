#!/usr/bin/env -S uv run --script
"""
Utility script to chunk particularly large bibtex files

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

import sys
import tqdm
import warnings
import task_utils as _util
with warnings.catch_warnings():
    warnings.simplefilter("ignore", SyntaxWarning)
    import bibble as BM
    import bibble._interface as API
    from bibble.io import Writer, Reader

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
CHUNK_SIZE   : Final[int]      = 100
GLOB_STR     : Final[str]      = "*.bib"
##--| Body

import argparse
parser = argparse.ArgumentParser(
    prog="biblio chunk",
    description="Chunk Large Bibtex Files into a collection of files with only N entries",
)
parser.add_argument("--size", default=CHUNK_SIZE, type=int)
parser.add_argument("--collect", action="append", default=[])
parser.add_argument("--failures", default=None)
parser.add_argument("targets", nargs='*')

##--|


def build_reader_and_writer() -> tuple[Reader, API.Writer_p]:
    stack = BM.PairStack()
    stack.add(read=[BM.metadata.DataInsertMW(),
                    BM.failure.DuplicateKeyHandler(),
                    ],
              write=[BM.failure.FailureHandler()]
              )

    stack.add(read=[])
    reader = Reader(stack)
    writer = Writer(stack)
    return reader, writer


def chunk_library(lib:API.Library_p, size:int=CHUNK_SIZE) -> list[BM.BibbleLib]:
    results  : list[BM.BibbleLib]  = []
    entries  : list                = list(lib.entries)
    while bool(entries):
        chunk      = entries[:size]
        entries    = entries[size:]
        chunk_lib  = BM.BibbleLib(chunk)
        results.append(chunk_lib)
    else:
        return results

def main():
    args     = parser.parse_args()
    assert(0 < args.size)
    targets  = [pl.Path(x) for x in arg.targets]
    for x in args.collect:
        targets += _util.collect(pl.Path(x), glob=GLOB_STR)
    match args.failures:
        case None:
            failures = None
        case str() as x:
            failures = pl.Path(x)

    assert(bool(targets))
    reader, writer = build_reader_and_writer()
    for bib in targets:
        print(f"Chunking: {bib}")
        lib     = reader.read(bib)
        chunks  = chunk_library(lib, size=args.size)
        print(f"Chunked into {len(chunks)} subfiles")
        for i,chunk in enumerate(chunks):
            chunk_stem = f"{bib.stem}-{i}"
            chunk_path = bib.with_stem(chunk_stem)
            writer.write(chunk, file=chunk_path)
            if failures:
                writer.write_failures(chunk, file=failures)
        else:
            pass
    else:
        print("Finished")

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
