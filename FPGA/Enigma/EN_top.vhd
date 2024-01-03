----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:30:53 12/27/2023 
-- Design Name: 
-- Module Name:    EN_top - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--use ieee.numeric_std_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EN_top is
    Port ( Q : out  STD_LOGIC_VECTOR(7 downto 0);
			  clk : in STD_LOGIC;
			  clr : in STD_LOGIC
			);
end EN_top;

architecture Behavioral of EN_top is
	signal Q_INT: STD_LOGIC_VECTOR(7 downto 0);
	signal counter: STD_LOGIC_VECTOR(63 downto 0);
begin
	process (CLK)
		-- internal variable Q_INT
begin
		if clk'event and clk='1' then
			if clr='1' then
				Q_INT <= "00000000";
			elsif counter = O"100000000" then
				Q_INT <= Q_INT + 1;
				counter <= (others => '0');
			else
				counter <= counter + 1;
			end if;
		end if;	
		
	end process;
	
	Q <= Q_INT;

	
	

end Behavioral;

