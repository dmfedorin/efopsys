#include "string.h"

void memset(void *restrict dst, uint8_t b, int size)
{
        for (int i = 0; i < size; i++)
                ((uint8_t *)dst)[i] = b;
}

void memcpy(void *restrict dst, void *restrict src, int size)
{
        for (int i = 0; i < size; i++)
                ((uint8_t *)dst)[i] = ((uint8_t *)src)[i];
}