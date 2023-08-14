use dep::std;

struct Bar<T> {
    one: Field,
    two: Field,
    other: T
}

impl<T> Bar<T> {
    fn get_other(self) -> T {
        self.other
    }
}

fn main() {
    let bar1: Bar<Field> = Bar { one: 1, two: 2, other: 3};
    let bar2: Bar<[Field; 1]> = Bar { one: 1, two: 2, other: [0]};
    let nested_generics: Bar<Bar<Field>> = Bar { one : 1 , two : 2 , other : Bar { one : 1, two : 2, other: 3}};
    assert(bar1.get_other() == bar1.other);
    assert(nested_generics.other.other == bar1.get_other());

}

#[test]
fn test_generics() {
    main();
}