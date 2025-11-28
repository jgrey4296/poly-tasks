#!/usr/bin/env -S uv run --script
"""
Utility script to format bibtex files

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
from bibble.io import Reader
from bibble.io import Writer
from jgdv.files.tags import SubstitutionFile
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
sort_firsts     : Final[list[str]]  = ["title", "subtitle", "author", "editor", "year", "tags", "booktitle", "journal", "volume", "number", "edition", "edition_year", "publisher"]
sort_lasts      : Final[list[str]]  = ["isbn", "doi", "url", "file", "crossref"]
sub_fields      : Final[list[str]]  = ["publisher", "journal", "series", "institution"]
GLOB_STR        : Final[str]        = "*.bib"
BIBLIO_ROOT     : Final[pl.Path]    = pl.Path(environ['POLYGLOT_ROOT'])
LIB_ROOT        : Final[pl.Path]    = pl.Path(environ['BIBLIO_LIB'])
SUB_ROOT        : Final[pl.Path]    = BIBLIO_ROOT / "tags/substitutions"
TAGS_SOURCE     : Final[pl.Path]    = BIBLIO_ROOT / ".temp/tags/canon.tags"
JOURNAL_SOURCE  : Final[pl.Path]    = SUB_ROOT / "journals.sub"
CONF_SOURCE     : Final[pl.Path]    = SUB_ROOT / "conferences.sub"
INST_SOURCE     : Final[pl.Path]    = SUB_ROOT / "institution.sub"
PUB_SOURCE      : Final[pl.Path]    = SUB_ROOT / "publisher.sub"
SERIES_SOURCE   : Final[pl.Path]    = SUB_ROOT / "series.sub"

##--| Argparse
import argparse
parser = argparse.ArgumentParser(
    prog="biblio format",
    description="Parse and format bibtex files, in place",
)
parser.add_argument("--window", default=-1, type=int)
parser.add_argument("--collect", action="append", default=[])
parser.add_argument("--failures", default=None)
parser.add_argument("--latex-in", action="store_true", default=False)
parser.add_argument("--latex-out", action="store_true", default=False)
parser.add_argument("targets", nargs='*')

##--| Body
def build_reader_and_writer(args) -> tuple[Reader, API.Writer_p]:
    tag_subs      = _util.load_tags(TAGS_SOURCE)
    journal_subs  = _util.load_tags(JOURNAL_SOURCE, norm=False)

    stack         = BM.PairStack()
    extra         = BM.metadata.DataInsertMW()
    fail_handler  = BM.failure.FailureHandler()

    stack.add(read=[
        extra,
        BM.failure.DuplicateKeyHandler(),
    ],
              write=[fail_handler],
              )
    stack.add(BM.bidi.BraceWrapper(),
              BM.bidi.BidiPaths(lib_root=LIB_ROOT)
              )
    if args.latex_in:
        stack.add(read=[BM.latex.LatexReader()])

    if args.latex_out:
        stack.add(write=[BM.latex.LatexWriter()])

    stack.add(
        BM.bidi.BidiNames(parts=True, authors=True),
        BM.bidi.BidiIsbn(),
        BM.bidi.BidiTags(),
        read=[
            BM.metadata.KeyLocker(),
            BM.fields.TitleSplitter()
        ],
        write=[
            BM.fields.FieldSorter(first=sort_firsts, last=sort_lasts),
            BM.metadata.EntrySorter(),
            BM.fields.FieldSubstitutor(fields=["tags"], subs=tag_subs),
            BM.fields.FieldSubstitutor(fields=["journal"], subs=journal_subs, force_single_value=True),
        ])

    stack.add(write=[
        BM.metadata.FileCheck(),
        # BM.fields.Waybacker(),
        # BM.files.HashFiles(),
        # BM.files.VirusScan(),
        # BM.fields.UrlCheck(),
        # BM.metadata.DoiValidator(),
        # BM.metadata.CrossrefValidator(),
    ])

    stack.add(write=[extra])
    reader = Reader(stack)
    writer = Writer(stack)
    return reader, writer


def main():
    args     = parser.parse_args()
    targets  = [pl.Path(x) for x in args.targets]
    for x in args.collect:
        targets += _util.collect(pl.Path(x), glob=GLOB_STR)

    match args.failures:
        case None:
            failures = None
        case str() as x:
            failures = pl.Path(x)

    assert(bool(targets)), "Specify a --collect, or a target"
    reader, writer = build_reader_and_writer(args)
    for bib in _util.window_collection(args.window, targets):
        print(f"Target : {bib}")
        lib = reader.read(bib)
        writer.write(lib, file=bib)
        if failures:
            writer.write_failures(lib, file=failures)
    else:
        print("Finished")

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
