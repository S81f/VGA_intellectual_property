------------------------------------------------------------------
-- Engineer: Saif Saadaldin
-- 
-- Create Date: 06/jan-2021
-- Design Name: vga_sync_signals.vhd
-- Target Devices: Max 10 FPGA
-- Tool versions: Quartus 18.1
-- Testbench file:
-- Do file: -
-- Description: 
-- declearing the ram that will save the color values for each pixel 
-- on the VGA monitor.
--
-- True Dual-Port RAM with dual clock
-- Read-during-write on port A or B returns newly written data
-- Read-during-write on port A and B returns unknown data.
-- 
--
-- Validated with "ModelSim - Altera" and verified with DE10-Lite board
-- 
---------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_RAM is


	port 
	(
		clk_50        : in std_logic; -- 50mhz to drive the write and read from/to cpu
		clk_25        : in std_logic; -- 25mwhz to drive the vga signals
		
		-- number of pixels = 76800 (320*240). That gives 16 bits address
		vga_addr      : in std_logic_vector(16 downto 0); --incoming address from vga_sync_signals
		cpu_addr	     : in std_logic_vector(16 downto 0); --incoming address from cpu
		
		--cpu_data_in : in	std_logic_vector(2 downto 0); --cpu data_in för port a (not used for now)
		cpu_data_in   : in std_logic_vector(2 downto 0); --cpu data_in för port b

		cpu_we_n      : in std_logic; --write_enable
	  
		vga_data      : out std_logic_vector(2 downto 0); --data out to vga_sync_signals
		cpu_data_out  : out std_logic_vector(2 downto 0) --data out to the cpu
	);

end VGA_RAM;

architecture behavioral of VGA_RAM is

--================================== Build a 2-D array type for the RAM ===============================

	subtype word_t is std_logic_vector(2 downto 0);-- the data is the value that decide the color and its 3-bits
	type memory_t is array(76800-1 downto 0) of word_t;
	

	--Declare the RAM 
	shared variable ram : memory_t;

begin

--========================================= Port A =====================================================

--Via port A the vga_sync_signals will be reading color data from RAM 
	process(clk_25)
	begin
	if(rising_edge(clk_25)) then 
        vga_data <= ram(to_integer(unsigned(vga_addr)));
	end if;
	end process;
	
--============================================ Port B ===================================================

-- Via port b we will be writing color data to the RAM from cpu. Also sending requested values to the cpu
	process(clk_50)
	begin
	if(rising_edge(clk_50)) then 
		if(cpu_we_n = '0') then
		    ram(to_integer(unsigned(cpu_addr))) := cpu_data_in;
		end if;
        cpu_data_out <= ram(to_integer(unsigned(cpu_addr)));
	end if;
	end process;

end behavioral;
