#!/usr/bin/env -S uv run --script
"""
Utility script to download urls mentioned in bibtex files

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

from os import environ
# Vars:
ONLINE_SOURCE    : Final[pl.Path]  = pl.Path(environ['POLYGLOT_ROOT']) / "in_progress/online.bib"
DOWNLOAD_TARGET  : Final[pl.Path]  = pl.Path(environ['BIBLIO_DOWNLOAD_TO'])
LIB_ROOT         : Final[pl.Path]  = pl.Path(environ['BIBLIO_LIB'])
##--| argparse
import argparse
parser = argparse.ArgumentParser(
    prog="biblio online",
    description="Process and download referenced URLs in online entries",
)
parser.add_argument("--window", default=-1, type=int)
parser.add_argument("--failures", default=None)
parser.add_argument("target", nargs="*", default=ONLINE_SOURCE)

##--| Body

def build_reader_and_writer() -> tuple[Reader, API.Writer_p]:
    stack = BM.PairStack()
    extra = BM.metadata.DataInsertMW()
    stack.add(read=[extra,
                    BM.failure.DuplicateKeyHandler(),
                    ],
              write=[BM.failure.FailureHandler()])
    stack.add(BM.bidi.BraceWrapper(),
              BM.bidi.BidiPaths(lib_root=LIB_ROOT),
              )

    extra.update({BM.files.PathWriter.SuppressKey:[DOWNLOAD_TARGET]})
    stack.add(read=[BM.files.OnlineDownloader(target=DOWNLOAD_TARGET)])

    stack.add(write=[extra])
    reader = Reader(stack)
    writer = Writer(stack)
    return reader, writer

def main():
    args    = parser.parse_args()
    target  = pl.Path(args.target)
    match args.failures:
        case None:
            failures = None
        case str() as x:
            failures = pl.Path(x)

    print("Starting online downloader")
    reader, writer = build_reader_and_writer()
    lib = reader.read(target)
    writer.write(lib, file=target)
    if failures:
        writer.write_failures(lib, file=failures)
    print("Finished")

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
