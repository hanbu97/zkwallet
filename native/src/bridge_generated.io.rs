use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_platform(port_: i64) {
    wire_platform_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_rust_release_mode(port_: i64) {
    wire_rust_release_mode_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_multiply_zk(port_: i64, a: i32, b: i32) {
    wire_multiply_zk_impl(port_, a, b)
}

#[no_mangle]
pub extern "C" fn wire_generate_wallet_multi(
    port_: i64,
    password: *mut wire_uint_8_list,
    length: u8,
    lang: *mut wire_uint_8_list,
    params: *mut wire_uint_8_list,
    chain: *mut wire_uint_8_list,
) {
    wire_generate_wallet_multi_impl(port_, password, length, lang, params, chain)
}

#[no_mangle]
pub extern "C" fn wire_generate_wallet(
    port_: i64,
    ss58: u16,
    password: *mut wire_uint_8_list,
    length: u8,
    lang: *mut wire_uint_8_list,
) {
    wire_generate_wallet_impl(port_, ss58, password, length, lang)
}

#[no_mangle]
pub extern "C" fn wire_generate_wallet_from_mnemonics_multi(
    port_: i64,
    chain: *mut wire_uint_8_list,
    password: *mut wire_uint_8_list,
    phrase: *mut wire_uint_8_list,
    lang: *mut wire_uint_8_list,
    params: *mut wire_uint_8_list,
) {
    wire_generate_wallet_from_mnemonics_multi_impl(port_, chain, password, phrase, lang, params)
}

#[no_mangle]
pub extern "C" fn wire_generate_wallet_from_mnemonics(
    port_: i64,
    ss58: u16,
    password: *mut wire_uint_8_list,
    phrase: *mut wire_uint_8_list,
    lang: *mut wire_uint_8_list,
) {
    wire_generate_wallet_from_mnemonics_impl(port_, ss58, password, phrase, lang)
}

#[no_mangle]
pub extern "C" fn wire_word_suggestion(
    port_: i64,
    word: *mut wire_uint_8_list,
    lang: *mut wire_uint_8_list,
) {
    wire_word_suggestion_impl(port_, word, lang)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
