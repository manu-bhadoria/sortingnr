# Sortingnr Library

## Introduction

The `sortingnr` library is a collection of sorting algorithms implemented in Noir, optimized for Zero-Knowledge Proof (ZKP) applications. This library facilitates the integration of efficient sorting mechanisms into ZKP systems, essential for various cryptographic protocols and applications.

## Algorithms

Some of the sorting algorithms:

- **Merge Sort**: A divide-and-conquer algorithm that divides the input array into two halves, sorts them, and then merges them.
- **Bubble Sort**: A simple comparison-based algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.
- **Insertion Sort**: Builds the final sorted array one item at a time, with the advantage of being efficient for small data sets.
- **Selection Sort**: Divides the input list into two parts: a sorted sublist and an unsorted sublist, and repeatedly selects the smallest element from the unsorted sublist and moves it to the sorted sublist.

### Example Usage

```rust
// Merge Sort
let mut arr: [Field; 5] = [3, 1, 4, 2, 5];
merge_sort(&mut arr, 0, arr.len() as u64 - 1);

// Bubble Sort
let mut arr: [Field; 5] = [3, 1, 4, 2, 5];
bubble_sort(&mut arr);

// Insertion Sort
let mut arr: [Field; 5] = [3, 1, 4, 2, 5];
insertion_sort(&mut arr);

// Selection Sort
let mut arr: [Field; 5] = [3, 1, 4, 2, 5];
selection_sort(&mut arr);
```
## Features

- **Array Sorting Algorithms**: Provides implementations for several sorting algorithms, including Merge Sort, Bubble Sort, Insertion Sort, Selection Sort, and more, tailored for Noir's syntax and constraints.
- **Noir-Optimized**: Specifically designed for use within Noir, enabling efficient compilation and execution within ZKP circuits.
- **Test Cases**: Each sorting algorithm is accompanied by a suite of test cases, ensuring reliability and correctness.

## Importance for ZKP

In ZKP systems, especially within blockchain applications, the efficiency and correctness of sorting algorithms are crucial. This library provides optimized sorting solutions that fit within the constraints of Noir, ensuring that they can be used effectively in ZKP circuits without compromising on performance or security.

## Contributing

Contributions are welcome! Whether it's adding new algorithms, optimizing existing ones, or improving test coverage, your input can help enhance the `sortingnr` library for the ZKP community.

## License

This project is licensed under Apache 2.0 License.

---
