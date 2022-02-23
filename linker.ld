OUTPUT_FORMAT(binary)
ENTRY(kentry)

SECTIONS {
        . = 0x7e00;

        .text BLOCK(4K) : ALIGN(0x100) {
                *(.text)
        }

        .rodata BLOCK(4K) : ALIGN(0x100) {
                *(.rodata)
        }

        .data BLOCK(4K) : ALIGN(0x100) {
                *(.data)
        }

        .bss BLOCK(4K) : ALIGN(0x100) {
                *(COMMON)
                *(.bss)
        }
}