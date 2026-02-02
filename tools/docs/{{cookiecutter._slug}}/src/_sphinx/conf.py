#!/usr/bin/env python3
"""
Configuration file for the Sphinx documentation builder.
https://www.sphinx-doc.org/en/master/usage/configuration.html

CWD is the dir of this file.

- https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
- https://pygments.org/docs/lexers
- https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
- https://sphinx-rtd-theme.readthedocs.io/en/stable/configuring.html
- https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html
- https://sphinx-autoapi.readthedocs.io/en/latest/reference/config.html
- https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html
- https://www.sphinx-doc.org/en/master/usage/extensions/imgconverter.html
- https://www.sphinx-doc.org/en/master/usage/extensions/autosectionlabel.html
- https://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html
- https://www.sphinx-doc.org/en/master/usage/extensions/viewcode.html
- https://www.sphinx-doc.org/en/master/usage/extensions/graphviz.html
"""
# ruff: noqa: TC003, A001, DTZ005, ERA001, PLR2044, ARG001, ANN001, ANN201, TC002
from __future__ import annotations
##-- imports
import os
import sys
import pathlib as pl
import datetime
from collections.abc import Sequence, Callable
import tomllib
from typing import Literal
from docutils import nodes
from docutils.parsers.rst import directives
from docutils.statemachine import StringList
from sphinx.locale import __
from sphinx.util.docutils import SphinxDirective

##-- end imports

##-- types
exclude_patterns                      : list[str]
extensions                            : list[str]
highlight_options                     : dict
html_domain_indices                   : bool|Sequence[str]
html_additional_pages                 : dict
html_search_options                   : dict
html_js_files                         : list
html_sidebars                         : dict
html_static_path                      : list
html_theme_path                       : list
html_extra_path                       : list
html_style                            : list[str] | str
include_patterns                      : list[str]
needs_extensions                      : dict[str, str]
nitpick_ignore                        : set[tuple[str, str]]
nitpick_ignore_regex                  : set[tuple[str, str]]
source_suffix                         : dict[str, str]
templates_path                        : list[str]
napoleon_type_aliases                 : dict
python_maximum_signature_line_length  : int | None
autoapi_prepare_jinja_env : Callable[[jinja2.Environment], None] | None
type InterTuple      = tuple[str, tuple[str, str | None] | None]
intersphinx_mapping      : dict[str, InterTuple]
intersphinx_cache_limit  : int
intersphinx_timeout      : int | float | None
extlinks : dict[str, tuple[str, str]]
##-- end types

from os import environ

_proj_root  = pl.Path(environ["POLYGLOT_ROOT"])
_target     = _proj_root / "pyproject.toml"
assert(_target.exists())
pyproject  = tomllib.loads(_target.read_text())

##-- project settings
project                        = pyproject['project']['name']
author                         = "John Grey"
copyright                      = "{}, {}".format(datetime.datetime.now().strftime("%Y"), author)
language                       = "en"
release                        = pyproject['project']['version']

root_doc                       = "index"
primary_domain                 = "py"
default_role                   = None

root_doc                       = "index"
suppress_warnings               = [
    "docutils",
]
maximum_signature_line_length  = 50
toc_object_entries             = True
add_function_parentheses       = True
show_warning_types             = True
nitpick_ignore                 = set()
nitpick_ignore_regex           = set()

needs_extensions               = {
    # ExtName : Version
}
extensions                     = []

##-- end project settings

##-- locations
# Relative to this file/config directory:
templates_path    = [
    "../_data/templates",
    "../_data/templates/sphinx",
]
html_theme_path   = []
html_static_path  = ["../_data/static"]
html_extra_path   = []  # for things like robots.txt

# Relative to html_static_path , or fully qualified urls:
html_css_files       = [
    "custom.css",
]
html_js_files        = [
    "custom.js",
]

# Relative to source directory:
autoapi_template_dir  = "_data/templates/autoapi"
# look in here:
autoapi_dirs          = ["."]
# generate to here,
# (sync with any toctree mention)
autoapi_root          = "_sphinx/_autoapi"


