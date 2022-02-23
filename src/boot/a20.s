        .ifndef A20_S_INCLUDED
        .equ A20_S_INCLUDED, 1
        
        .include "src/boot/io.s"

        .code16

        .section .text

_a20failmsg:
        .asciz "failed to enable a20 line"

enablea20:              push    %ax
                        push    %bx

                        call    _checka20
                        cmp     $0x1, %ax
                        je      _enablea20succ

                        call    _enablea20int

                        call    _checka20
                        cmp     $0x1, %ax
                        je      _enablea20succ
                        
                        jmp     _enablea20fail

_enablea20succ:         pop     %bx
                        pop     %ax

                        ret

_enablea20fail:         mov     $_a20failmsg, %bx
                        call    error

                        pop     %bx
                        pop     %ax

                        ret

/ ax will be 0 if the a20 line is disabled
/ ax will be 1 if the a20 line is enabled
_checka20:              pushf
                        push    %ds
                        push    %di
                        push    %si

                        cli

                        mov     $0xffff, %ax
                        mov     %ax, %ds

                        mov     $0x500, %di
                        mov     $0x510, %si

                        movb    (%di), %al
                        push    %ax

                        movb    %ds:(%si), %al
                        push    %ax

                        movb    $0x0, (%di)
                        movb    $0xff, %ds:(%si)

                        cmpb    $0xff, (%di)

                        pop     %ax
                        movb    %al, %ds:(%si)

                        pop     %ax
                        movb    %al, (%di)

                        mov     $0x0, %ax

                        je      _checka20exit

                        mov     $0x1, %ax

_checka20exit:          pop     %si
                        pop     %di
                        pop     %ds
                        popf

                        ret

_enablea20int:          pushf
                        push    %ax
                        push    %bx

                        / a20 line support
                        mov     $0x2403, %ax
                        int     $0x15
                        jb      _enablea20intexit
                        cmp     $0x0, %ah
                        jnz     _enablea20intexit
                        
                        / a20 line status
                        mov     $0x2402, %ax
                        int     $0x15
                        jb      _enablea20intexit
                        cmp     $0x0, %ah
                        jnz     _enablea20intexit

                        / check if a20 line is already enabled
                        cmp     $0x1, %al
                        jz      _enablea20intexit

                        / enable a20 line
                        mov     $0x2401, %ax
                        int     $0x15
                        jb      _enablea20intexit
                        cmp     $0x0, %ah
                        jnz     _enablea20intexit

_enablea20intexit:      pop     %bx
                        pop     %ax
                        popf

                        ret

        .endif
