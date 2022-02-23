#ifndef STRING_H_INCLUDED
#define STRING_H_INCLUDED

#include <stdint.h>

void memset(void *dst, uint8_t b, int size);

void memcpy(void *restrict dst, const void *restrict src, int size);

void memmove(void *dst, const void *src, int size);

int strlen(const char *s);

#endif