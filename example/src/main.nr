// Looping - over a range, over a list by index, using for-each style

// Tuples - accessing (.0, .1) and unpacking into several vars (abi does not support tuple types)

// Arrays

use dep::std;

global RATE_IN_PERCENT: Field = 5;

struct Item {
    price: Field,
    quantity: Field,
    cost: Field
}

impl Item {
    fn new(price: Field, quantity: Field, cost:Field) -> Item {
        Item {price, quantity, cost}
    }

    fn check_cost(self) -> bool {
        self.price * self.quantity == self.cost
    }
}

fn main(items: [Item; 2]) -> pub Field {
    assert(items.all(|i:Item| i.check_cost()));

    let mut total = items.fold(0, |x, i: Item| x + i.cost );

    if (total as u4 > 8) {
        total + (total * 5)/100
    } else {
        total
    }
}

#[test]
fn test_main() {
    let item1 = Item { price: 1, quantity: 1, cost: 1 };
    let item2 = Item::new(2, 4, 8);
    let items = [item1, item2];
    let total = main(items);
    std::println(total);
    assert (total == 3283236430775891283336960861788591263282254660062405151554730627986371274352);
}

