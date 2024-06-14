.intel_syntax noprefix
.global _main
_main:
    mov rax, 0x1
    mov rdi, 0x1
    lea rsi, [xd]
    mov rdx, 0x2
    syscall

xd:
    .asciz "xd"
