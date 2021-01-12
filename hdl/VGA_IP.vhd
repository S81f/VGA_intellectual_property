------------------
-- Engineer: Saif Saadaldin
--
-- Create Date: 06/jan-2021
-- Design Name: VGA_IP
-- Target Devices: Max 10 FPGA
-- Tool versions: Quartus 18.1 a
-- Testbench file: VGA_IP_vhd_tst
-- Do file: -
-- Description: 
-- This file is the top file of this VGA IP system. The IP can be instantiated as 
-- a standalone component in the Plattform Designer tool along with the .tcl files.
-- Just copy the dirictory "IP" and paste it at the dirictory of the project you want to
-- use this IP in. The component will then shows up in Plattform Designer upon start 
--
-- Validated with "ModelSim - Altera" and verified with DE10-Lite board
--
--------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY VGA_IP IS
PORT(


reset_n           : in std_logic;
clock_50          : in std_logic;
-- vga clock and signals
clock_25          : in std_logic;
VGA_HS, VGA_VS    : out std_logic;
VGA_R             : out std_logic_vector(3 DOWNTO 0);--red 
VGA_G             : out std_logic_vector(3 DOWNTO 0);--green
VGA_B             : out std_logic_vector(3 DOWNTO 0);--blue

-- avalon bus
cs_n              : in std_logic;
addr              : in std_logic_vector(18 DOWNTO 0);  -- the address the cpu want to write to or read from the RAM. Cant be 32 bits, gives compile error!
data_out          : out std_logic_vector(31 DOWNTO 0); -- color output if requesed from cpu
data_in           : in std_logic_vector(31 DOWNTO 0);  --input from cpu that tells the color value
write_n		      : in std_logic := '1';               --write enable
read_n            : in std_logic := '1'                --read enable

);

END VGA_IP;

ARCHITECTURE BEHAVIORAL OF VGA_IP IS

	

	COMPONENT vga_sync_signals
		PORT(
            CLOCK_25   : in std_logic;
            RESET_N    : in std_logic;
			DATA_IN    : in std_logic_vector(2 DOWNTO 0);
	        VGA_VS     : out std_logic;
            VGA_HS     : out std_logic;
            VGA_R      : out std_logic_vector(3 DOWNTO 0);--red 
            VGA_G      : out std_logic_vector(3 DOWNTO 0);--green
            VGA_B      : out std_logic_vector(3 DOWNTO 0);--blue
            ADDRESS    : out std_logic_vector(16 DOWNTO 0)
		);

	END COMPONENT;
	
	
	COMPONENT VGA_RAM
		PORT(
        clk_50       : in std_logic;
        clk_25       : in std_logic;
        vga_addr      : in std_logic_vector(16 downto 0); --incoming address from vga_sync_signals
        cpu_addr	    : in std_logic_vector(16 downto 0); --incoming address from cpu
		cpu_data_in   : in std_logic_vector(2 downto 0);
		cpu_we_n      : in std_logic; --write_enable
        vga_data		 : out std_logic_vector(2 downto 0); -- requested data to the vga_sync_signals
        cpu_data_out	 : out std_logic_vector(2 downto 0) --requested data to the RAM
		);
		
	END COMPONENT;
	
	
	signal	vga_data_intern_signal              :  std_logic_vector(2 DOWNTO 0);
	signal	address_vga_to_ram_intern_signal    :  std_logic_vector(16 DOWNTO 0);
	signal   s_cpu_data_out                      :  std_logic_vector(2 DOWNTO 0);
	signal   s_data_in                           :  std_logic_vector(2 downto 0);
	
	signal   s_cpu_we_n                          :  std_logic := '1';
    signal   s_cpu_re_n                          :  std_logic := '1';
		
BEGIN


--============================================================================================

	B2V_INST_VGA_RAM:	VGA_RAM
		PORT MAP(
			vga_addr     =>  address_vga_to_ram_intern_signal,
			cpu_addr     =>  addr(16 downto 0),
		
			clk_25       =>  clock_25,
			clk_50        =>  cloCK_50,
		 
			cpu_data_in   =>  s_data_in,

			cpu_we_n      =>  s_cpu_we_n,
		
			cpu_data_out     =>  s_cpu_data_out, -- output to cpu
			vga_data      =>  vga_data_intern_signal
		);
--============================================================================================

	B2V_INST_vga_sync_signals:	vga_sync_signals
		PORT MAP(
			cloCK_25  => clock_25,
			RESET_N   => reset_n,			
			VGA_HS    => VGA_HS,
			VGA_VS    => VGA_VS,
			VGA_B     => VGA_B,
			VGA_G     => VGA_G,
			VGA_R     => VGA_R,
			
			DATA_IN   => vga_data_intern_signal,
			ADDRESS   => address_vga_to_ram_intern_signal
		);
--============================================================================================



--===================================  cpu reading from vga_ip ==============================
    bus_read_process:
	 process(cs_n, read_n, cloCK_50)
	 begin
			    -- Sequential Statement(s)
         if(rising_edge(cloCK_50))then
			    if(cs_n = '0' and read_n = '0')then
                    data_out(31 downto 3) <= (others => '0');
			        data_out(2 downto 0) <= s_cpu_data_out;
             end if;
			end if;
	 end process;
	 
--================================== cpu writing to vga_ip ==================================
    bus_write_process:
	 process(reset_n , cloCK_50)
	 begin
	     if(reset_n = '0')then
		      s_cpu_we_n <= '1';
		  elsif(rising_edge(cloCK_50))then
		      if(cs_n = '0'and write_n = '0')then
				    s_cpu_we_n <= '0';
                    s_data_in <= data_in(2 downto 0);
				else
				    s_cpu_we_n <= '1';
				end if;
			end if;	 
	 end process;
	
END BEHAVIORAL;

