--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:25:12 01/09/2024
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/keybard_reader_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keyboard_reader
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY keybard_reader_tb IS
END keybard_reader_tb;
 
ARCHITECTURE behavior OF keybard_reader_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keyboard_reader
    PORT(
         clk : IN  std_logic;
         kbd_data : IN  std_logic;
         kbd_clk : IN  std_logic;
         letters : OUT  std_logic_vector(23 downto 0);
         led_clk : OUT  std_logic;
         led_data : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal kbd_data : std_logic := '1';
   signal kbd_clk : std_logic := '1';

 	--Outputs
   signal letters : std_logic_vector(23 downto 0);
   signal led_clk : std_logic;
   signal led_data : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant kbd_clk_period : time := 10 ns;
   constant led_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keyboard_reader PORT MAP (
          clk => clk,
          kbd_data => kbd_data,
          kbd_clk => kbd_clk,
          letters => letters,
          led_clk => led_clk,
          led_data => led_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/20;
		clk <= '1';
		wait for clk_period/20;
   end process;
 
   kbd_clk_process :process
   begin
	
		wait for 10.25*clk_period;
		
		for i in 0 to 10 loop
			kbd_clk <= '0';
			wait for kbd_clk_period/2;
			kbd_clk <= '1';
			wait for kbd_clk_period/2;
		end loop;
   end process;
 
   led_clk_process :process
   begin
		led_clk <= '0';
		wait for led_clk_period/2;
		led_clk <= '1';
		wait for led_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10*clk_period;
		
		kbd_data <= '0';
		wait for clk_period;
		
		kbd_data <= '0';
		wait for clk_period;
		
		kbd_data <= '0';
		wait for clk_period;
		
		kbd_data <= '1';
		wait for clk_period;
		
		kbd_data <= '0';
		wait for clk_period;
		
		kbd_data <= '0';
		wait for clk_period;
		
		kbd_data <= '1';
		wait for clk_period;
		
		kbd_data <= '0';
		wait for clk_period;
		
		kbd_data <= '0';
		wait for clk_period;
		
		kbd_data <= '1';
		wait for clk_period;
		
		kbd_data <= '1';
		wait for clk_period;
		
   end process;

END;
