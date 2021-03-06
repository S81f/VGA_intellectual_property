# TCL File Generated by Component Editor 18.1
# Sat Jan 09 11:56:20 CET 2021
# DO NOT MODIFY


# 
# vga_ip "display_vga_ip" v1.0
# Saif Saadaldin 2021.01.09.11:56:20
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module vga_ip
# 
set_module_property DESCRIPTION ""
set_module_property NAME vga_ip
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP my_component
set_module_property AUTHOR "Saif Saadaldin"
set_module_property DISPLAY_NAME display_vga_ip
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL VGA_IP
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file VGA_IP.vhd VHDL PATH hdl/VGA_IP.vhd TOP_LEVEL_FILE
add_fileset_file VGA_RAM.vhd VHDL PATH hdl/VGA_RAM.vhd
add_fileset_file vga_sync_signals.vhd VHDL PATH hdl/vga_sync_signals.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock_50
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock_50
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitStates 2
set_interface_property avalon_slave_0 readWaitTime 2
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 cs_n chipselect_n Input 1
add_interface_port avalon_slave_0 addr address Input 19
add_interface_port avalon_slave_0 data_out readdata Output 32
add_interface_port avalon_slave_0 data_in writedata Input 32
add_interface_port avalon_slave_0 write_n write_n Input 1
add_interface_port avalon_slave_0 read_n read_n Input 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_25
# 
add_interface clock_25 clock end
set_interface_property clock_25 clockRate 0
set_interface_property clock_25 ENABLED true
set_interface_property clock_25 EXPORT_OF ""
set_interface_property clock_25 PORT_NAME_MAP ""
set_interface_property clock_25 CMSIS_SVD_VARIABLES ""
set_interface_property clock_25 SVD_ADDRESS_GROUP ""

add_interface_port clock_25 clock_25 clk Input 1


# 
# connection point clock_50
# 
add_interface clock_50 clock end
set_interface_property clock_50 clockRate 0
set_interface_property clock_50 ENABLED true
set_interface_property clock_50 EXPORT_OF ""
set_interface_property clock_50 PORT_NAME_MAP ""
set_interface_property clock_50 CMSIS_SVD_VARIABLES ""
set_interface_property clock_50 SVD_ADDRESS_GROUP ""

add_interface_port clock_50 clock_50 clk Input 1


# 
# connection point vga_signals
# 
add_interface vga_signals conduit end
set_interface_property vga_signals associatedClock clock_25
set_interface_property vga_signals associatedReset reset
set_interface_property vga_signals ENABLED true
set_interface_property vga_signals EXPORT_OF ""
set_interface_property vga_signals PORT_NAME_MAP ""
set_interface_property vga_signals CMSIS_SVD_VARIABLES ""
set_interface_property vga_signals SVD_ADDRESS_GROUP ""

add_interface_port vga_signals VGA_B vga_b Output 4
add_interface_port vga_signals VGA_G vga_g Output 4
add_interface_port vga_signals VGA_HS vga_hs Output 1
add_interface_port vga_signals VGA_R vga_r Output 4
add_interface_port vga_signals VGA_VS vga_vs Output 1

