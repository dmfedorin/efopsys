#ifndef PORT_H_INCLUDED
#define PORT_H_INCLUDED

#include <stdint.h>

enum port {
        P_VGACTRL = 0x3d4,
        P_VGADATA = 0x3d5,
};

void wrtportb(enum port port, uint8_t b);

uint8_t rdportb(enum port port);

void wrtportw(enum port port, uint16_t w);

uint16_t rdportw(enum port port);

void wrtportl(enum port port, uint32_t l);

uint32_t rdportl(enum port port);

void waitport(enum port port);

#endif