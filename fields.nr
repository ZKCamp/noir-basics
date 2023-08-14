use dep::std;

fn main(x: Field, y: Field) -> pub Field {
    x * y
    //assert (x * y == z);
}

#[test]
fn main_test() {
    let first = main(1, 2);
    let second = main(1, 2);
    std::println(f"b: {first} , a: {second}");
}