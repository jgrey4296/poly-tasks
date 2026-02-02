# #  __init__.py -*- mode: Python -*-
"""
A Submodule for handling rust interaction

"""
from importlib import metadata

__version__ = metadata.version("{{cookiecutter.proj_name}}_bridge_py_rs")

from . import _rust
