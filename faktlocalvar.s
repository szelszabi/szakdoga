        .intel_syntax noprefix
        .globl main
main:   push rbp
        mov rbp, rsp
        sub rsp, 2
        and    rsp,0xfffffffffffffff0
        mov WORD PTR [rbp-2], 2 # i
        mov ax, 1
        jmp cond

body:   mul bx
        cwd
        inc bx
        mov WORD PTR [rbp-2], bx
        
cond:   mov bx, WORD PTR [rbp-2]
        cmp bx, 5
        jle body
        mov rsp, rbp
