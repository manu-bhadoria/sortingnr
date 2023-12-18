global MAX_SIZE: Field = 5; 

fn merge(arr: &mut [Field; MAX_SIZE], l: u64, m: u64, r: u64) {
    let n1 = m - l + 1;
    let n2 = r - m;    
    let mut L: [Field; MAX_SIZE] = [0; MAX_SIZE];
    let mut R: [Field; MAX_SIZE] = [0; MAX_SIZE];

    for i in 0..n1 {
        L[i] = arr[l + i];
    }
    for j in 0..n2 {
        R[j] = arr[m + 1 + j];
    }

    let mut i = 0;
    let mut j = 0;
    let mut k = l;

    for _ in 0..MAX_SIZE {
        if i < n1 & j < n2 {
            if L[i] as u64 <= R[j] as u64 {
                arr[k] = L[i];
                i += 1;
            } else {
                arr[k] = R[j];
                j += 1;
            }
            k += 1;
        }
    }
    
    for _ in 0..MAX_SIZE {
        if i < n1 {
            arr[k] = L[i];
            i += 1;
            k += 1;
        }
    }

    for _ in 0..MAX_SIZE {
        if j < n2 {
            arr[k] = R[j];
            j += 1;
            k += 1;
        }
    }
}

fn merge_sort(arr: &mut [Field; MAX_SIZE], l: u64, r: u64) {
    if l < r {
        let m = l + (r - l) / 2;

        merge_sort(arr, l, m);
        merge_sort(arr, m + 1, r);

        merge(arr, l, m, r);
    }
}

