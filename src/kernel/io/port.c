#include "port.h"

void wrtportb(enum port port, uint8_t b)
{
        __asm__ volatile ("outb %0, %1\n"
                          : : "a" (b), "Nd" ((uint16_t)port));
}

uint8_t rdportb(enum port port)
{
        uint8_t res;

        __asm__ volatile ("inb %1, %0\n"
                          : "=a" (res)
                          : "Nd" ((uint16_t)port));

        return res;
}

void wrtportw(enum port port, uint16_t w)
{
        __asm__ volatile ("outw %0, %1\n"
                          : : "a" (w), "Nd" ((uint16_t)port));
}

uint16_t rdportw(enum port port)
{
        uint16_t res;

        __asm__ volatile ("inw %1, %0\n"
                          : "=a" (res)
                          : "Nd" ((uint16_t)port));

        return res;
}

void wrtportl(enum port port, uint32_t l)
{
        __asm__ volatile ("outl %0, %1\n"
                          : : "a" (l), "Nd" ((uint16_t)port));
}

uint32_t rdportl(enum port port)
{
        uint32_t res;

        __asm__ volatile ("inl %1, %0\n"
                          : "=a" (res)
                          : "Nd" ((uint16_t)port));

        return res;
}

void waitport(enum port port)
{
        __asm__ volatile ("out %eax, $0x80\n");
}