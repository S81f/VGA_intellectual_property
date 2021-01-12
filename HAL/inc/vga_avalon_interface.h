/*
 * vga_avalon_interface.h
 *
 *  Created on: Jan 9, 2021
 *      Author: Saif
 */

#ifndef VGA_AVALON_INTERFACE_H_
#define VGA_AVALON_INTERFACE_H_

#include <system.h>
#include <io.h>


#define print_pix(x, y, color) IOWR_32DIRECT(VGA_IP_0_BASE,((320*(y)+(x))*4),(color))

#define read_pixel_ram_int(x, y) IORD_32DIRECT(VGA_IP_0_BASE,(320*(y)+(x))*4)

void clear_screen(alt_u32 color);
	
void print_hline(alt_u32 x,alt_u32 y,alt_u32 line_lenght,alt_u32 color);

void print_char(alt_32 x, alt_32 y, alt_u8 tty_char,alt_32 color, alt_u32 BGcolor);

void print_circle(alt_32 x0, alt_32 y0, alt_32 radius,alt_32 color);


#endif /* VGA_AVALON_INTERFACE_H_ */
