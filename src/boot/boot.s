        .ifndef BOOT_S_INCLUDED
        .equ BOOT_S_INCLUDED, 1

        .equ STKBASE,   0x7c00

        .code16

        .section .text

                        / perform setup before booting
                        xor     %ax, %ax
                        mov     %ax, %ds
                        mov     %ax, %es
                        mov     %ax, %fs
                        mov     %ax, %gs

                        mov     %ax, %ss
                        mov     $STKBASE, %sp
                        mov     %sp, %bp

                        jmp     _boot

        .include "src/boot/io.s"
        .include "src/boot/a20.s"
        .include "src/boot/mem.s"
        .include "src/boot/pm.s"

        .code16

_bootdisk:
        .byte 0x0

_boot:                  mov     %dl, _bootdisk

                        call    enablea20
                        call    memdetect

                        mov     $0x20, %al
                        xor     %ch, %ch
                        mov     $0x2, %cl
                        xor     %dh, %dh
                        mov     _bootdisk, %dl
                        mov     $KERNELADDR, %bx

                        call    rddisk

                        jmp     enterpm

        / bootsector identifier
        .org 0x1fe
        .word 0xaa55

        .endif
