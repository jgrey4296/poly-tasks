//  lib.rs -*- mode: rust -*-
use pyo3::prelude::*;
use {{cookiecutter.proj_name}}_lib_rs;

// module name needs to match lib.name in cargo.toml
#[pymodule]
#[pyo3(name="_rust")]
pub fn init_module(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(do_sum, m)?)?;
    Ok(())
}

/// Formats the sum of two numbers as string.
#[pyfunction]
pub fn do_sum(a: usize, b: usize) -> PyResult<usize> {
    Ok((a+b))
}
