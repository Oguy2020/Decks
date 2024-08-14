cd ..

export PATH="$PATH:/usr/local/i386elfgcc/bin"


i386-elf-gcc -ffreestanding -m32 -g -O0 -c KernelMain/deckskernel.c -o deckskernel.o
i386-elf-gcc -ffreestanding -m32 -g -O0 -c KernelMain/deckstextmode.c -o deckstextmode.o

i386-elf-ld -o deckskernel.bin -T Build/linker.ld --oformat binary deckskernel.o deckstextmode.o

nasm -f bin Bootloader/decksbootloader.asm -o decksbootloader.bin

dd if=/dev/zero of=decks.img bs=512 count=2880
dd if=decksbootloader.bin of=decks.img bs=512 count=1 conv=notrunc
dd if=deckskernel.bin of=decks.img bs=512 seek=1 conv=notrunc

qemu-system-i386 -fda decks.img

rm deckskernel.o
rm deckstextmode.o
rm deckskernel.bin
rm decksbootloader.bin
rm decks.img

sleep 10
