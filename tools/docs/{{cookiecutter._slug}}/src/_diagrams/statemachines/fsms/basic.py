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
"Basic",

)
# ##-- end Generated Exports

# The FSM:

class Basic(StateMachine):
    start  = State(initial=True)
    end    = State(final=True)

    go = start.to(end)

