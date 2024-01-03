----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:27:16 12/28/2023 
-- Design Name: 
-- Module Name:    mod26counter - Behavioral 
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
-- use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod26counter is
    Port ( Q : out  STD_LOGIC_VECTOR (5 downto 0);
           data : in  STD_LOGIC_VECTOR (5 downto 0);
           load : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           clr : in  STD_LOGIC);
end mod26counter;

architecture Behavioral of mod26counter is
	signal Q_INT: STD_LOGIC_VECTOR(5 downto 0);
begin		
	process (clk)	
	begin
		if clk'event and clk='1' then
			if clr='1' then
				Q_INT <= "000000";
			else	
				if load = '1' then
					Q_INT <= data;
				elsif Q_INT = 25 or Q_INT > 25 then
					Q_INT <= "000000";
				else 
					Q_INT <= Q_INT + 1;
				end if;
				
			end if;
		end if;	
	end process;
	Q <= Q_INT;
end Behavioral;

