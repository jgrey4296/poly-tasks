"""

"""
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

import jinja2
from jgdv.files.tags import SubstitutionFile

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
TEMPLATE_DIR  : Final[pl.Path]  = pl.Path("templates_")
WINDOW_SIZE   : Final[int]      = 10
SUB_GLOB_1    : Final[str]      = "*/*.sub"
SUB_GLOB_2    : Final[str]      = "*.sub"
# Body:

def load_tags(source:pl.Path, *, norm:bool=True) -> SubstitutionFile:
    targets  = set()
    targets.update(collect(source, glob=SUB_GLOB_1))
    targets.update(collect(source, glob=SUB_GLOB_1))
    if norm:
        subs = SubstitutionFile()
    else:
        subs = SubstitutionFile(norm_regex=re.compile("^"), norm_replace="")

    for x in targets:
        subs.update(SubstitutionFile.read(x, norm_regex=subs.norm_regex, norm_replace=subs.norm_replace))
    else:
        assert(bool(subs))
        return subs

def collect(source:pl.Path, *, glob:str="*.bib") -> list[pl.Path]:
    if source.is_file():
        return [source]

    results = source.glob(glob)
    return list(sorted(results))

def init_jinja(dir:Maybe[pl.Path]=None) -> jinja2.Environment:
    env = jinja2.Environment(
        loader=jinja2.FileSystemLoader(dir or TEMPLATE_DIR),
        autoescape=jinja2.select_autoescape(),
        trim_blocks=True,
        lstrip_blocks=True,
        )
    return env

def window_collection(i:int, coll:list) -> list[pl.Path]:
    if i == -1:
        return coll

    start   = WINDOW_SIZE * i
    window  = coll[start:(start + WINDOW_SIZE)]
    return window
