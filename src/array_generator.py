#!/usr/bin/env python3

import sys
import random

def c_gen_array(length, min, max):
    arr = []
    for _ in range(length):
        arr.append(random.randrange(min, max))

    print("int A[%d] = {" % length, end='')
    for i in range(len(arr)):
        if i < len(arr) -1:
            print(f"{arr[i]}, ", end='')
        else:
            print(f"{arr[1]}", end='')
    print("};\n\tint n = sizeof(A)/4;");

def asm_gen_array(length, min, max):
    arr = []
    for _ in range(length):
        arr.append(random.randrange(min, max))
    displacement = (length+1)*4
    print(f"\tsub\trsp, {displacement}\n")
    print(f"\tmov\tDWORD PTR [rbp-{displacement}], {length}")
    for i in range(len(arr)):
        print(f"\tmov\tDWORD PTR [rbp-{displacement-(i+1)*4}], {arr[i]}")
    print(f"\n\tlea rdi, QWORD PTR [rbp-{displacement-4}]")
    print(f"\tmov esi, DWORD PTR [rbp-{displacement}]")

def main(args) -> None:
    if len(args) == 1:
        print("array_generator MODE LENGTH RANGE")
        print(" MODE: C or ASM")
        print(" LENGTH: Length of the generated array")
        print(" RANGE: [min-max)")
        exit(0)

    elif len(args) == 3:
        if args[1] == "C":
            c_gen_array(int(args[2]), 0, 2000)
        elif args[1] == "ASM":
            asm_gen_array(int(args[2]), 0, 2000)
        else:
            print("Wrong Mode!")
            exit(2)
    elif len(args) == 4:
        (min, max) = args[3].split('-')
        min = int(min)
        max = int(max)
        if args[1] == "C":
            c_gen_array(int(args[2]), min, max)
        elif args[1] == "ASM":
            asm_gen_array(int(args[2]), min, max)   
        else:
            print("Wrong Mode!")
            exit(2)   

if __name__ == "__main__":
    main(sys.argv)