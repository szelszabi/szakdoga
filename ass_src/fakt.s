        .intel_syntax noprefix
        .globl main
main:
        mov bx,
        mov ax, 1
        jmp cond
body:   mul bx
        cwd
        inc bx
        
cond:   cmp bx, 5
        jle body
        mov cx, ax

        mov ax, 0
        ret