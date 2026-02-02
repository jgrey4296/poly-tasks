#!/usr/bin/env python3
"""


"""
# ruff.ignore.in.file
from __future__ import annotations
import logging as logmod

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

import math
import sympy
# Vars:

# Body:

val = sympy.sqrt(8)
print(f"Symbolic sqrt: {val}")
x, y = sympy.symbols('x y')
expr = x - 2*y + 4
print(f"Expr: {expr}")
basic = x * expr
print(f"Basic {basic}")
expanded = sympy.expand(x*expr)
print(f"Expanded: {expanded}")
factored =  sympy.factor(expanded)
print(f"Factored: {factored}")
derive_y = sympy.diff(basic, y)
derive_x = sympy.diff(basic, x)
print(f"Derivative basic/dy: {derive_y}")
print(f"Derivative basic/dx: {derive_x}")
