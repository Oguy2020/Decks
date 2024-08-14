#ifndef DECKSTEXTMODE_H
#define DECKSTEXTMODE_H

#include <stdint.h> //Include the stdint header to support uint variable type

void SetColor(uint8_t foreground, uint8_t background);
void WriteChar(char c);
void SetPos(int x, int y);
void ClearScreen();

#endif