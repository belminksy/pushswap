#!/usr/bin/env python3

import sys

list_a = []
list_b = []

max_shift = 0
contains_negative = False

for arg in sys.argv[1:len(sys.argv)]:

    try:
        elem = int(arg)
    except:
        print("The argument \"" + arg + "\" can't be converted to int")
        exit(0)

    list_a.append(elem)

    if elem < 0:
        contains_negative = True

    while elem > 0 and elem >> max_shift != 0:
        max_shift += 1


def pa():
    list_a.insert(0, list_b.pop(0))
    print("pa", end=" ")

def pb():
    list_b.insert(0, list_a.pop(0))
    print("pb", end=" ")

def ra():
    list_a.append(list_a.pop(0))
    print("ra", end=" ")


for i in range(max_shift):

    mask = 2 ** i

    for j in range(len(list_a)):

        if (list_a[0] & mask) == 0:
            pb()
        else:
            ra()

    for j in range(len(list_b)):
        pa()


if contains_negative:

    mask = 2 ** 32

    for j in range(len(list_a)):

        if (list_a[0] & mask) == 0:
            ra()
        else:
            pb()

    for j in range(len(list_b)):
        pa()


print(end="\n")

for i in range(len(list_a) - 1):
    assert(list_a[i] <= list_a[i + 1])

assert(len(list_b) == 0)
