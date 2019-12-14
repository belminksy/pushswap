#!/usr/bin/python3

import sys

list_a = []
list_b = []

for arg in sys.argv[1:len(sys.argv)]:

    try:
        elem = int(arg)
    except:
        print("The argument \"" + arg + "\" can't be converted to int")
        exit(0)

    list_a.append(elem)


def sa():
    list_a[0], list_a[1] = list_a[1], list_a[0]
    print("sa", end=" ")

def sb():
    list_b[0], list_b[1] = list_b[1], list_b[0]
    print("sb", end=" ")

def pa():
    list_a.insert(0, list_b.pop(0))
    print("pa", end=" ")

def pb():
    list_b.insert(0, list_a.pop(0))
    print("pb", end=" ")


is_sorted = False

while not is_sorted:

    for i in range(len(list_a) - 1):

        if list_a[0] > list_a[1]:
            sa()

        pb()

    pb()


    for i in range(len(list_b) - 1):

        if list_b[0] < list_b[1]:
            sb()

        pa()

    pa()


    is_sorted = True

    for i in range(len(list_a) - 1):

        if list_a[i] > list_a[i + 1]:
            is_sorted = False
            break;


print(end="\n")

for i in range(len(list_a) - 1):
    assert(list_a[i] <= list_a[i + 1])

assert(len(list_b) == 0)
