/*
 * vga_avalon_interface.c
 *
 *  Created on: Jan 9, 2021
 *      Author: Saif
 * 
 * The function print_char and draw_filled_circle are made by Calle Melander, 2017
 */

#include <system.h>
#include <io.h>
#include "vga_avalon_interface.h"
#include "sign_font.h"

// variabels to store the bits needed to draw spcific char
extern alt_u32 upper_char_line(alt_u8 char_pos);
extern alt_u32 lower_char_line(alt_u8 char_pos);

/*
* This function clear the entire screen (320*240) with the color parameter
*/
void clear_screen(alt_u32 color){
	alt_u32 y, x;
	for(y=0;y<240;y++) {
		for(x=0;x<320;x++) {
			print_pix(x,y,color);
		}
	}
}

/*
* This function draws horizontal line with @color, starts at (x,y) and is @line_lenght pixel long. 
*/
void print_hline(alt_u32 x,alt_u32 y,alt_u32 line_lenght,alt_u32 color){
	alt_u32 x_counter;
	for(x_counter = 0;x_counter < line_lenght; x_counter++){
		print_pix(x_counter+x, y, color);
	}
}

/*
* This function draws vertical line  with the @color, starts at (x,y) and is @line_lenght pixel long.
*/
void print_vline(alt_u32 x,alt_u32 y,alt_u32 line_lenght,alt_u32 color){
	alt_u32 y_counter;
	for(y_counter = 0;y_counter < line_lenght; y_counter++){
		print_pix(x, y_counter + y, color);
	}
}

/*
* This function prints a char @char_to_print that starts at (x,y) and has a color and background color.
*/
void print_char(alt_32 x, alt_32 y, alt_u8 char_to_print,alt_32 color, alt_u32 BGcolor){
	alt_u8 symbol = char_to_print;//char is 1 byte (8 bits)
	alt_u32 pry = y ;

	//dot = the values of the first 4 rows of the 8*8 array the char will be printed in
	alt_u32 dot = upper_char_line(symbol-0x20);// the first char in ASCII table has decimal 32 = 0x20
	 for(alt_u32 ii=0;ii<4;ii++){ // 4 raws per ½ sign
		 alt_u32 prx = x;
		 for(alt_u32 jj = 0; jj < 8; jj++){ // 8 pixel each raw (8 bits)
			 alt_u32 bit_color = (0x80000000 & dot)? color:BGcolor; //If condition is true ? then color : otherwise BGcolor
			 print_pix(prx,pry,bit_color);
			 dot = dot<<1;//Handle next bit in the 8 bit raw
			 prx++;
		 }
		 pry++;
	 }
	// now we draw the last 4 raws of the 8*8 array
	 dot = lower_char_line(symbol-0x20);
	 for(alt_u32 ii=0;ii<4;ii++){
		 alt_u32 prx = x;
		 for(alt_u32 jj=0;jj<8;jj++){
			 alt_u32 bit_color = (0x80000000 & dot)?color:BGcolor;
			 print_pix(prx,pry,bit_color);
			 dot = dot<<1;
			 prx++;
		 }
		 pry++;
	 }
}

/*
* This function draws a circle with the specified color, center coordinates (x,y) and radius .
*/
void print_circle(alt_32 x0, alt_32 y0, alt_32 radius,alt_32 color){
    alt_32 x = radius;
    alt_32 y = 0;
    alt_32 xChange = 1 - (radius << 1);
    alt_32 yChange = 0;
    alt_32 radiusError = 0;

    while (x >= y)
    {
        for (alt_32 i = x0 - x; i <= x0 + x; i++)
        {
        	print_pix(i, y0 + y, color);
        	print_pix(i, y0 - y, color);
        }
        for (alt_32 i = x0 - y; i <= x0 + y; i++)
        {
        	print_pix(i, y0 + x, color);
        	print_pix(i, y0 - x, color);
        }

        y++;
        radiusError += yChange;
        yChange += 2;
        if (((radiusError << 1) + xChange) > 0)
        {
            x--;
            radiusError += xChange;
            xChange += 2;
        }
    }
}
