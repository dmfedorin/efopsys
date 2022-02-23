#include "term.h"

#define VGAPTR    ((struct vgaent *)0xb8000)
#define VGAWIDTH  80
#define VGAHEIGHT 25

void setvgaent(struct vgaent ent, int row, int col)
{
        VGAPTR[VGAWIDTH * row + col] = ent;
}

uint8_t vctova(enum vgacolor fg, enum vgacolor bg)
{
        return bg << 4 | fg;
}