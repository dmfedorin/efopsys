        .ifndef GDT_S_INCLUDED
        .equ GDT_S_INCLUDED, 1

        .equ CODESEG, 0x8
        .equ DATASEG, 0x10

        .code16

        .section .text

_gdtstart:

/ gdt dummy entry:
/ 16 bits: limit
/ 16 bits: base
/ 8 bits:  base
/ 8 bits: P (1b), DPL (2b), S (1b), EX (1b), DC (1b), RW (1b), A (1b)
/ 8 bits: G (1b), DB (1b), L (1b), AVL (1b), limit (4b)
/ 8 bits:  base

_gdtnullent:
        .quad 0x0

_gdtcodeent:
        .word 0xffff
        .word 0x0
        .byte 0x0
        .byte 0b10011010
        .byte 0b11001111
        .byte 0x0

_gdtdataent:
        .word 0xffff
        .word 0x0
        .byte 0x0
        .byte 0b10010010
        .byte 0b11001111
        .byte 0x0

_gdtend:

gdtdesc:
        .word _gdtend - _gdtstart - 0x1
        .long _gdtstart

        .endif
