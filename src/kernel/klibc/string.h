#ifndef STRING_H_INCLUDED
#define STRING_H_INCLUDED

#include <stdint.h>

void memset(void *restrict dst, uint8_t b, int size);

void memcpy(void *restrict dst, void *restrict src, int size);

#endif