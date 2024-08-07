cd ..

gcc -ffreestanding -c KernelMain/deckskernel.c -o deckskernel.o
gcc -ffreestanding -c KernelMain/deckstextmode.c -o deckstextmode.o

ld -o deckskernel.bin -Ttext 0x1000 --oformat binary deckskernel.o deckstextmode.o

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
