#ifndef LAYOUT_H_INCLUDED
#define LAYOUT_H_INCLUDED

#include <stdint.h>

struct memlayoutent {
        uint64_t base, size;
        uint32_t type, acpiattr;
};

#endif