// __ -*- mode: rustic -*-
//
//
//

// //--// imports
use std::io;
use log::{info, trace, warn};
// //--// end imports

// //--// public fns

// //--// end public fns


// #[repr(C)]
// pub struct SimpleStruct {
//     pub x: cty::c_int,
//     pub y: cty::c_int,
// }

// #[link(name="simple")]
// unsafe extern "C" {
//     pub fn simple_struct_fn(
//         x: cty::c_int,
//         y: cty::c_int,
//         ss: *mut SimpleStruct
//     );

//     fn simple_test_fn() -> size_t;
// }



// //--// tests
#[cfg(test)]
#[test]
fn test_basic() {
    assert!(True);
}

// //--// end tests
