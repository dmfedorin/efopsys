#ifndef TERM_H_INCLUDED
#define TERM_H_INCLUDED

#include "port.h"

#include <stdint.h>

enum vgacolor {
        VC_BLACK        = 0x0,
        VC_BLUE         = 0x1,
        VC_GREEN        = 0x2,
        VC_CYAN         = 0x3,
        VC_RED          = 0x4,
        VC_MAGENTA      = 0x5,
        VC_BROWN        = 0x6,
        VC_LIGHTGRAY    = 0x7,
        VC_DARKGRAY     = 0x8,
        VC_LIGHTBLUE    = 0x9,
        VC_LIGHTGREEN   = 0xa,
        VC_LIGHTCYAN    = 0xb,
        VC_LIGHTRED     = 0xc,
        VC_LIGHTMAGENTA = 0xd,
        VC_LIGHTBROWN   = 0xe,
        VC_WHITE        = 0xf,
};

struct vgaent {
        char c;
        uint8_t attr;
} __attribute__((packed));

void setvgaent(struct vgaent ent, int row, int col);

uint8_t vctoattr(enum vgacolor fg, enum vgacolor bg);

void setcursorpos(int row, int col);

#endif