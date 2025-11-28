#!/usr/bin/env -S uv run --script
"""
Utility script to extract tagged bookmarks from firefox,
and save them in the repo's main bookmarks file

https://wiki.mozilla.org/images/d/d5/Places.sqlite.schema3.pdf

"""
# ruff: noqa:
from __future__ import annotations

# Imports:
# ##-- stdlib imports
import datetime
import sys
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

from collections import defaultdict
from shutil import copy
import tempfile
import sqlalchemy as alc
from sqlalchemy import orm
from jgdv.files.bookmarks import Bookmark, BookmarkCollection

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
ECHO            : Final[bool]     = False
BOOKMARKS_FILE  : Final[pl.Path]  = pl.Path(envirion['BIBLIO_TOTAL_BOOKMARKS'])
FIREFOX         : Final[pl.Path]  = pl.Path(environ['BIBLIO_FIREFOX_LOX'])
DB_FILE         : Final[str]      = "places.sqlite"
TEMP_DB         : Final[pl.Path]  = pl.Path(environ['POLYGLOT_TEMP']) / "temp.sqlite"

##--| argparse
import argparse
parser = argparse.ArgumentParser(
    prog="biblio bookmarks",
    description="Extract firefox bookmarks and add to repo",
)


##--| ORM
class Base(orm.DeclarativeBase):
    pass

class DBBookmark(Base):
    """
    CREATE TABLE moz_bookmarks (
     id INTEGER PRIMARY KEY
     type INTEGER
     fk INTEGER DEFAULT NULL
     parent INTEGER
     position INTEGER
     title LONGVARCHAR
     keyword_id INTEGER
     folder_type TEXT
     dateAdded INTEGER
     lastModified INTEGER
     guid TEXT
     syncStatus INTEGER NOT NULL DEFAULT 0
     syncChangeCounter INTEGER NOT NULL DEFAULT 0);
    """
    __tablename__ = "moz_bookmarks"
    id                 : orm.Mapped[int] = orm.mapped_column(primary_key=True)
    type               : orm.Mapped[int]
    fk                 : orm.Mapped[int]
    parent             : orm.Mapped[int]
    position           : orm.Mapped[int]
    title              : orm.Mapped[str]
    keyword_id         : orm.Mapped[int]
    folder_type        : orm.Mapped[str]
    dateAdded          : orm.Mapped[int]
    lastModified       : orm.Mapped[int]
    guid               : orm.Mapped[str]
    syncStatus         : orm.Mapped[int]
    syncChangeCounter  : orm.Mapped[int]

class DBUrl(Base):
    """
    CREATE TABLE moz_places (
     id INTEGER PRIMARY KEY
     url LONGVARCHAR
     title LONGVARCHAR
     rev_host LONGVARCHAR
     visit_count INTEGER DEFAULT 0
     hidden INTEGER DEFAULT 0 NOT NULL
     typed INTEGER DEFAULT 0 NOT NULL
     frecency INTEGER DEFAULT -1 NOT NULL
     last_visit_date INTEGER
     guid TEXT
     foreign_count INTEGER DEFAULT 0 NOT NULL
     url_hash INTEGER DEFAULT 0 NOT NULL
     description TEXT
     preview_image_url TEXT
     site_name TEXT
     origin_id INTEGER REFERENCES moz_origins(id)
     recalc_frecency INTEGER NOT NULL DEFAULT 0
     alt_frecency INTEGER
     recalc_alt_frecency INTEGER NOT NULL DEFAULT 0);
    """
    __tablename__ = "moz_places"
    id                   : orm.Mapped[int] = orm.mapped_column(primary_key=True)
    url                  : orm.Mapped[str]
    title                : orm.Mapped[str]
    rev_host             : orm.Mapped[str]
    visit_count          : orm.Mapped[int]
    hidden               : orm.Mapped[int]
    typed                : orm.Mapped[int]
    frecency             : orm.Mapped[int]
    last_visit_date      : orm.Mapped[int]
    guid                 : orm.Mapped[str]
    foreign_count        : orm.Mapped[int]
    url_hash             : orm.Mapped[int]
    description          : orm.Mapped[str]
    preview_image_url    : orm.Mapped[str]
    site_name            : orm.Mapped[str]
    origin_id            : orm.Mapped[int]
    recalc_frecency      : orm.Mapped[int]
    alt_frecency         : orm.Mapped[int]
    recalc_alt_frecency  : orm.Mapped[int]

##--| Body

def find_db() -> Maybe[pl.Path]:
    if TEMP_DB.exists():
        return None

    base = FIREFOX
    match list(base.glob("*.default")):
        case [x]:
            assert((x / DB_FILE).exists())
            return x / DB_FILE
        case _:
            raise ValueError("Too many potential profiles")

def extract_bookmarks(loc:pl.Path) -> BookmarkCollection:
    print("Extracting bookmarks")
    assert(loc.resolve().exists())
    fresh          = BookmarkCollection()
    meta           = alc.MetaData()
    engine         = alc.create_engine(f"sqlite:///{loc!s}", echo=ECHO)
    bkmks          = alc.Table("moz_bookmarks", meta, autoload_with=engine)
    urls           = alc.Table("moz_places", meta, autoload_with=engine)

    sel_tags_stmt  = alc.select(DBBookmark).where(DBBookmark.parent == 4)
    sel_url_stmt   = alc.select(DBBookmark, DBUrl.url).where(DBBookmark.fk == DBUrl.id)
    tags           = {}
    bkmks          = defaultdict(set)

    with orm.Session(engine) as sess:
        # Construct tags mapping
        print("Getting Tags")
        for x in sess.scalars(sel_tags_stmt):
            tags[x.id] = x.title
        else:
            pass

        print("Getting urls")
        for x,y in sess.execute(sel_url_stmt):
            if x.parent not in tags:
                continue

            bkmks[y].add(tags[x.parent])
        else:
            print("Building Bookmarks")
            fresh.update({Bookmark(url=x, tags=y) for x,y in bkmks.items()})

    return fresh

def main():
    args = parser.parse_args()
    # copy from firefox
    match find_db():
        case None:
            copied = TEMP_DB
        case pl.Path() as db:
            copied  = copy(db, TEMP_DB)

    # extract bookmarks
    fresh        = extract_bookmarks(copied)
    fresh_count  = len(fresh)
    print(f"Extracted {fresh_count} bookmarks")
    # load current
    current        = BookmarkCollection.read(BOOKMARKS_FILE)
    current_count  = len(current)
    print(f"Current Total Count: {current_count}")
    # integrate new
    current.update(fresh)
    updated_count = len(current)
    change = (current_count - updated_count) * -1
    print(f"Updated count: {updated_count} ({change:+d})")
    current.merge_duplicates()
    merged_count = len(current)
    change = (updated_count - merged_count) * -1
    print(f"Merged count: {merged_count} ({change:+d})")
    change_count = (current_count - merged_count) * -1
    print(f"Final Change: {change_count:+d}")
    # save
    print("Saving updated totals")
    BOOKMARKS_FILE.write_text(str(current))
    TEMP_DB.unlink()

##-- ifmain
if __name__ == "__main__":
    main()
##-- end ifmain
