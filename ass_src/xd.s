        .intel_syntax noprefix
	.section .rodata
.TXT:   .string	    "xD\n"
	.globl main
	.text
main:
    push rbp
    mov rbp, rsp
    and rsp, 0xFFFFFFFFFFFFFFF0
    mov rax, 1
    mov rdi, 1
    lea rsi, [.TXT]
    mov rdx, 3
    syscall
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret

