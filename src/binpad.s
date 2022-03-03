        .ifndef BINPADDING_S_INCLUDED
        .equ BINPADDING_S_INCLUDED, 1

        / should be inserted wherever there is a risk of reading too much data
        / from disk, this prevents disk error by providing a buffer zone when
        / reading too far

        .equ SECTORCNT,  0x100
        .equ SECTORSIZE, 0x200

        .code16

        .section .text

        .org SECTORSIZE * SECTORCNT

        .endif