# load path modification:
# local_mod = str(pl.Path.cwd().parent.parent)
# sys.path.insert(0, local_mod)

##-- end locations

##-- file types
source_suffix = {
    ".rst"  : "restructuredtext",
    # ".txt"  : "restructuredtext",
    # ".md"   : "markdown",
    # ".bib"  : "bibtex"
}

##-- end file types

##-- exclusion
# List of patterns, relative to *source directory*, that match files and
# directories to incldue/ignore when looking for source files.
# These also affect html_static_path and html_extra_path.
include_patterns = [
    "**",
    ]
exclude_patterns = [
    "*_bridge_*",
]
autoapi_ignore   = exclude_patterns

# ignore doc directories
# and polyglot util directories
exclude_patterns += [
    "_book/*",
    "_changes/*",
    "_tests/**",
    "_data/**",
    # "_*",
]

# ignore non-python subprojects
exclude_patterns += [
    # "./asp_*",
    # "./c_*",
    # "./cs_*",
    # "./el_*",
    # "./fs_*",
    # "./gd_*",
    # "./kt_*",
    # "./pl_*",
    # "./rq_*",
    "rs_*",
]
# ignore tests and util files
exclude_patterns += [
    "**/__tests/*",
    "**/flycheck_*.py",
    "*/_sphinx/conf.py",
    "**/test_integration.py",
    "**/__examples/*",
    "README.md",
]

##-- end exclusion

##-- templates
# Fully qualified class of TemplateBridge
# template_bridge = ""

##-- end templates

##-- html
html_use_index                = True
html_split_index              = False
html_permalinks               = True
html_copy_source              = True
html_show_sourcelink          = True
html_show_search_summary      = False
html_codeblock_linenos_style  = "inline"  # or "table"
# --
html_theme_options     = {}
html_sidebars          = {} # Maps doc names -> templates
html_additional_pages  = {} # Maps doc names -> templates
html_context           = {}
html_search_options    = {}
# html_domain_indices  = True
html_domain_indices    = []
# html_style           = []
# html_logo            = ""
# html_favicon         = ""
# Generate additional domain specific indices
# html_additional_pages.update({})

##-- end html

##-- readthedocs theme
extensions.append("sphinx_rtd_theme")
html_theme                = "sphinx_rtd_theme"
html_theme_options.update({
    "logo_only"                   : False,
    # "version_selector"             : True,
    "prev_next_buttons_location"  : "bottom",
    "style_external_links"        : False,
    "vcs_pageview_mode"           : "",
    "style_nav_header_background" : "grey",
    # TOC options:
    "collapse_navigation"         : True,
    "sticky_navigation"           : True,
    "navigation_depth"            : 4,
    "includehidden"               : True,
    "titles_only"                 : False,
})

##-- end readthedocs theme

##-- markdown
# extensions.append("myst_parser")

##-- end markdown

##-- rst preprocessing
# rst_prolog = ""
# rst_epilog = ""

##-- end rst preprocessing

##-- python domain
add_module_names                                = True
python_display_short_literal_types              = False
python_trailing_comma_in_multi_line_signatures  = True
python_user_unqualified_type_names              = False
trim_doctest_flags                              = True
# Remove prefixes for indexiing
modindex_common_prefix                = [
    "polyglot.",
]
python_maximum_signature_line_length  = None
html_context.update({
    "collapse_index_py": True,
})
match html_domain_indices:
    case list():
        html_domain_indices.append("py-modindex")
    case _:
        pass
##-- end python domain

##-- bibtex domain
# extensions.append("sphinx_bib_domain")
bib_domain_split_index = True
##-- end bibtex domain

##-- pygments syntax highlighting

highlight_options              = {}
pygments_style                 = "sphinx"

##-- end pygments syntax highlighting

# -- c: Extension Options ----------------------

