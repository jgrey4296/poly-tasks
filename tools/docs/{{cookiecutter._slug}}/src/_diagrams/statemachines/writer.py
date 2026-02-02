#!/usr/bin/env python3
"""

"""
# ruff: noqa:

# Imports:
from __future__ import annotations

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

import asyncio
from weakref import ref
from asyncio import run, create_task, gather, sleep
from asyncio import Runner as AsyncRunner
import struct
import argparse

from statemachine import StateMachine

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

import importlib
import sys


# Vars:
OUT_DIR     = pl.Path(__file__).parent / "dots"
FSM_DIR     = pl.Path(__file__).parent / "fsms"
FSM_PREFIX  = "fsms."

##-- argparse
#see https://docs.python.org/3/howto/argparse.html
parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
                                 epilog = "\n".join(["Generate graphviz dot files for FSMs"]))
parser.add_argument('--all', action="store_true")
parser.add_argument("targets", action="append", default=[], nargs="?")
##-- end argparse
#args.aBool...

# Body:

def exit_handler():
    print("-- Exiting")
    return

async def write_fsm(fsm:type[StateMachine]) -> None:
    """ Export a statemachine as a .dot description """
    fsm       = fsm()
    fsm_name  = type(fsm).__name__
    text      = fsm._graph().to_string()
    target    = OUT_DIR / f"{fsm_name}.dot"
    target.write_text(text)

async def async_init (targets:list[str]):
    if not bool(targets):
        return
    tasks = []
    for targ in targets:
        mod = importlib.import_module(f"{FSM_PREFIX}{targ}")
        for x in mod.__all__:
            obj = getattr(mod, x)
            if not issubclass(obj, StateMachine):
                continue
            tasks.append(write_fsm(obj))
        else:
            print(f"-- Queued: {targ}")
    else:
        print(f"-- All Targets Queued")
        await asyncio.gather(*tasks)

def main():
    # Extend the python path
    sys.path.append(FSM_DIR)
    args = parser.parse_args()
    if args.all:
        args.targets = [x.stem for x in FSM_DIR.iterdir() if x.stem[0] != "_" and x.is_file()]

    atexit.register(exit_handler)
    with AsyncRunner() as runner:
         runner.run(async_init(args.targets))

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