fn bubble_sort(arr: &mut [Field; MAX_SIZE]) {
    let n = MAX_SIZE;

    for i in 0..n {
        for j in 0..n - 1 - i {
            if arr[j] as u64 > arr[j + 1] as u64 {
                
                let temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

fn insertion_sort(arr: &mut [Field; MAX_SIZE]) {
    for i in 1..MAX_SIZE {
        let key = arr[i] as u64;

        
        let mut placed = false;

        for j in 0..i {
            
            if arr[i - 1 - j] as u64 > key & !placed {
                arr[i - j] = arr[i - 1 - j];
            } else if !placed {
                
                arr[i - j] = key as Field;
                placed = true;
            }
        }

        
        if !placed {
            arr[0] = key as Field;
        }
    }
}

fn selection_sort(arr: &mut [Field; MAX_SIZE]) {
    for i in 0..MAX_SIZE - 1 {
        
        let mut min_idx = i;

        
        for j in i + 1..MAX_SIZE {
            
            if arr[j] as u64 < arr[min_idx] as u64 {
                min_idx = j; 
            }
        }

        if min_idx != i {
            
            let temp = arr[i];
            arr[i] = arr[min_idx];
            arr[min_idx] = temp;
        }
    }
}

// Sorting algos beyond this point need modifications to adjust for Noir

fn partition(arr: &mut [Field; MAX_SIZE], low: u64, high: u64) -> u64 {
    let pivot = arr[high]; 
    let mut i = low;

    for j in low..high {
        if arr[j] as u64 <= pivot as u64 {
            
            let temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            i += 1;
        }
    }
    
    let temp = arr[i];
    arr[i] = arr[high];
    arr[high] = temp;
    i
}

fn quick_sort(arr: &mut [Field; MAX_SIZE], low: u64, high: u64) {
    if low < high {
        let pi = partition(arr, low, high); 

        if pi > 0 {
            quick_sort(arr, low, pi - 1); 
        }
        quick_sort(arr, pi + 1, high); 
    }
}

global NUM_BUCKETS: Field = 5; 
global MAX_VAL: Field = 10; 
fn bucket_sort(arr: &mut [Field; MAX_SIZE]) {
    let mut buckets: [[Field; MAX_SIZE]; NUM_BUCKETS] = [[0; MAX_SIZE]; NUM_BUCKETS];
    let mut bucket_sizes: [Field; NUM_BUCKETS] = [0; NUM_BUCKETS];

    
    for i in 0..MAX_SIZE {
        let bucket_index: u64 = ((NUM_BUCKETS * arr[i] / MAX_VAL) as u64 % NUM_BUCKETS as u64) as u64;
        buckets[bucket_index][bucket_sizes[bucket_index] as u64] = arr[i];
        bucket_sizes[bucket_index] += 1;
    }

    
    let mut idx: u64 = 0;
    for i in 0..NUM_BUCKETS {
        // let size: u64 = bucket_sizes[i] as u64;

        
        let mut temp_bucket: [Field; MAX_SIZE] = [0; MAX_SIZE];
        for j in 0..MAX_SIZE {
            temp_bucket[j] = buckets[i][j];
        }

        
        insertion_sort(&mut temp_bucket);

        
        for j in 0..MAX_SIZE {
            arr[idx-1] = temp_bucket[j];
            idx += 1;
        }
    }
}

fn heapify(arr: &mut [Field; MAX_SIZE], n: u64, i: u64) {
    let mut largest = i; 
    let l = 2 * i + 1; 
    let r = 2 * i + 2; 

    
    if l < n & arr[l] as u64 > arr[largest] as u64 {
        largest = l;
    }

    
    if r < n & arr[r] as u64 > arr[largest] as u64 {
        largest = r;
    }

    
    if largest != i {
        
        let swap = arr[i];
        arr[i] = arr[largest];
        arr[largest] = swap;

        
        heapify(arr, n, largest);
    }
}

fn heap_sort(arr: &mut [Field; MAX_SIZE]) {
    let n = MAX_SIZE as u64;
    
    for i in 0..(n / 2) {
        heapify(arr, n, (n / 2 - 1 - i) as u64);
    }
    
    for i in 0..n {
        
        let temp = arr[0];
        arr[0] = arr[n - 1 - i];
        arr[n - 1 - i] = temp;

        
        heapify(arr, n - 1 - i, 0);
    }
}

fn counting_sort(arr: &mut [Field; MAX_SIZE]) {
    let mut count: [Field; MAX_VAL] = [0; MAX_VAL];
    let mut output: [Field; MAX_SIZE] = [0; MAX_SIZE];

    
    for i in 0..MAX_SIZE {
        let index = arr[i] as u64; 
        count[index] += 1;
    }

    
    
    for i in 1..MAX_VAL {
        let index = i as u64; 
        count[index] += count[index - 1];
    }

    
    for i in 0..MAX_SIZE {
        let index = arr[i] as u64; 
        output[(count[index] - 1) as u64] = arr[i];
        count[index] -= 1;
    }

    
    for i in 0..MAX_SIZE {
        arr[i] = output[i];
    }
}

fn gnome_sort(arr: &mut [Field; MAX_SIZE]) {
    let mut index = 1;
    let mut sorting = true;
    
    for _ in 0..MAX_SIZE {
        
        if !sorting {
       
            
        } else {
            
            if index as u64 >= MAX_SIZE as u64 {
                sorting = false; 
            } else {
                
                if (index as u64 > 0) & ((arr[index - 1] as u64) <= (arr[index] as u64)) {
                    index += 1;
                } else {
                    
                    let temp = arr[index];
                    arr[index] = arr[index - 1];
                    arr[index - 1] = temp;

                    
                    if index as u64 > 0 {
                        index -= 1;
                    }
                }
            }
        }
    }
}

fn cocktail_sort(arr: &mut [Field; MAX_SIZE]) {
    let mut start = 0;
    let mut end = MAX_SIZE - 1;
    let mut swapped = true;

    for _ in 0..MAX_SIZE {
        
        if !swapped {
            
        } else {
            swapped = false;

            
            for i in 0..MAX_SIZE {
                
                if i as u64 < end as u64 {
                    if arr[i] as u64 > arr[i + 1] as u64 {
                        let temp = arr[i];
                        arr[i] = arr[i + 1];
                        arr[i + 1] = temp;
                        swapped = true;
                    }
                }
            }
            
            end -= 1;
            
            for i in 0..MAX_SIZE {
                
                if i as u64 < (MAX_SIZE - 1 - start) as u64 {
                    let rev_i = MAX_SIZE - 2 - i; 
                    if arr[rev_i] as u64 > arr[rev_i + 1] as u64 {
                        let temp = arr[rev_i];
                        arr[rev_i] = arr[rev_i + 1];
                        arr[rev_i + 1] = temp;
                        swapped = true;
                    }
                }
            }
            
            start += 1;
        }
    }
}

#[test]
fn test_sort_already_sorted() {
    let mut arr: [Field; MAX_SIZE] = [1, 2, 3, 4, 5]; 
    merge_sort(&mut arr, 0, arr.len() as u64 - 1);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_sort_reverse_sorted() {
    let mut arr: [Field; MAX_SIZE] = [5, 4, 3, 2, 1]; 
    merge_sort(&mut arr, 0, arr.len() as u64 - 1);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_sort_random_order() {
    let mut arr: [Field; MAX_SIZE] = [3, 1, 4, 2, 5]; 
    merge_sort(&mut arr, 0, arr.len() as u64 - 1);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_sort_all_same() {
    let mut arr: [Field; MAX_SIZE] = [2, 2, 2, 2, 2]; 
    merge_sort(&mut arr, 0, arr.len() as u64 - 1);
    assert(arr == [2, 2, 2, 2, 2]);
}

#[test]
fn test_bubble_sort_empty() {
    let mut arr: [Field; 5] = [0, 0, 0, 0, 0]; 
    bubble_sort(&mut arr);
    assert(arr == [0, 0, 0, 0, 0]);
}

#[test]
fn test_bubble_sort_single_element() {
    let mut arr: [Field; 5] = [1, 0, 0, 0, 0]; 
    bubble_sort(&mut arr);
    assert(arr == [0, 0, 0, 0, 1]);
}

#[test]
fn test_bubble_sort_already_sorted() {
    let mut arr: [Field; 5] = [1, 2, 3, 4, 5]; 
    bubble_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_bubble_sort_reverse_sorted() {
    let mut arr: [Field; 5] = [5, 4, 3, 2, 1]; 
    bubble_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_bubble_sort_random_order() {
    let mut arr: [Field; 5] = [3, 1, 4, 5, 2]; 
    bubble_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_bubble_sort_all_same() {
    let mut arr: [Field; 5] = [2, 2, 2, 2, 2]; 
    bubble_sort(&mut arr);
    assert(arr == [2, 2, 2, 2, 2]);
}
#[test]
fn test_insertion_sort_empty() {
    let mut arr: [Field; 5] = [0, 0, 0, 0, 0]; 
    insertion_sort(&mut arr);
    assert(arr == [0, 0, 0, 0, 0]);
}

#[test]
fn test_insertion_sort_single_element() {
    let mut arr: [Field; 5] = [1, 0, 0, 0, 0]; 
    insertion_sort(&mut arr);
    assert(arr == [0, 0, 0, 0, 1]);
}

#[test]
fn test_insertion_sort_already_sorted() {
    let mut arr: [Field; 5] = [1, 2, 3, 4, 5]; 
    insertion_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_insertion_sort_reverse_sorted() {
    let mut arr: [Field; 5] = [5, 4, 3, 2, 1]; 
    insertion_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_insertion_sort_random_order() {
    let mut arr: [Field; 5] = [3, 1, 4, 5, 2]; 
    insertion_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_insertion_sort_all_same() {
    let mut arr: [Field; 5] = [2, 2, 2, 2, 2]; 
    insertion_sort(&mut arr);
    assert(arr == [2, 2, 2, 2, 2]);
}
#[test]
fn test_selection_sort_empty() {
    let mut arr: [Field; 5] = [0, 0, 0, 0, 0]; 
    selection_sort(&mut arr);
    assert(arr == [0, 0, 0, 0, 0]);
}

#[test]
fn test_selection_sort_single_element() {
    let mut arr: [Field; 5] = [1, 0, 0, 0, 0]; 
    selection_sort(&mut arr);
    assert(arr == [0, 0, 0, 0, 1]);
}

#[test]
fn test_selection_sort_already_sorted() {
    let mut arr: [Field; 5] = [1, 2, 3, 4, 5]; 
    selection_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_selection_sort_reverse_sorted() {
    let mut arr: [Field; 5] = [5, 4, 3, 2, 1]; 
    selection_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_selection_sort_random_order() {
    let mut arr: [Field; 5] = [3, 1, 4, 5, 2]; 
    selection_sort(&mut arr);
    assert(arr == [1, 2, 3, 4, 5]);
}

#[test]
fn test_selection_sort_all_same() {
    let mut arr: [Field; 5] = [2, 2, 2, 2, 2]; 
    selection_sort(&mut arr);
    assert(arr == [2, 2, 2, 2, 2]);
}
