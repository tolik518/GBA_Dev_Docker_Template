#include <tonc.h>

void drawline(int x1, int y1, int x2, int y2, int color);
void drawCube(int x0, int y0, int x1, int y1, int color);
int diff(int a, int b);
int zero(int a, int b);

int main(void) 
{
	REG_DISPCNT = DCNT_MODE3 | DCNT_BG2;

	/*int y = 239;
	int x = 159;*/

	int color = 16;
	while (1) 
	{
		drawCube(5,5,154,234, color);
		/*for(int i = 0; i <= x/2; i++)
		{
			drawCube(i, i, x-i, y-i, color);
		}*/
		//VBlankIntrWait();
		
		++color;
	}
}

int diff(int a, int b) 
{
	if (a > b)
        return a - b;
    else
        return b - a;
}

int zero(int a, int b) 
{
	if (a > b )
        return a;
    else
        return b;
}

void drawline(int x0, int y0, int x1, int y1, int color) 
{
	int dx = diff(x0, x1);
	int sx = x0 < x1 ? 1 : -1;
	int dy = -diff(y0, y1);
	int sy = y0 < y1 ? 1 : -1;
	int error = dx + dy;

	while(true)
	{
		m3_mem[x0][y0] = color;

		if (x0 == x1 && y0 == y1) break;

		int e2 = 2 * error;

		if (e2 >= dy){
			if (x0 == x1) break;
			error = error + dy;
			x0 = x0 + sx;
		}

		if (e2 <= dx){
			if (y0 == y1) break;
			error = error + dx;
			y0 = y0 + sy;
		}
	}
}


void drawCube(int x0, int y0, int x1, int y1, int color)
{
	drawline(x1, y0, x0, y0, color);
	drawline(x0, y1, x0, y0, color);
	drawline(x0, y1, x1, y1, color);
	drawline(x1, y0, x1, y1, color);
}