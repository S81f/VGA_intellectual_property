/*
 * "print_my_name.c" example.
 *
 * This example prints the string my_name using function print_char. 
 * The print_char function uses the VGA intellectual property core to write the string char by char
 * on a VGA monitor.
 *
 */

#include <stdio.h>
#include <alt_types.h>
#include "vga_avalon_interface.h"

int main()
{
	const char my_name[] = "Saif Saadaldin";
	alt_u8 *p;
	p = my_name;

	alt_u32 screen_background = 0x00f;//white color
	clear_screen(screen_background);

	alt_u32 x,y;
	x = 320/3;
	y = 240/2;

	for(;*p != '\0';){
		print_char(x, y, *p, screen_background, 0x000); //0x000 = black background for the name text
		x+=8;
		p++;
	}


  return 0;
}


