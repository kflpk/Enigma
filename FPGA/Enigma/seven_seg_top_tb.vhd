--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:03:44 12/29/2023
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/seven_seg_top_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: seven_seg_top
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
 
ENTITY seven_seg_top_tb IS
END seven_seg_top_tb;
 
ARCHITECTURE behavior OF seven_seg_top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seven_seg_top
    PORT(
         leds : OUT  std_logic_vector(7 downto 0);
         digits : OUT  std_logic_vector(3 downto 0);
         segments : INOUT  std_logic_vector(7 downto 0);
         data : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';

	--BiDirs
   signal segments : std_logic_vector(7 downto 0);

 	--Outputs
   signal leds : std_logic_vector(7 downto 0);
   signal digits : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: seven_seg_top PORT MAP (
          leds => leds,
          digits => digits,
          segments => segments,
          data => data,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		
		data <= X"37";
      wait;
   end process;

END;
