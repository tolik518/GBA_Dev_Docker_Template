#include <../include/gba_console.h>
#include <../include/gba_video.h>
#include <../include/gba_interrupt.h>
#include <../include/gba_systemcalls.h>
#include <../include/gba_input.h>
#include <stdio.h>
#include <stdlib.h>

void echo(char* text, int x, int y);

//---------------------------------------------------------------------------------
// Program entry point
//---------------------------------------------------------------------------------
int main(void) {
//---------------------------------------------------------------------------------
	// the vblank interrupt must be enabled for VBlankIntrWait() to work
	// since the default dispatcher handles the bios flags no vblank handler
	// is required
	irqInit();
	irqEnable(IRQ_VBLANK);

	consoleDemoInit();

	while (1) {
		echo("Moin!!!!", 10, 10);
		VBlankIntrWait();
	}
}

void echo(char* text, int x, int y){
	char buf[256];
	// ansi escape sequence to set print co-ordinates
	// /x1b[line;columnH
	snprintf(buf, sizeof(buf), "\x1b[%d;%dH%s\n",  x, y, text);
	iprintf(buf);
}