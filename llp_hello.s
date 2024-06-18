.intel_syntax noprefix
.global main
main:
    mov rax, 0x0
    mov rdi, 0x1
    lea rsi, [xd]
    mov rdx, 0x3
    syscall
    mov rax, 0
    ret

xd:
    .asciz "xd\n"
