----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:47 02/13/2024 
-- Design Name: 
-- Module Name:    ascii_to_mod26 - Behavioral 
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

entity ascii_to_mod26 is
    Port ( ascii : in  STD_LOGIC_VECTOR (7 downto 0);
           letter : out  STD_LOGIC_VECTOR (5 downto 0));
end ascii_to_mod26;

architecture Behavioral of ascii_to_mod26 is
	signal letter_int : std_logic_vector(7 downto 0);
begin
	process(ascii)
	begin
		letter_int <= ascii - X"41";
	end process;
	
	letter <= letter_int(5 downto 0);
end Behavioral;

