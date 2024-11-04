# Assembly code for the python script

        .intel_syntax noprefix
        .globl main
main:
    mov rax, 0x53544F5056454745 # Translates to 'STOPVEGE'
    push rax
    pop rax
    ret


# 48 b8 45 47 45 56 50 4f 54 53 50