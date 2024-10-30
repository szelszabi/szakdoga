        .intel_syntax noprefix
        .globl main, select_sort, OuterLoop, InnerLoop, NotSmaller, Done, A, i
        .text

bubbleSort:
    mov rax, 0      # i
    sub rsi, 1         # n = n-1
    jbe Done
OuterLoop:
    mov rdx, 0      # swapped = 0
    mov rbx, 0      # j = 0

    mov rcx, rsi    # belső ciklusfeltétel n-1-i
    sub rcx, rax

InnerLoop:
    mov r8d, DWORD PTR [rdi+rbx*4]
    cmp r8d, DWORD PTR [rdi+(rbx+1)*4]
    jng NotGreater

    mov r9d, DWORD PTR [rdi+(rbx+1)*4] # Csere
    mov DWORD PTR[rdi+rbx*4], r9d
    mov DWORD PTR [rdi+(rbx+1)*4], r8d  

    inc rdx                 #Swapped++
NotGreater:
    inc rbx             # j++

    cmp rbx, rcx        # ha j<belső ciklusfeltétel marad ciklusban
    jl InnerLoop

    cmp rdx, 0          # swapped == 0
    jne OuterLoop
    inc rax             # i++
    cmp rax, rsi        # ciklusfeltétel ellenőrzés
    jl OuterLoop
    jmp Done

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
    call bubbleSort

    mov eax, DWORD PTR[rbp-20]
    
    mov rsp, rbp     
    pop rbp 
    ret
