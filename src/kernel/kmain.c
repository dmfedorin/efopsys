#include "io/term.h"
#include "mem/layout.h"

void puts(const char *s, int row, int col)
{
        for (int i = 0; s[i] != '\0'; i++) {
                struct vgaent ent = {
                        .c = s[i], .attr = vctoattr(VC_WHITE, VC_BLUE),
                };

                setvgaent(ent, row, col);
                col++;
        }
        
        setcursorpos(row, col);
}

void kmain(void)
{
        puts("hello world", 0, 0);
}