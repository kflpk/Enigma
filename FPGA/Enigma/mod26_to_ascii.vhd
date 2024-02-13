----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:46 02/13/2024 
-- Design Name: 
-- Module Name:    mod26_to_ascii - Behavioral 
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

use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod26_to_ascii is
		Port ( ascii  : out STD_LOGIC_VECTOR (7 downto 0);
             letter : in  STD_LOGIC_VECTOR (5 downto 0)
				);
end mod26_to_ascii;

architecture Behavioral of mod26_to_ascii is
	signal ascii_int : std_logic_vector(7 downto 0);
begin
	process(letter)
	begin
		ascii_int <= letter + X"41";
	end process;
	
	ascii <= ascii_int;
end Behavioral;

