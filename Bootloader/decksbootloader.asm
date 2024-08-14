;Bootloader


; --Code here is running in REAL MODE--

BITS 16 ;Specify this code is 16 bit
ORG 0x7C00 ;Specify code should start at 0x7C00


start:
    mov ah, 0x01 ;|Disables the text mode cursor
    mov ch, 0x3F ;|

    int 0x10 ;Make sure text mode is enabled while were still in real mode

    ;Load kernel into memory using CHS (Cylinder-Head-Sector) addressing
    mov ah, 0x02 ;Set the bios function (0x02 is the function to read sectors)
    mov al, 4 ;Number of sectors to read
    mov ch, 0 ;The cylinder number
    mov cl, 2 ;The sector number
    mov dh, 0 ;Head number
    mov dl, 0 ;Drive number (0 is default)
    mov bx, 0x1000 ;Address where the kernel will be stored
    int 0x13 ;Call the disk intrupt



    jmp load_gdt ;Jump to load_gdt

gdt_start: ;Write the GDT -Every GDT entry is 8 bytes (64 bits)
    dq 0                       ;Null
    dq 0x00CF9A000000FFFF      ;Code
    dq 0x00CF92000000FFFF      ;Data
gdt_end:

gdt_ptr: ;Define GDT structure
    dw gdt_end - gdt_start - 1 ;Limit (Full size of the GDT)
    dd gdt_start               ;Base Address


load_gdt:
    lgdt[gdt_ptr] ;Load GDT using pointer

    ;Enable protected mode

    cld ;Disable direction flag
    cli ;Disable intrurupts
    mov eax, cr0 ;Move the value from cr0 to eax Note: cr0 is the register you use to control protected mode
    or eax, 1 ;Set the protection enable bit to true
    mov cr0, eax ;Move the updated value in eax back to cr0
    jmp 0x08:protected_mode ;Start executing code in protected mode


BITS 32        ;All code from now on will be in 32 bit mode


protected_mode:


;Segment register setup
    mov ax, 0x10               ;Data segment selector (index 2 in GDT)
    mov ds, ax                 ;Load ds register
    mov es, ax                 ;Load es register
    mov fs, ax                 ;Load fs register
    mov gs, ax                 ;Load gs register
    mov ss, ax                 ;Load ss register

;We are now in 32 bit protected mode

    mov ebp, 0x90000		;Set register ebp (32 bit base pointer) to 0x9000 in memory
	mov esp, ebp


;Write a :) to video memory
    mov edi, 0xB8a00 ;Location of row/column in video memory 0xB8a00
    mov al, ':'      ;Load ":" into al
    mov ah, 0x2a     ;Load attribute into ah
    mov [edi], ax    ;Write character and attribute to video memory
    mov edi, 0xB8a02 ;Move 1 character ahead
    mov al, ')'      ;Switch character to ")"
    mov [edi], ax    ;Write character again



;Far jump To The Kernel
    jmp 08h:0x1000
    

times 510 - ($ - $$) db 0      ;Fill the first 510 bytes of the boot sector with 0
dw 0xAA55                     ;Fill the last 2 bytes with the boot signature (0xAA55)

;For reference when reading over:
; -DB: "Define Byte" used to define 1 byte
; -DW: "Define Word" used to define 2 bytes
; -DD: "Define Double Word" used to define 3 bytes
; -DQ: "Define Quad Word" used to define 4 bytes