##-- autodoc
# https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html
#-- Events
# autodoc-process-docstring
# autodoc-before-process-signature
# autodoc-process-signature
# autodoc-process-bases
# autodoc-skip-member
#--
# extensions.append("sphinx.ext.autodoc")
#
autodoc_inherit_docstrings   = False
autodoc_docstring_signature  = True
autodoc_preserve_defaults    = False
autodoc_use_type_comments    = True
autodoc_warningiserror       = True
#
autoclass_content                     = "class"
autodoc_typehints                     = "description"
autodoc_typehints_format              = "short"
autodoc_typehints_description_target  = "all"
autodoc_class_signature               = "mixed"
autodoc_member_order                  = "alphabetical"
#
autodoc_default_options  = {}
autodoc_type_aliases     = {}
autodoc_mock_imports     = []

##-- end autodoc

##-- autosummary
# Generate autodocs:
# https://www.sphinx-doc.org/en/master/usage/extensions/autosummary.html
# customize templates in autosummary/*.rst
extensions.append("sphinx.ext.autosummary")
#
autosummary_generate            = True
autosummary_generate_overwrite  = True
autosummary_imported_members    = False
autosummary_ignore_module_all   = True
#
autosummary_mock_imports  = []
autosummary_context       = {}
autosummary_filename_map  = {}

##-- end autosummary

##-- autoapi
# Generates API by parsing, not importing:
# https://sphinx-autoapi.readthedocs.io/en/latest/
#-- Events
# 'autoapi-skip-member' : Callable[[app, what, name, obj, skip, options], bool|None]
#--
extensions.append("autoapi.extension")
# extensions.append("sphinx.ext.inheritance_diagram")
#
suppress_warnings += [
    # "autoapi",
    # "autoapi.python_import_resolution",
    # "autoapi.not_readable",
    # "autoapi.toc_reference",
    # "autoapi.nothing_rendered",
]

# For keeping generated files:
autoapi_keep_files                      = False
autoapi_generate_api_docs               = True
autoapi_python_use_implicit_namespaces  = False
# If false, manual toctree entry,
# (eg: _docs/autoapi/jgdv/index) needs to be added:
autoapi_add_toctree_entry  = False
autoapi_type               = "python"
# Whether to use class docstring ro __init__ docstring.
autoapi_python_class_content  = "class" # 'both' | 'init'
autoapi_own_page_level        = "module" # class | function | method | attribute
autoapi_file_patterns         = ["*.py", "*.pyi"]
# autoapi_ignore.append("*integration*")
autoapi_member_order          = "groupwise" # 'alphabetical' | 'bysource' | 'groupwise'
autoapi_options               = [
    # "imported-members",
    # "inherited-members",
    # "show-inheritance-diagram",
    "members",
    "undoc-members",
    "private-members",
    "special_members",
    "show-inheritance",
    "show-module-summary",
]
##-- end autoapi

##-- external links
# Shorten external links: https://www.sphinx-doc.org/en/master/usage/extensions/extlinks.html
# extensions.append("sphinx.ext.extlinks")
#
extlinks_detect_hardcoded_links = False
# create roles to simplify urls. format: {rolename: [linkpattern, caption]}
extlinks = {
    # Add ':issue:' role:
    "issue": ("https://github.com/jgrey4296/jgdv/issues/%s", "issue %s"),
}

##-- end external links

##-- doctest
# Runs docstring code?
# https://www.sphinx-doc.org/en/master/usage/extensions/doctest.html
# extensions.append("sphinx.ext.doctest")

##-- end doctest

##-- intersphinx
# Link to other projects:
# https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html
# extensions.append("sphinx.ext.intersphinx")
# Map to other documentation using :external:
intersphinx_mapping = {
    # eg: :external+python:ref:`comparisons`
    "python" : ("https://docs.python.org/3", None),

}
intersphinx_cache_limit  = 5 # days
intersphinx_timeout      = None

##-- end intersphinx

##-- graphviz
# https://www.sphinx-doc.org/en/master/usage/extensions/graphviz.html
extensions.append("sphinx.ext.graphviz")
# Command name to invoke dot:
graphviz_dot            =  "dot"
graphviz_dot_args       = ()
graphviz_output_format  = "svg"  # or "dot"

##-- end graphviz

##-- plantuml
# https://github.com/sphinx-contrib/plantuml/
extensions.append("sphinxcontrib.plantuml")
plantuml_output_format = "svg"

##-- end plantuml

