--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:37:47 01/02/2024
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/rotor_top_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Rotor_top
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
 
ENTITY rotor_top_tb IS
END rotor_top_tb;
 
ARCHITECTURE behavior OF rotor_top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rotor_top
    PORT(letter_out_fw : inout STD_LOGIC_VECTOR (5 downto 0);
	      letter_out_bw : inout STD_LOGIC_VECTOR (5 downto 0);
         cntr_leds : OUT  std_logic_vector(5 downto 0);
			ceo       : out std_logic;
         letter_in : IN  std_logic_vector(5 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
			ce  : in  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal letter_in : std_logic_vector(5 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
	signal ce  : std_logic := '1';
	signal ceo : std_logic := '0';

 	--Outputs
   signal letter_out_fw : std_logic_vector(5 downto 0);
	signal letter_out_bw : std_logic_vector(5 downto 0);
   signal cntr_leds : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rotor_top PORT MAP (
          letter_out_fw => letter_out_fw,
			 letter_out_bw => letter_out_bw,
          cntr_leds => cntr_leds,
          letter_in => letter_in,
          clk => clk,
          rst => rst,
			 ce  => ce,
			 ceo => ceo
        );

   -- Clock process definitions
   clk_process : process
   begin
		
		for n in 0 to 3 loop
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
		end loop;
		
		wait for 10 * clk_period;
		
		for n in 0 to 26 loop
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
		end loop;
		--wait;
   end process;
 

   -- Stimulus process
   stim_proc : process
   begin		

		rst <= '1';
		
		wait for clk_period;
		
		rst <= '0';
		
		wait for clk_period;
		
		letter_in <= "000111";
		
		wait for clk_period;
		letter_in <= "000000";
		
		wait for clk_period;
		letter_in <= "000111";
		
		wait for clk_period;
		letter_in <= "010001";
		
		wait for 21*clk_period;
		letter_in <= "001010";
		
		wait for 15*clk_period;
		ce <= '0';
		
      wait;
   end process;

END;
