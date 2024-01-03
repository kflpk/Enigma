----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:23:02 12/29/2023 
-- Design Name: 
-- Module Name:    sevenseg_prescaler - Behavioral 
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

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevenseg_prescaler is
    Port ( clk_pre : out  STD_LOGIC := '0';
           clk : in  STD_LOGIC := '0');
end sevenseg_prescaler;

architecture Behavioral of sevenseg_prescaler is
	signal clk_counter : std_logic_vector(31 downto 0) := (others => '0');
	signal clk_pre_int : std_logic;
begin
	process(clk)
	begin 
		if rising_edge(clk) then 
			clk_counter <= clk_counter + 1; 
			if clk_counter = 100000 then 
				clk_counter <= (others => '0');
				if clk_pre_int = '1' then
					clk_pre_int <= '0';
				elsif clk_pre_int = '0' then
					clk_pre_int <= '1';
				end if;
			end if; 
		end if; 
	end process;
	
	clk_pre <= clk_pre_int;
end Behavioral;

