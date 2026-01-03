#!/usr/bin/env -S uv run --script
"""

"""
# ruff: noqa:
from __future__ import annotations

# Imports:
# ##-- stdlib imports
import sys
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
TODO_DIR       : Final[pl.Path]  = pl.Path(environ['BIBLIO_TODO'])
GLOB_STR_PDF   : Final[str]      = "**/_refiled_*.pdf"
GLOB_STR_EPUB  : Final[str]      = "**/_refiled_*.epub"
##--| argparse
import argparse
parser = argparse.ArgumentParser(
    prog="biblio cleanup",
    description="Cleanup refiled files",
)
# Body:

def main():
    args = parser.parse_args()
    targets  = _util.collect(TODO_DIR, glob=GLOB_STR_PDF)
    targets += _util.collect(TODO_DIR, glob=GLOB_STR_EPUB)
    for x in targets:
        x.unlink()
    else:
        print(f"Removed {len(targets)} files")
        print("Finished")

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
