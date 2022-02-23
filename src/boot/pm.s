        .ifndef PM_S_INCLUDED
        .equ PM_S_INCLUDED, 1

        .include "src/boot/gdt.s"
        
        .equ KERNELADDR, 0x7e00
        .equ CR0PMBIT,   0x1

        .code16

        .section .text

enterpm:                cli

                        lgdt    gdtdesc

                        mov     %cr0, %eax
                        or      $CR0PMBIT, %eax
                        mov     %eax, %cr0

                        jmp     $CODESEG,$KERNELADDR

        .endif
