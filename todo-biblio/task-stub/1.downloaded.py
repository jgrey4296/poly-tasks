#!/usr/bin/env -S uv run --script
"""

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
import jinja2
import sys
import tqdm
import bibble as BM
import bibble._interface as API
from bibble.io import JinjaWriter, Reader
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
STUB_FILE          : Final[pl.Path]  = pl.Path(environ['BIBLIO_STUB_FILE'])
TODO_DIR           : Final[pl.Path]  = pl.Path(environ['BIBLIO_TODO']) / "stubbed"
DROPBOX            : Final[pl.Path]  = pl.Path(environ['BIBLIO_DROPBOX'])
DOWNLOADS          : Final[pl.Path]  = pl.Path("~/Downloads").expanduser()
GLOB_STR           : Final[str]      = "*.pdf"
STUB_TEMPLATE_KEY  : Final[str]      = "stub.bib.jinja"
##--| argparse
import argparse
parser = argparse.ArgumentParser(
    prog="biblio stub",
    description="Create Stub entries from unprocessed pdfs and epubs in watch directories",
)
parser.add_argument("--window", default=-1, type=int)
parser.add_argument("--collect", action="append", default=[])


##--| Body

def build_stub(target:pl.Path, *, template:jinja2.Template) -> str:
    print("Stubbing: ", target)
    result = template.render(file=str(target))
    return result

def main():
    stubs : list[str]
    ##--|
    args = parser.parse_args()


    env       = _util.init_jinja()
    template  = env.get_template(STUB_TEMPLATE_KEY)
    targets   = _util.collect(DROPBOX,   glob=GLOB_STR)
    targets  += _util.collect(DOWNLOADS, glob=GLOB_STR)
    stubs     = []
    for x in _util.window_collection(args.window, targets):
        # move file to todo folder
        in_todos = TODO_DIR / x.name
        assert(not in_todos.exists()), in_todos
        shutil.copy(x, in_todos)
        assert(in_todos.exists()), in_todos
        stubs.append(build_stub(in_todos, template=template))
        if in_todos.exists() and not args.keep:
            x.unlink()
    else:
        # Append to stub file:
        with STUB_FILE.open("a") as f:
            f.write("\n\n".join(stubs))


##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
