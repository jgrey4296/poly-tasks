// //  bridge_el.rs -*- mode: Rustic -*-
//
//
//

use emacs::{defun, Env, Result, Value};


#[defun]
fn say_hello(env: &Env, name: String) -> Result<Value<'_>> {
    env.message(&format!("Hello: {} from rust", name))
}
