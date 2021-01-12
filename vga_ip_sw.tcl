create_driver driver_name_vga_avalon_ip
#importent that hw_class_name is the same as the name in hw.tcl set_module_property vga_ip
set_sw_property hw_class_name vga_ip
set_sw_property version 1
set_sw_property min_compatible_hw_version 1.0
add_sw_property bsp_subdirectory drivers
add_sw_property c_source HAL/src/vga_avalon_interface.c
add_sw_property include_source HAL/inc/vga_avalon_interface.h
add_sw_property include_source HAL/inc/sign_font.h
add_sw_property supported_bsp_type HAL