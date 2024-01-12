----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:26 01/07/2024 
-- Design Name: 
-- Module Name:    Reflector - Behavioral 
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
use work.types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Reflector is
	Generic (
		mapping : in t_alphabet := (24,17,20,7,16,18,11,3,15,23,13,6,14,10,12,8,4,1,5,25,2,22,21,9,0,19)
		-- default wiring is UKW-B
	);
	Port ( 
			x : in   STD_LOGIC_VECTOR (5 downto 0);
			y : out  STD_LOGIC_VECTOR (5 downto 0)
			);
end Reflector;

architecture Behavioral of Reflector is
	signal letter_out : std_logic_vector (5 downto 0);
begin
	process(x)
	begin
		letter_out <= std_logic_vector( to_unsigned(mapping(to_integer(unsigned(x))), x'length));
	end process;
	
	y <= letter_out;
end Behavioral;

