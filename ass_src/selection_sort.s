        .intel_syntax noprefix
        .globl main, select_sort, OuterLoop, InnerLoop, NotSmaller, Done, A, i
        .data
A:      .4byte     5
        .4byte     4
        .4byte     69
        .4byte     2
        .4byte     1
        .comm      i,4
        .text


select_sort:
    mov    ecx, DWORD PTR [0x0] # Number of integers    
    lea    rbx, QWORD PTR [A] # Address of array
    sub    rcx, 1       # Ready if 0 or 1 element(s)
    jbe    Done

OuterLoop:
    mov    rdx, rcx      # Number of comparisons to make
    mov    rsi, rbx      # Start of the unsorted partition
    mov    eax, DWORD PTR [rsi]    # Value of chosen minimum
    mov    rdi, rsi      # Position of chosen minimum
InnerLoop:
    add    rsi, 4
    cmp    DWORD PTR [rsi], eax
    jnb    NotSmaller
    mov    eax, DWORD PTR [rsi]    # Value of new minimum
    mov    rdi, rsi      # Position of new minimum
NotSmaller:
    dec    rdx
    jnz    InnerLoop

    mov    edx, DWORD PTR [rbx]    # Swap elements
    mov    DWORD PTR [rbx], eax
    mov    DWORD PTR [rdi], edx

    add    rbx, 4         # Move the dividing border
    dec    rcx
    jnz    OuterLoop

Done:
    mov eax, DWORD PTR [A+16]
    ret    

main:

    call select_sort
    ret
