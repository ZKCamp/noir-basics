use dep::std;
use dep::std::unsafe::zeroed;
use dep::u2b;

fn main() {

    // Field to bit, [u1]
    let a: Field = 100;
    let a_bits = a.to_be_bits(32);
    std::println(slice_to_array(a_bits));

    // Field to bytes, [u8]
    let a_bytes = a.to_be_bytes(32);
    std::println(slice_to_array(a_bytes));

    // Field to u32, u4 (beware of underflow)
    std::println(a as u32);
    std::println(a as u4);

    
    let num: u16 = 256;

    let num_arr = u2b::u16_to_u8(num);
    std::println(num_arr);

    let num: u64 = 123451224112;
    std::println(num);

    let num_arr: [u8; 8] = u2b::u64_to_u8(num);
    std::println(num_arr);

    let num: u64 = u8_to_u64(num_arr);
    std::println(num);
}

fn slice_to_array<T>(s: [T]) -> [T; 32] {
    let mut arr: [T; 32]  = [std::unsafe::zeroed(); 32];
    for i in 0..32 {
        arr[i] = s[i];
    }
    arr
}

fn u8_to_u64(num_arr: [u8; 8]) -> u64 {
    let mut out: u64 = 0;
    let mut v: u64 = 1;
    for i in 0..8 {
        out += num_arr[7 - i] as u64 * v;
        v *= 256;
    }
    out
}


#[test]
fn test_conversions() {
    main();
}