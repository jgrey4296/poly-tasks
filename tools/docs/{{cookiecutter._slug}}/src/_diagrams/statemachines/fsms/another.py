"""

"""
# ruff: noqa:

# Imports:
from __future__ import annotations

import pathlib as pl

from statemachine import StateMachine, State

# ##-- Generated Exports
__all__ = ( # noqa: RUF022

# -- Classes
"Another",

)
# ##-- end Generated Exports

# The FSM:

class Another(StateMachine):
    start  = State(initial=True)
    mid1   = State()
    mid2   = State()
    end    = State(final=True)

    go     = start.to(mid1) | start.to(mid2) | end.from_(mid1, mid2)
