        .ifndef IO_S_INCLUDED
        .equ IO_S_INCLUDED, 1

        .code16

        .section .text

/ expects bx to hold pointer to null terminated string
puts:                   push    %ax
                        push    %bx

                        mov     $0xe, %ah

_putsloop:              movb    (%bx), %al
                        int     $0x10
                        inc     %bx

                        cmpb    $0x0, (%bx)
                        jne     _putsloop

                        pop     %bx
                        pop     %ax

                        ret

_lnend:
        .byte 0xd
        .byte 0xa
        .byte 0x0

/ expects bx to hold pointer to null terminated string
putsln:                 call    puts
                        
                        push    %bx
                        mov     $_lnend, %bx
                        call    puts
                        pop     %bx

                        ret

_errpref:
        .asciz "[X] "

/ expects bx to hold pointer to null terminated error message string
error:                  push    %bx
                        mov     $_errpref, %bx
                        call    puts
                        pop     %bx

                        call    putsln

                        jmp .

_diskerrmsg:
        .asciz "failed to read disk"

/ expects al to be the number of sectors to read
/ expects ch to be the cylinder to read
/ expects cl to be the sector to start reading from
/ expects dh to be the head to read from
/ expects dl to be the disk to read from
/ expects es:bx to be the disk read destination
rddisk:                 push    %ax
                        push    %bx

                        mov     $0x2, %ah
                        int     $0x13
                        jc      _rddiskfail

                        pop     %bx
                        pop     %ax

                        ret

_rddiskfail:            mov     $_diskerrmsg, %bx
                        call    error

        .endif
