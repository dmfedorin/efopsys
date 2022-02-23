        .ifndef MEM_S_INCLUDED
        .equ MEM_S_INCLUDED, 1

        .include "src/boot/io.s"

        .equ MEMLAYOUTADDR,    0x500
        .equ MEMLAOYUTENTSIZE, 0x18

        .code16

        .section .text

_memdetectfailmsg:
        .asciz "failed to detect memory"

memdetect:              push    %eax
                        push    %ebx
                        push    %ecx
                        push    %edx
                        push    %di

                        xor     %ebx, %ebx
                        mov     $0x534d4150, %edx
                        mov     $MEMLAYOUTADDR, %di

_memdetectloop:         mov     $0xe820, %eax
                        mov     $0x18, %ecx
                        int     $0x15

                        jc      _memdetectfail

                        / layout entry
                        / uint64 : base address
                        / uint64 : region size
                        / uint32 : region type
                        / uint32 : acpi extended attrs
                        add     $MEMLAOYUTENTSIZE, %di

                        cmp     $0x0, %ebx
                        jne     _memdetectloop

                        pop     %di
                        pop     %edx
                        pop     %ecx
                        pop     %ebx
                        pop     %eax

                        ret

_memdetectfail:         mov     $_memdetectfailmsg, %bx
                        call    error

        .endif
