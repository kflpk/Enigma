--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:11:56 02/13/2024
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/mod26_to_ascii_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mod26_to_ascii
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY mod26_to_ascii_tb IS
END mod26_to_ascii_tb;
 
ARCHITECTURE behavior OF mod26_to_ascii_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mod26_to_ascii
    PORT(
         ascii : OUT  std_logic_vector(7 downto 0);
         letter : IN  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal letter : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ascii : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mod26_to_ascii PORT MAP (
          ascii => ascii,
          letter => letter
        );

   -- Stimulus process
   stim_proc: process
   begin		
		for i in 0 to 24 loop
			wait for period;
			letter <= letter + 1;
		end loop;
      wait;
   end process;

END;
