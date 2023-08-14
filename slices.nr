use dep::std;

fn main() {
    // initialize
    let mut slice = [50; 2];
    
    // assign
    slice[0] = 10;
    
    // push_back
    slice = slice.push_back(20);
    assert(slice.len() == 3);

    // push_front
    slice = slice.push_front(10);
    assert(slice.len() == 4);
    assert(slice[0] == 10);

    // pop_back
    let (slice, _) =  slice.pop_back();
    assert(slice.len() == 3);
    
    // pop_front
    let mut (slice, elem) =  slice.pop_back();
    assert(slice.len() == 2);
    assert(elem == 50);

    // insert at index
    slice = slice.insert(2, 100);
    assert(slice[2] == 100);
    
    // remove at index
    let  (_, removed) = slice.remove(2);    
    assert(removed == 100);

    // append two slices
    let append = [1,2].append([3,4,5]);
    assert(append.len() == 5);
    assert(append[0] == 1);
    assert(append[4] == 5);
}


#[test]
fn test_slices() {
    main();
}