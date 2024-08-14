SECTIONS
{
    . = 0x1000; /* Base address for the kernel */

    .text : {
        *(.text)     /* All .text sections from object files */
    }

    .data : {
        *(.data)     /* All .data sections from object files */
    }

    .bss : {
        *(.bss)      /* All .bss sections from object files */
    }

    /DISCARD/ : { *(.note.GNU-stack) }
}
