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

import argparse

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

CENTURY_RANGE  : Final[tuple[int, int]]  = (1200, 2100)
ZERO_ZERO_ONE  : Final[float]            = 0.01
ZERO_ONE       : Final[float]            = 0.1
HUNDRED        : Final[int]              = 100
TEN            : Final[int]              = 10
END_DECADE     : Final[int]              = 2030

#-- argparse
#see https://docs.python.org/3/howto/argparse.html
parser = argparse.ArgumentParser(prog="polyglot task restructure [setup]",
                                 description="Parse bibtex files and retarget their referenced files",
                                 )

parser.add_argument("--new-root", default=NEW_ROOT)

# Body:

def generate_year_structures(root:pl.Path) -> None:
    """ Create the new library structure skeleton """
    print("- Generating Century/Decade Directories ...")
    print(f"- Root: {root}")
    if not root.exists():
        print(f"WARNING: Root does not exist")
        sys.exit(1)
    centuries  = list(range(*CENTURY_RANGE, HUNDRED))
    for cent in centuries:
        print(f"- Generating {cent}'s")
        base = [root]
        base.append(str(cent))
        for dec in range(cent, cent+HUNDRED, TEN):
            if END_DECADE < dec:
                return
            target = pl.Path(*base, str(dec))
            target.mkdir(parents=True, exist_ok=True)
        else:
            pass
    else:
        pass

def main():
    print("---- [Setup]")
    args, _ = parser.parse_known_args()
    args.new_root = pl.Path(args.new_root)
    generate_year_structures(args.new_root)

##-- Ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
