#include "Headers/deckstextmode.h" //Include the text mode header
#include <stdint.h> //Include the stdint header to support uint variable type

void WriteString(const char* string); //Function prototype
void DrawBox(int xst, int xnd, int yst, int ynd);  //Function prototype

int x; //XY coordinates
int y;


void main() {   //Main entry point
    SetColor(0x8, 0x8);

    ClearScreen();


    SetColor(0xa, 0x7);
    DrawBox(20, 80, 2,15);
    x=37;y=3;
    SetPos(x, y);

    WriteString("Decks!");

    x=25;y=5;
    SetPos(x,y);
    WriteString("This screen is a stub for now.");

    SetColor(0x1, 0xf);

    x=22;y=7;
    SetPos(x,y);
    WriteString("1. View System Information");

    x=22;y=9;
    SetPos(x,y);
    WriteString("2. Configure Decks");


    while(1);
}

void WriteString(const char* string)    //Write a string at selected position on screen
{
    
    for (int i = 0; string[i] != '\0'; i++)
    {
        SetPos(x,y);
        WriteChar(string[i]);
        x+=1;
    }
    
}

void DrawBox(int xst, int xnd, int yst, int ynd)    //Draw a box at x start, x end, y start, y end
{   
    for(int i = yst; i <= ynd; i++)
    {
        y=i;
        for(int i = xst; i <= xnd - xst; i++)
        {
            x=i;
            SetPos(x,y);
            WriteChar(' ');
        }
    }

}