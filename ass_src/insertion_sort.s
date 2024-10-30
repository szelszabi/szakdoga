        .intel_syntax noprefix
        .globl main
        .text

insertionSort:
    mov rax, 1      # i
OuterLoop:
    mov ecx, DWORD PTR [rdi + rax * 4]    # key

    mov rbx, rax            # j = a - 1
    dec rbx         
    jmp InnerCheck
InnerLoop:
    mov DWORD PTR [rdi + (rbx + 1) * 4], edx
    dec rbx
InnerCheck:
    cmp rbx, 0
    jl InnerAfter
    mov edx, DWORD PTR [rdi + rbx * 4]
    cmp rdx, rcx
    jg InnerLoop

InnerAfter:
    mov DWORD PTR [rdi + (rbx + 1) * 4], ecx

    inc rax
    cmp rax, rsi
    jl OuterLoop

Done:
    ret

main:
    push       rbp
    mov        rbp, rsp
    sub        rsp, 24 

    mov        DWORD PTR [rbp-20], 156           # A[0]
    mov        DWORD PTR [rbp-16], 42           # A[1]
    mov        DWORD PTR [rbp-12], 89           # A[2]
    mov        DWORD PTR [rbp- 8], 34           # A[3]
    mov        DWORD PTR [rbp- 4], 4           # A[4]
    mov        DWORD PTR [rbp-24], 5           # n
    lea rdi, QWORD PTR [rbp-20]
    mov esi, DWORD PTR [rbp-24]
    call insertionSort

    mov eax, DWORD PTR[rbp-20]

    mov rsp, rbp
    pop rbp
    ret
