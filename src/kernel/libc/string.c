#include "string.h"

void memset(void *dst, uint8_t b, int size)
{
        for (int i = 0; i < size; i++)
                ((uint8_t *)dst)[i] = b;
}

void memcpy(void *restrict dst, const void *restrict src, int size)
{
        for (int i = 0; i < size; i++)
                ((uint8_t *)dst)[i] = ((uint8_t *)src)[i];
}

void memmove(void *dst, const void *src, int size)
{
        for (int i = 0; i < size; i++)
                ((uint8_t *)dst)[i] = ((uint8_t *)src)[i];
}

int strlen(const char *s)
{
        int size = 0;

        while (s[size] != '\0')
                size++;

        return size;
}