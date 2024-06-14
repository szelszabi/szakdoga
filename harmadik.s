# The standard C printf function

        .intel_syntax noprefix
        .section .rodata
LC0:   .string    "My address: %p\n"
        .globl     main, LC0
        .text
main:   push rbp
        mov rbp, rsp
        and rsp, 0xFFFFFFFFFFFFFFF0 
        mov rsi, [LC0]
        lea rdi, [LC0]
        mov eax, 0                   # number of float parameters of printf
        call printf                        # invocation of C standard printf function (stdio.h)
        mov eax, 0
        mov rsp, rbp
        pop rbp
        ret


### C style ###
# #include<stdio.h>
# #include<stdlib.h>
# int main(){
#   int x, y;
#   x=rand()&0xffff; //rand()%65536;
#   y=printf("Hello %s%c%d\n","world!",'\t',x);
#   return y; 
#   }

