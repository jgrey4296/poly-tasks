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
import task_utils as _util
# Vars:
BIBLIO_TEMP : Final[pl.Path] = pl.Path(environ['POLYGLOT_TEMP'])
DEFAULT_OUT           : Final[pl.Path]  = BIBLIO_TEMP / "tex"
DEFAULT_TEMPLATE_DIR  : Final[pl.Path]  = pl.Path(environ['BIBLIO_TEMPLATE_DIR'])
GLOB_STR              : Final[str]      = "*.bib"
TEMPLATE              : Final[str]      = "export_template.tex.jinja"

##--| Argparse
import argparse
parser = argparse.ArgumentParser(
    prog="biblio tex",
    description="Prepare tex files of bibtex files for exporting the library",
)
parser.add_argument("--window", default=-1, type=int)
parser.add_argument("--collect", action="append", default=[])
parser.add_argument("--template-dir", default=DEFAULT_TEMPLATE_DIR)
parser.add_argument("--output", default=DEFAULT_OUT)
parser.add_argument("--style", default="jg_custom_name_first")

parser.add_argument("targets", nargs='*')

##--|

def main():
    args = parser.parse_args()
    targets  = [pl.Path(x) for x in args.targets]
    for x in args.collect:
        targets += _util.collect(pl.Path(x), glob=GLOB_STR)

    env = _util.init_jinja(pl.Path(args.template_dir))
    template = env.get_template(TEMPLATE)

    for bib in _util.window_collection(args.window, targets):
        # TODO read and export the bibtex with latex encoding

        # render the template
        text = template.render(
            target=bib.name,
            style=args.style,
        )


##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
