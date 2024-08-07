#include "Headers/deckstextmode.h"  //Include the text mode header

#include <stdint.h> //Include the stdint header to support uint variable type

#define VGA_MEMORY 0xB8000  //Define the VGA memory location

#define WIDTH 80
#define HEIGHT 25

int row;    //Row and column of the character (80x25)
int column;

void SetPos(int x, int y)   //Set the position of where the character will be placed
{
    row = x;
    column = y;
}

void WriteChar(char character)  //Write a character to video memory
{   
    uint16_t offset = (row * WIDTH) + column;   //Calculate the offset for the position (formula row * width + column)

    char *video_memory[offset] = (char *)VGA_MEMORY;
    *video_memory = character;
}