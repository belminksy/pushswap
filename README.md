Pushswap
===

Pushswap viewer with chromatic wheel.

The pushswap is an Epitech / 42 algorithm school project. This consists of sorted a random stack of unorganized numbers, from smallest to largest, by applying predefined actions (push or swap) between this stack and a second empty stack.

For more information check out this Medium article: [Push_Swap: The least amount of moves with two stacks](https://medium.com/@jamierobertdawson/push-swap-the-least-amount-of-moves-with-two-stacks-d1e76a71789a)

**Disclamer:** This repository doesn't contains the source code of the pushswap exercise but a chromatic viewer of sorting algorithms.

Building
---

You'll need the following dependencies:

- valac
- meson
- python3
- Gtk+ 3

Run `meson build` to configure the build environment. Change to the build directory and run `ninja` to build.

```bash
meson build
cd build
ninja
```

To execute, run the following command in the project root directory.

```bash
./build/src/pushchroma
```

Running
---

To execute properly, the program need a file `numbers` which contains a list of unorganized numbers and a file `actions` which contains all the pushswap steps to sort the list.

You can use your own method to generate theses files, or you can use some python scripts provided in this repository.

To create a random list, execute the randomizer:
You can specify the size of the list, 100 in this example.

```bash
./sorts/randomizer 100 > numbers
```

Then, to sort the list, execute your favorite (or your own) algorithm:

```bash
./sorts/radix_lsb.py $(cat numbers) > actions
```

And finally, in the same directory, execute the binary:

```bash
./build/src/pushchroma
```

Overview
---

The main goal of this project is to visualize the internal operations of an algorithm running for the pushswap through a chromatic wheel.

A good way to observe that, is by compare the wheel evolution of two different sorting algorithm.

![Radix LSB sort vs Cocktail sort](data/evolution.gif?raw=true)

> Visual comparaison between the Radix LSB sort (left) & the Cocktail sort (right).

The only measurable value in this example is the speed of the algorithms. This can be compared with their time complexity.

The Radix LSB sort, has an average time complexity of *O(w \* n)*, where w is the number of bits required to store each key.
The Cocktail sort, a declinaison of the Bubble sort, has an average time complexity of *O(n²)*.
