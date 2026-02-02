// __main.rs -*- mode: rustic -*-
//
//
//

// Bindgen's c->rs conversions
include!(concat!(env!("OUT_DIR"), "/bindings.rs"));

use std::{
    alloc::{Layout, alloc, dealloc, handle_alloc_error},
    mem,
};
use libc;

fn main() {
    println!("Starting C Examples");
    simple_call();
    println!("----");
    simple_create_struct();
    println!("----");
    simple_ptr_conversion();
    println!("----");
    call_struct_ctor();
    println!("----");
    let mybox = get_boxed_struct();
    println!("The retrieved struct is: {} {}", mybox.x, mybox.y);
    println!("----");
    raw_ptr_init();
    println!("----");
    malloc_struct();
    println!("----");
    wrapped_struct();
}

/// Call C Fn
fn simple_call() {
    unsafe {
        simple_test();
    }
}

/// Create a struct in rust
fn simple_create_struct() {
    // Create C struct
    // Doesn't need to be unsafe.
    let val = SimpleStruct { x:2, y:14 };

    println!("The rust created struct is: {} {}", val.x, val.y);
}

/// Pass a ptr of a struct
fn simple_ptr_conversion() {
    let mut val = SimpleStruct { x:2, y:14 };
    println!("The struct is: {} {}", val.x, val.y);
    unsafe {
        // convert to pointer
        struct_init_address(2, 3, &raw mut val);
    }
    println!("The struct after modification is: {} {}", val.x, val.y);
}

/// Get a created struct from c
fn call_struct_ctor() {
    let mut val: Box<SimpleStruct>;
    unsafe {
        val = Box::from_raw(struct_ctor(2, 13));
    }
    println!("The struct created in C is: {} {}", val.x, val.y);
    unsafe {
        struct_init_address(10, 10, &raw mut *val);
    }
    println!("The struct after modification is: {} {}", val.x, val.y);
}

/// Create a boxed struct and return it
fn get_boxed_struct() -> Box<SimpleStruct> {
    let val: Box<SimpleStruct>;
    unsafe {
        val = Box::from_raw(struct_ctor(20, 20));
    }
    val
}

/// Create a raw pointer for initialisation
fn raw_ptr_init(){
    let boxed: Box<SimpleStruct>;
    let layout = Layout::new::<SimpleStruct>();
    unsafe {
        // Create a pointer and populate
        let ptr: *mut SimpleStruct = (alloc(layout) as *mut SimpleStruct);
        if ptr.is_null() {
            handle_alloc_error(layout);
        }
        struct_init_address(2,3, ptr);
        boxed = Box::from_raw(ptr);
    }
    println!("Raw ptr value is: {} {}", boxed.x, boxed.y);
}

/// Malloc a ptr
fn malloc_struct () {
    let ptr: *mut SimpleStruct;
    unsafe {
        ptr = libc::malloc(mem::size_of::<SimpleStruct>()) as *mut SimpleStruct;
        struct_init_address(2, 33, ptr);
        println!("The Malloced value is: {} {}", (*ptr).x, (*ptr).y);
        libc::free(ptr as *mut libc::c_void);
    }
}

// //  --------------------------------------------------
// Wrapping in newtype for dropping and deref.
// https://www.effective-rust.com/ffi.html#lifetimes
struct SSWrapper(*mut SimpleStruct);

impl SSWrapper {
    fn new(x: cty::c_int, y: cty::c_int) -> SSWrapper {
        unsafe { SSWrapper(struct_ctor(x, y)) }
    }
}

impl Drop for SSWrapper {
    fn drop(&mut self) {
        // free from the c side.
        unsafe { free_struct(self.0) }
    }
}

impl std::ops::Deref for SSWrapper {
    type Target = SimpleStruct;

    fn deref(&self) -> &SimpleStruct {
        unsafe { &*(self.0) as &SimpleStruct }
    }
}

impl std::ops::DerefMut for SSWrapper {
    fn deref_mut(&mut self) -> &mut Self::Target {
        unsafe { &mut *(self.0) as &mut SimpleStruct }
    }
}

/// C side malloc and free, wrapped in SSWrapper
fn wrapped_struct() {
    let mut val: SSWrapper = SSWrapper::new(12, 16);
    println!("The Wrapped struct is: {} {}", val.x, val.y);
    pass_wrapper(&mut val);
    println!("The Wrapped struct is: {} {}", val.x, val.y);
    borrow_wrapper(&val);
    take_wrapper(val);
    // value is not longer valid here
}

fn pass_wrapper(val: &mut SSWrapper) {
    println!("The borrowed value is being mutated: {} {}", val.x, val.y);
    val.x += 5;
}

fn borrow_wrapper(val: &SSWrapper) {
    println!("The borrowed struct is: {} {}", val.x, val.y);
}

fn take_wrapper(val: SSWrapper) {
    println!("The wrapper is now owned: {} {}", val.x, val.y);
}
