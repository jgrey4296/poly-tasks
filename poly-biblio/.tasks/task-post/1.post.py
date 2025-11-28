#!/usr/bin/env -S uv run --script
"""

"""
# ruff.ignore.in.file
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

import bibble as BM
import bibble._interface as API
from bibble.io import Reader
from bibble.io import Writer
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
import _util
# Vars:
GLOB_STR     : Final[str]      = "*.bib"
TEMPLATE     : Final[str]      = "media_post.jinja"
DEFAULT_OUT  : Final[pl.Path]  = pl.Path(environ['BIBLIO_TEMP']) / "post"

##--| Argparse
import argparse
parser = argparse.ArgumentParser(
    prog="biblio post",
    description="Select a bibtex entry, format it, post it to social media",
)
parser.add_argument("--window", default=-1, type=int)
parser.add_argument("--collect", action="append", default=[])
parser.add_argument("--template-dir")
parser.add_argument("--output", default=DEFAULT_OUT)
parser.add_argument("--style", default="jg_custom_name_first")

parser.add_argument("targets", nargs='*')

##--| Body

def build_reader_and_writer() -> tuple[Reader, API.Writer_p]:
    stack     = BM.PairStack()
    extra     = BM.metadata.DataInsertMW()
    stack.add(read=[extra,
                    BM.failure.DuplicateKeyHandler(),
                    ],
              write=[
                  BM.failure.FailureHandler(),
              ])
    stack.add(BM.bidi.BraceWrapper(),
              BM.bidi.BidiPaths(lib_root=LIB_ROOT),
              )

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
            # BM.fields.FieldSubstitutor(fields=sub_fields, subs=_othersubs, force_single_value=True),
        ])

    stack.add(write=[extra])
    reader = Reader(stack)
    writer = Writer(stack)
    return reader, writer

def select_entry(bibs:list[pl.Path]) -> dict:
    reader, writer = build_reader_and_writer()

    return {}

def post_to_mastodon(text:str):
    pass

def main():
    args = parser.parse_args()
    targets  = [pl.Path(x) for x in args.targets]
    for x in args.collect:
        targets += _util.collect(pl.Path(x), glob=GLOB_STR)

    # select an entry
    entry     = select_entry(targets)
    env       = _util.init_jinja(pl.Path(args.template_dir))
    template  = env.get_template(TEMPLATE)
    text      = template.render(
        title=entry['title'],
        year=entry['year'],
        author=entry['author'],
        url=entry['url'],
        tags=entry['tags'],
    )

    # post it
    post_to_mastodon(text)

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
