void kmain(void)
{
        char *vgaptr = (char *)0xb8000;
        *vgaptr = 'h';
}