##-- image conversion
# imagemagick conversion: https://www.sphinx-doc.org/en/master/usage/extensions/imgconverter.html
# extensions.append("sphinx.ext.imgconverter")
image_converter       = "convert"
image_converter_args  = ()

##-- end image conversion

##-- auto-section labels
# Reference sections by title: https://www.sphinx-doc.org/en/master/usage/extensions/autosectionlabel.html
# extensions.append("sphinx.ext.autosectionlabel")
# If true, ref is :ref:`docname:title`, else :ref:`title`
autosectionlabel_prefix_document  : bool        = False
autosectionlabel_maxdepth         : int | None  = None

##-- end auto-section labels

##-- napoleon docstrings
# Alternative docstring formats
# https://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html
# extensions.append("sphinx.ext.napoleon")
napoleon_google_docstring               = True
napoleon_numpy_docstring                = True
napoleon_include_init_with_doc          = False
napoleon_include_private_with_doc       = False
napoleon_include_special_with_doc       = True
napoleon_use_admonition_for_examples    = False
napoleon_use_admonition_for_notes       = False
napoleon_use_admonition_for_references  = False
napoleon_use_ivar                       = False
napoleon_use_param                      = True
napoleon_use_rtype                      = True
napoleon_preprocess_types               = False
napoleon_attr_annotations               = True
napoleon_type_aliases                   = {}

##-- end napoleon docstrings

##-- viewcode
# Link descriptions to code:
# https://www.sphinx-doc.org/en/master/usage/extensions/viewcode.html
# extensions.append("sphinx.ext.viewcode")
#-- Events:
# viewcode-find-source(app, modname) -> tuple[str, dict]
# viewcode-follow-imported(app, modname, attribute)
#--
# Blocks 'viewcode-follow-imported' event:
viewcode_follow_imported_members  = False
viewcode_enable_epub              = False
viewcode_line_numbers             = True

def no_import_viewcode_find_source(app, modname) -> tuple[str, dict]:
    """TODO Event handler to find sourcecode *without* importing it"""
    type SourceCode  = str
    type Definition  = str
    type LineNum     = int
    type Tag         = Literal["class"] | Literal["def"] | Literal["other"]
    type TagsDict    = dict[str, dict[Definition, tuple[Tag, LineNum, LineNum]]]
    tags    : TagsDict
    source  : SourceCode
    #--
    source  = ""
    tags    = {}

    # Find the file
    # Parse the File
    # Map to dict
    # return
    # return (source, tags)
    raise NotImplementedError()

##-- end viewcode

##-- test coverage
# Build test coverage reports:
# https://www.sphinx-doc.org/en/master/usage/extensions/coverage.html
# extensions.append("sphinx.ext.coverage")

##-- end test coverage

# -- d: Sphinx App Customisation ---------------
##-- jinja customisation
try:
    import jinja2
except ImportError:
    jinja2 = None
else:

    def filter_contains(val:list|str, *needles:str) -> bool:
        match val:
            case str():
                return any(x in val for x in needles)
            case list():
                joined = " ".join(val)
                return any(x in joined for x in needles)
            case _:
                return False

    def autoapi_prepare_jinja_env(jinja_env: jinja2.Environment) -> None:
        """Add a custom jinja test """
        jinja_env.add_extension("jinja2.ext.debug")
        jinja_env.tests['contains'] = filter_contains

    def add_jinja_ext(app):
        app.builder.templates.environment.add_extension("jinja2.ext.debug")

##-- end jinja customisation

# -- Sphinx and Jinja configuration ------------

def setup(app):
    # if jinja2 is not None:
    #     app.events.connect("builder-inited", add_jinja_ext, 1)
    pass


# -- Debug output --------------------------------------------------
def pg_out(val):
    print(f"[polyglot]: {val}")

pg_out("Exclusion Patterns:")
for x in sorted(exclude_patterns):
    pg_out(f"- '{x}'")
else:
    pg_out("----")

pg_out("Active Extensions:")
for x in sorted(extensions):
    pg_out(f"- {x}")
else:
    pg_out("----")
    pg_out(f"CWD: {pl.Path.cwd()}")
    pg_out("initialisation complete")
