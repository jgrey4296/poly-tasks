//  lib.rs -*- mode: rust -*-
mod bridge_el;
use bridge_el::*;
use emacs;
use emacs::{Env, Result, Value};

emacs::plugin_is_GPL_compatible!();

#[emacs::module]
fn init(env: &Env) -> Result<Value<'_>> {
    env.message("Done Loading")
}
