        .ifndef BINPADDING_S_INCLUDED
        .equ BINPADDING_S_INCLUDED, 1

        / must be inserted wherever there is a risk of reading too much data from disk
        / prevents disk error by providing a buffer zone when reading too far

        .equ SECTORCNT,  0x40
        .equ SECTORSIZE, 0x200

        .code16

        .section .text

        .org SECTORSIZE * SECTORCNT

        .endif
