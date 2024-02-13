--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:47:53 02/13/2024
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/ascii_to_mod26_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ascii_to_mod26
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
 
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY ascii_to_mod26_tb IS
END ascii_to_mod26_tb;
 
ARCHITECTURE behavior OF ascii_to_mod26_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ascii_to_mod26
    PORT(
         ascii : IN  std_logic_vector(7 downto 0);
         letter : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ascii : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal letter : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ascii_to_mod26 PORT MAP (
          ascii => ascii,
          letter => letter
        );

   -- Stimulus process
   stim_proc: process
   begin		  
      -- hold reset state for 100 ns.
			ascii <= X"41";
			
			for i in 0 to 24 loop
				wait for period;
				ascii <= ascii + 1;
			end loop;
      -- insert stimulus here 

      wait;
   end process;

END;
