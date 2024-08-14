//Text Mode

#include "Headers/deckstextmode.h"  //Include the text mode header
#define VGA_MEM ((uint16_t*)0xB8000)    //VGA memory location
#include <stdint.h> //Include the stdint header to support uint variable type



int row = 1;    //X and Y positions
int column = 1;
uint8_t color = (0x0 << 4) | (0xf & 0x0F);  //Stores the color attribute (if 16 colors are avalible, then it takes 4 bits to store 1 color, therfor 8 bits for 2 colors)

void SetColor(uint8_t foreground, uint8_t background) { //Sets the colors

    color = (background << 4) | (foreground & 0x0F);    //Set first 4 bits to background and last 4 bits to foreground
}

void SetPos(int x, int y) {     //Sets the position
    row = x;
    column = y;
}


void WriteChar(char c) {    //Writes a character

    uint16_t value = (color << 8) | c;  //Color is stored in the first 8 bits (attribute byte) and the character is stored in the last 8 bits

    VGA_MEM[(column - 1)* 80 + (row - 1)] = value;  //Print the character at the correct location (starts at 1 instead of 0)

}

void ClearScreen() {    //Clears the screen to the current set color (background)
    for(int i = 0; i < 2000; i++) { //2000 is 80x25 (Text mode size)
            WriteChar(' ');
            row++;
        
    }
    
}
