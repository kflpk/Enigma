----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:42 01/07/2024 
-- Design Name: 
-- Module Name:    keyboard_reader - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keyboard_reader is
    Port ( clk         : in  STD_LOGIC;
			  kbd_data    : in  STD_LOGIC;
           kbd_clk     : in  STD_LOGIC;
			  letters     : out STD_LOGIC_VECTOR(23 downto 0);
			  led_clk     : out STD_LOGIC;
			  led_data    : out STD_LOGIC
			 );
end keyboard_reader;

architecture Behavioral of keyboard_reader is
	signal sreg : STD_LOGIC_VECTOR(30 downto 0) := (others => '0');
	signal letters_sig : STD_LOGIC_VECTOR(23 downto 0);
begin
	process(kbd_clk)
	begin
		if rising_edge(kbd_clk) then
			sreg <= sreg(sreg'high - 1 downto sreg'low) & kbd_data;
		end if;
	end process;
	
	letters <= sreg(28 downto 21) & sreg(18 downto 11) & sreg(8 downto 1);
end Behavioral;

