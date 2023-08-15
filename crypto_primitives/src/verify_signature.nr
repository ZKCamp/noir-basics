use dep::std;

// --------------------------- LIBRARY FUNCTIONS START --------------------------- //
fn split_u8_64(
    arr: [u8; 64]
) -> ([u8; 32], [u8; 32]) {
    let mut arr_a: [u8; 32] = [0; 32];
    let mut arr_b: [u8; 32] = [0; 32];

    for i in 0..32 {
        arr_a[i] = arr[i];
        arr_b[i] = arr[i + 32];
    };

    (arr_a, arr_b)
}

fn address_from_public_key(pub_key: [u8; 64]) -> Field {
    let hashed_pub_key = std::hash::keccak256(pub_key, 64);

    let mut addr: Field = 0;
    for i in 0..20 {
        addr = (addr * 256) + hashed_pub_key[i + 12] as Field;
    }

    addr
}

// --------------------------- LIBRARY FUNCTIONS END --------------------------- //

fn verify_sig(pub_key: [u8; 64], signature: [u8; 64], hashed_message: [u8; 32]) -> Field {
    let (key_x, key_y) = split_u8_64(pub_key);

    let verified = std::ecdsa_secp256k1::verify_signature(key_x, key_y, signature, hashed_message);

    assert(verified == true);
    address_from_public_key(pub_key)
}

fn main(pub_key: [u8; 64], signature: [u8; 64], hashed_message: [u8; 32]) -> pub Field {
    let addr = verify_sig(pub_key, signature, hashed_message);

    addr
}

#[test]
fn test_signature_verification() {
    let pub_key = [131,  24,  83,  91,  84,  16,  93,  74,  122,  174,  96,  192,  143,  196,  95,  150,  135,  24,  27,  79,  223,  198,  37,  189,  26,  117,  63,  167,  57,  127,  237,  117,  53,  71,  241,  28,  168,  105,  102,  70,  242,  243,  172,  176,  142,  49,  1,  106,  250,  194,  62,  99,  12,  93,  17,  245,  159,  97,  254,  245,  123,  13,  42,  165];
    let signature = [1,  83,  82,  167,  184,  77,  226,  104,  5,  27,  151,  91,  202,  127,  17,  183,  75,  31,  190,  253,  159,  116,  155,  13,  24,  178,  40,  165,  129,  90,  103,  204,  42,  164,  230,  62,  73,  181,  169,  61,  251,  221,  128,  221,  14,  19,  179,  25,  107,  132,  10,  188,  149,  0,  197,  52,  151,  239,  244,  103,  215,  224,  56,  242];
    let hashed_message = [3,  57, 199, 96, 145, 58, 183, 241, 206, 140, 36, 34, 165, 163, 17, 210, 97, 254, 154, 79, 91, 223, 149, 18, 3, 210, 111, 56, 246, 219, 19, 104];

    let expected_addr = 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266;
    let actual_addr = main(pub_key, signature, hashed_message);

    assert( actual_addr == expected_addr );
}