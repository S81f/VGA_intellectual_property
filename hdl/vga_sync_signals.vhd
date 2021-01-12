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
-- VGA controller that draws pixel value from VGA ram
-- The module outputs draw image at 640x480, but uses a 320x240 RAM. 
-- Each pixel is used 4 times in order to cover entire monitor.
-- 
--
-- Validated with "ModelSim - Altera" and verified with DE10-Lite board
-- 
---------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY vga_sync_signals IS

PORT(

	CLOCK_25 :  IN  STD_LOGIC; --25 MHz

	RESET_N  :  IN  STD_LOGIC;

	VGA_VS   :  OUT  STD_LOGIC; --vertical sync. Decides when new column begin
	VGA_HS   :  OUT  STD_LOGIC; --horizontal sync. Decides when new raw begin

	VGA_R    :  OUT  STD_LOGIC_VECTOR(3 downto 0); --red 
	VGA_G    :  OUT  STD_LOGIC_VECTOR(3 downto 0); --green
	VGA_B    :  OUT  STD_LOGIC_VECTOR(3 downto 0); --blue

	DATA_IN  :  IN   STD_LOGIC_VECTOR(2 DOWNTO 0); -- data input from RAM
	ADDRESS  :  OUT  STD_LOGIC_VECTOR(16 DOWNTO 0) -- vga_sync_signals askes RAM to send data for the requested ADDRESS

);

END vga_sync_signals;

--------------------------- COUNTER_PROCESS -------------------------

ARCHITECTURE behavioral OF vga_sync_signals IS
	
	
    SIGNAL X_COUNTER    :    integer range 0 to 799; -- x pixel counters
    SIGNAL Y_COUNTER    :    integer range 0 to 524; -- y pixel counters
	

	
BEGIN
--

	COUNTER_PROCESS	:	PROcESS	(CLOCK_25, RESET_N)
	BEGIN
			if (RESET_N = '0') then
				X_COUNTER <= 0;
                Y_COUNTER <= 0;
			elsif rising_edge(CLOCK_25) then
				if (X_COUNTER = 799) then -- reset x_cOUNTER
				    X_COUNTER <= 0;
					if (Y_COUNTER = 524) then --reset y_cOUNTER
					    Y_COUNTER <= 0;
                    else
					    Y_COUNTER <= Y_COUNTER + 1; --new raw
				    end if;
				else
                    X_COUNTER <= X_COUNTER + 1; --new column
			    end if;
			end if;
	END PROcESS;
	
	
	---------------------------- SYNC PULSES ---------------------------------

	VGA_HS <= '1' WHEN ((X_COUNTER <= (656)) OR (X_COUNTER > (752))) ELSE '0';
	
    VGA_VS <= '1' WHEN ((Y_COUNTER <= (490)) OR (Y_COUNTER > (492))) ELSE '0';

	---------------------------- SYNC PULSES ----------------------------------
	
	
    -- converting integers (The actuell pixel number) to ram address
    ADDRESS <= std_logic_vector(to_unsigned((320 * (Y_COUNTER/2)) + (X_COUNTER/2),17)) when (X_COUNTER < 640) and (Y_COUNTER < 480) else (others => '0');  
    	
    --output signals for the RGB colors which will draw every pixel. If DATA_IN(0) = '1' then a red pixel will be drawn etc.
    VGA_R<="1111" when DATA_IN(2)='1' AND (X_COUNTER>=0 AND X_COUNTER <640) AND (Y_COUNTER>=0 AND Y_COUNTER<480) else "0000";
    VGA_G<="1111" when DATA_IN(1)='1' AND (X_COUNTER>=0 AND X_COUNTER <640) AND (Y_COUNTER>=0 AND Y_COUNTER<480) else "0000";
    VGA_B<="1111" when DATA_IN(0)='1' AND (X_COUNTER>=0 AND X_COUNTER <640) AND (Y_COUNTER>=0 AND Y_COUNTER<480) else "0000";


END behavioral;