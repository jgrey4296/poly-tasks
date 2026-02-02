#!/usr/bin/env python3
"""


"""
#
from __future__ import annotations

# Imports:
# ##-- stdlib imports
from copy import deepcopy
from uuid import UUID, uuid1
from weakref import ref
from asyncio import Runner as AsyncRunner
from asyncio import (
     create_task, gather, sleep, timeout, shield,
     to_thread, current_task, all_tasks,
     TaskGroup,
     CancelledError,
)
import asyncio
import atexit
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
import sys
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

# Vars:

# Body:
def exit_handler():
    print("Exiting")
    return

async def async_init ():
      pass

def main():
    atexit.register(exit_handler)
    with AsyncRunner() as runner:
         runner.run(async_init())

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
