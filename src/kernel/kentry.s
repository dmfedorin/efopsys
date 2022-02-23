        .ifndef KENTRY_S_INCLUDED
        .equ KENTRY_S_INCLUDED, 1
        
        .equ STKBASE, 0x7c00
        .equ CODESEG, 0x8
        .equ DATASEG, 0x10

        .global kmain
        .global kentry

        .code32

        .section .text

kentry:                 / perform setup before entering kernel
                        mov     $DATASEG, %ax
                        mov     %ax, %ds
                        mov     %ax, %es
                        mov     %ax, %fs
                        mov     %ax, %gs

                        mov     %ax, %ss
                        mov     $STKBASE, %esp
                        mov     %esp, %ebp

                        call    kmain
                        jmp     .

        .endif
