--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:53:53 12/28/2023
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/mod26counter_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mod26counter
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
 
ENTITY mod26counter_tb IS
END mod26counter_tb;
 
ARCHITECTURE behavior OF mod26counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mod26counter
    PORT(
         Q : OUT  std_logic_vector(5 downto 0);
         data : IN  std_logic_vector(5 downto 0);
         load : IN  std_logic;
         clk : IN  std_logic;
         clr : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data : std_logic_vector(5 downto 0) := (others => '0');
   signal load : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mod26counter PORT MAP (
          Q => Q,
          data => data,
          load => load,
          clk => clk,
          clr => rst
        );

   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   stim_proc: process
   begin		
      rst <= '1';
		wait for clk_period;
		rst <= '0';
      
		wait for 100 ns;	

      wait for clk_period*10;

      wait;
   end process;

	data_proc: process
	begin
		wait for clk_period*28;
		data <= "011101";
		wait for clk_period/2;
		load <= '1';
		wait for clk_period; 
		load <= '0';
		wait;
	end process;
END;
