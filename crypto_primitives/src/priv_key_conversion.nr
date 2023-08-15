use dep::std;
use dep::u2b;

use dep::std::slice;

// -------------------------------------- LIBRARY FUNCTIONS START -------------------------------------- //

// Can be unconstrained
fn u8_32_to_u8_64(
    arr_a: [u8; 32],
    arr_b: [u8; 32],
) -> [u8; 64] {
    let mut combined: [u8; 64] = [0; 64];

    for i in 0..32 {
        combined[i] = arr_a[i];
    }
    for i in 0..32 {
        combined[i + 32] = arr_b[i];
    }

    combined
}

// -------------------------------------- LIBRARY FUNCTIONS END -------------------------------------- //

fn main(priv_key: Field) -> pub [Field; 2] {
    std::scalar_mul::fixed_base(priv_key)
}

fn address_from_public_key(pub_key: [u8; 64]) -> Field {
    let hashed_pub_key = std::hash::keccak256(pub_key, 64);

    let mut addr: Field = 0;
    for i in 0..20 {
        addr = (addr * 256) + hashed_pub_key[i + 12] as Field;
    }

    addr
}

fn u256_to_u8(key: Field) -> [u8; 32]{
    let key_x_from_field = key.to_be_bytes(32);

    let mut ret_key: [u8; 32] = [0; 32];

    for idx in 0..32 {
        ret_key[idx] = key_x_from_field[idx];
    }

    ret_key
}

#[test]
fn test_pub_key_generation() {
    let priv_key = 0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b;

    let pub_key = std::scalar_mul::fixed_base(priv_key);

    std::println(pub_key);

    let pub_x = u256_to_u8(pub_key[0]);
    let pub_y = u256_to_u8(pub_key[1]);

    let pub_key_u64 = u8_32_to_u8_64(pub_x, pub_y);

    let address = address_from_public_key(pub_key_u64);
    std::println(address);
}
