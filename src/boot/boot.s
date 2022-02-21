        .ifndef BOOT_S_INCLUDED
        .equ BOOT_S_INCLUDED, 1

        .equ STKBASE, 0x7c00

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

_bootmsg:
        .asciz "entered bootloader"

_bootdisk:
        .byte 0

_boot:                  mov     $_bootmsg, %bx
                        call    log

                        mov     %dl, _bootdisk

                        call    enablea20

                        jmp     .

        / bootsector identifier
        .org 510
        .word 0xaa55

        .endif
