#include "term.h"

#define VGAPTR         ((struct vgaent *)0xb8000)
#define VGAWIDTH       80
#define VGAHEIGHT      25
#define PORTOFFSETLOW  0xf
#define PORTOFFSETHIGH 0xe

void setvgaent(struct vgaent ent, int row, int col)
{
        VGAPTR[VGAWIDTH * row + col] = ent;
}

uint8_t vctoattr(enum vgacolor fg, enum vgacolor bg)
{
        return bg << 4 | fg;
}

void setcursorpos(int row, int col)
{
        int pos = VGAWIDTH * row + col;

        wrtportb(P_VGACTRL, PORTOFFSETHIGH);
        wrtportb(P_VGADATA, pos >> 8);
        wrtportb(P_VGACTRL, PORTOFFSETLOW);
        wrtportb(P_VGADATA, pos & 0xff);
}