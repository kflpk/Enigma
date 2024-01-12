--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:39:13 01/07/2024
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/Reflector_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Reflector
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Reflector_tb IS
END Reflector_tb;
 
ARCHITECTURE behavior OF Reflector_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Reflector
    PORT(
         x : IN  std_logic_vector(5 downto 0);
         y : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal y : std_logic_vector(5 downto 0);
	signal i_sig : std_logic_vector(5 downto 0) := "000000";
	signal x_ascii : std_logic_vector(6 downto 0);
	signal y_ascii : std_logic_vector(6 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Reflector PORT MAP (
          x => x,
          y => y
        );

   -- Clock process definitions
--   clock_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		for i in 0 to 25 loop
			wait for 10 ns;
		--x <= std_logic_vector(to_unsigned(to_integer(i), x'length));
			i_sig <= i_sig + 1;
		end loop;
      wait;
   end process;
	
	x <= i_sig;
	x_ascii <= "0000000" + x + 65;
	y_ascii <= "0000000" + y + 65;

END;
