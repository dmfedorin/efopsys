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

                        cmpb    $0, (%bx)
                        jne     _putsloop

                        pop     %bx
                        pop     %ax

                        ret

_lnend:
        .byte 0xd
        .byte 0xa
        .byte 0

/ expects bx to hold pointer to null terminated string
putsln:                 call    puts
                        
                        push    %bx
                        mov     $_lnend, %bx
                        call    puts
                        pop     %bx

                        ret

_logpref:
        .asciz "[...] "

/ expects bx to hold pointer to null terminated log message string
log:                    push    %bx                        
                        mov     $_logpref, %bx
                        call    puts
                        pop     %bx

                        call    putsln

                        ret

_errpref:
        .asciz "[..X] "

/ expects bx to hold pointer to null terminated error message string
error:                  push    %bx
                        mov     $_errpref, %bx
                        call    puts
                        pop     %bx

                        call    putsln

                        ret

        .endif
