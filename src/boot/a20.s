        .ifndef A20_S_INCLUDED
        .equ A20_S_INCLUDED, 1
        
        .include "src/boot/io.s"

        .code16

        .section .text

_a20enabledmsg:
        .asciz "a20 line enabled"

_a20failedmsg:
        .asciz "failed to enable a20 line"

enablea20:              push    %ax
                        push    %bx

                        call    _checka20
                        cmp     $1, %ax
                        je      _enablea20succ

                        call    _enablea20int

                        call    _checka20
                        cmp     $1, %ax
                        je      _enablea20succ
                        
                        jmp     _enablea20fail

_enablea20succ:         mov     $_a20enabledmsg, %bx
                        call    log

                        pop     %bx
                        pop     %ax

                        ret

_enablea20fail:         mov     $_a20failedmsg, %bx
                        call    error

                        pop     %bx
                        pop     %ax

                        ret

/ ax will be 0 if the a20 line is disabled
/ ax will be 1 if the a20 line is enabled
_checka20:              pushf
                        push    %ds
                        push    %es
                        push    %di
                        push    %si

                        cli

                        xor     %ax, %ax
                        mov     %ax, %es

                        not     %ax
                        mov     %ax, %ds

                        mov     $0x500, %di
                        mov     $0x510, %si

                        movb    %es:(%di), %al
                        push    %ax

                        movb    %ds:(%si), %al
                        push    %ax

                        movb    $0, %es:(%di)
                        movb    $0xff, %ds:(%si)

                        cmpb    $0xff, %es:(%di)

                        pop     %ax
                        movb    %al, %ds:(%si)

                        pop     %ax
                        movb    %al, %es:(%di)

                        mov     $0, %ax

                        je      _checka20exit

                        mov     $1, %ax

_checka20exit:          pop     %si
                        pop     %di
                        pop     %es
                        pop     %ds
                        popf

                        ret

_a20intfailmsg:
        .asciz "failed to enable a20 line by interrupt"

_enablea20int:          pushf
                        push    %ax
                        push    %bx

                        / a20 line support
                        mov     $0x2403, %ax
                        int     $0x15
                        jb      _enablea20intfail
                        cmp     $0, %ah
                        jnz     _enablea20intfail
                        
                        / a20 line status
                        mov     $0x2402, %ax
                        int     $0x15
                        jb      _enablea20intfail
                        cmp     $0, %ah
                        jnz     _enablea20intfail

                        / check if a20 line is already enabled
                        cmp     $1, %al
                        jz      _enablea20intsucc

                        / enable a20 line
                        mov     $0x2401, %ax
                        int     $0x15
                        jb      _enablea20intfail
                        cmp     $0, %ah
                        jnz     _enablea20intfail

                        jmp     _enablea20intsucc

_enablea20intfail:      mov     $_a20intfailmsg, %bx
                        call    error

_enablea20intsucc:      pop     %bx
                        pop     %ax
                        popf

                        ret

        .endif
