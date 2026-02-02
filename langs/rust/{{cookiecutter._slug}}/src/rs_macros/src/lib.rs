// __lib.rs -*- mode: rustic -*-
//
//
//


// //--// module declarations
// pub mod ;
// //--// end module declarations

// //--// standard imports
use proc_macro::TokenStream;
use quote::quote;
use syn::{Attribute, DeriveInput, LitStr, parse_macro_input};
// //--// end standard imports

#[proc_macro_derive(Example)]
pub fn derive_example(input:TokenStream) -> TokenStream {
    input

}

#[proc_macro_attribute]
pub fn example_attr(_attr: TokenStream, item:TokenStream) -> TokenStream {
    _attr
}
