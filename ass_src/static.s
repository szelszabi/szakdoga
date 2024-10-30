        .intel_syntax noprefix
        .globl     main
        .globl     a,b,c                   # global (variable) names
        .data                              # data segment for static variables
a:      .byte      11                      # char: memory allocation and initialization 
b:      .2byte     22                      # short: memory allocation and initialization 
c:      .4byte     44                      # int: memory allocation and initialization 
d:      .4byte     100                     # static int: memory allocation and initialization (not global)
        .text                              # beginning of the code segment 
main:   mov        al, BYTE PTR [a]        # load a byte from a variable (char) to al 
        cbw                                # al (byte) is sign-extended to ax (word)
        add        ax, WORD PTR [b]        # add ax to a word from a variable (short)
        cwd                                # ax (word) is sign-extended to eax (double word)
        add        eax, DWORD PTR [c]      # add eax to a double word from a variable (int)
        add        eax, DWORD PTR [d]      # add eax to a double word from a variable (static int)
        ret