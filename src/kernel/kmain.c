#include "driv/term.h"

void kmain(void)
{
        struct vgaent ent = {
                .c = 'h', .attr = vctova(VC_WHITE, VC_BLUE),
        };
}