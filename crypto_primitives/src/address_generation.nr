
use dep::std;

fn address_from_public_key(pub_key: [u8; 64]) -> Field {
    std::println(pub_key);
    let hash_of_public_key = std::hash::keccak256(pub_key, 32);
    std::println(hash_of_public_key);
    let mut result: Field = 0;
    let mut v: Field = 1;

    for i in 0..20 {
        result += hash_of_public_key[31 - i] as Field * v;
        v *= 256;
    }
    result
}

struct key {
        public_key_as_hex: str<128>,
        public_key_in_u8: [u8; 64],
        expected_address_as_hex: str<40>,
        expected_address_as_field: Field
    }

fn main() {
    
    // Used Python to get the byte array
    // >>> public_key = "6d7bac197da6e91f506db699a1844efc93b9bf5508bacb6870a98fc2137c4330741f94af61aa635a44f9059ff2082737d43cfb376124ae8772250b85f656aa1d"
    // >>> c2=[int(public_key[i:i+2],16) for i in range(0,len(public_key),2)]  
    // To convert to int used int("",16)

    let keys = [
        key {
            public_key_as_hex : "6d7bac197da6e91f506db699a1844efc93b9bf5508bacb6870a98fc2137c4330741f94af61aa635a44f9059ff2082737d43cfb376124ae8772250b85f656aa1d",
            public_key_in_u8 : [109 as u8, 123, 172, 25, 125, 166, 233, 31, 80, 109, 182, 153, 161, 132, 78, 252, 147, 185, 191, 85, 8, 186, 203, 104, 112, 169, 143, 194, 19, 124, 67, 48, 116, 31, 148, 175, 97, 170, 99, 90, 68, 249, 5, 159, 242, 8, 39, 55, 212, 60, 251, 55, 97, 36, 174, 135, 114, 37, 11, 133, 246, 86, 170, 29],
            expected_address_as_hex : "df92c554c0078eec90937d7a5944976ef31d602c",
            expected_address_as_field : 1276378040652000083123543424805442496024278818860
        },
        key {
            public_key_as_hex : "3b88b538dff7db813b6c8be6bfce81f6dd9d820213fe9211e9f5a631c360c7ddbb26690ae40eac62e0b5aaf2d8a5c4287e3c383fc1c00916ce12e354e1eb12eb",
            public_key_in_u8 : [59 as u8, 136, 181, 56, 223, 247, 219, 129, 59, 108, 139, 230, 191, 206, 129, 246, 221, 157, 130, 2, 19, 254, 146, 17, 233, 245, 166, 49, 195, 96, 199, 221, 187, 38, 105, 10, 228, 14, 172, 98, 224, 181, 170, 242, 216, 165, 196, 40, 126, 60, 56, 63, 193, 192, 9, 22, 206, 18, 227, 84, 225, 235, 18, 235],
            expected_address_as_hex : "622CF04ee8659bC45d76deF393077Ddcc5396761",
            expected_address_as_field : 560483262129028339421417742434801506800232916833
        },

    ];

    for i in 0..2 {
        let address = address_from_public_key(keys[i].public_key_in_u8);
        std::println(address);
        assert(address == keys[i].expected_address_as_field);
    }    
}

#[test]
fn tst_address_generation() {
    main();
}