----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:30:19 12/28/2023 
-- Design Name: 
-- Module Name:    seven_segment - Behavioral 
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

entity seven_segment is
    Port ( segments : out  STD_LOGIC_VECTOR (7 downto 0);
           digits : out  STD_LOGIC_VECTOR (3 downto 0);
           hex_in : in  STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
           clk : in  STD_LOGIC);
end seven_segment;

architecture Behavioral of seven_segment is
	signal no_digit : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal digits_int : STD_LOGIC_VECTOR(3 downto 0);
	signal segments_int : STD_LOGIC_VECTOR(7 downto 0);
	signal current_digit: STD_LOGIC_VECTOR(3 downto 0);
	
	alias digit0 is hex_in(3  downto 0);
	alias digit1 is hex_in(7 downto 4);
	alias digit2 is hex_in(11  downto 8);
	alias digit3 is hex_in(15  downto 12);
begin
	process (clk)
	begin
		if rising_edge(clk) then
			if no_digit = "11" then
				no_digit <= "00";
			else
				no_digit <= no_digit + 1;
			end if;
		
		
			case no_digit is 
				when "00" => 
					digits_int <= "1110";
				when "01" => 
					digits_int <= "1101";
				when "10" => 
					digits_int <= "1011";
				when "11" => 
					digits_int <= "0111";
				when others =>
					digits_int <= "1111";
			end case;

		end if;		
	end process;

	process(no_digit)
	begin
		--if rising_edge(clk) then
			case no_digit is 
				when "00" => 
					current_digit <= digit0;
				when "01" => 
					current_digit <= digit1;
				when "10" => 
					current_digit <= digit2;
				when "11" => 
					current_digit <= digit3;
				when others =>
					current_digit <= "0000";
			end case;
		--end if;
	end process;
	
	process(current_digit) is 
	begin
		--if rising_edge(clk) then
			case current_digit is
				--------------------------- ABCDEFG.
				when "0000" => segments_int <= "00000011"; -- 0
				when "0001" => segments_int <= "10011111"; -- 1
				when "0010" => segments_int <= "00100101"; -- 2
				when "0011" => segments_int <= "00001101"; -- 3
				when "0100" => segments_int <= "10011001"; -- 4
				when "0101" => segments_int <= "01001001"; -- 5
				when "0110" => segments_int <= "01000001"; -- 6
				when "0111" => segments_int <= "00011111"; -- 7
				when "1000" => segments_int <= "00000001"; -- 8
				when "1001" => segments_int <= "00001001"; -- 9
				when "1010" => segments_int <= "00010001"; -- A
				when "1011" => segments_int <= "11000001"; -- B
				when "1100" => segments_int <= "01100011"; -- C
				when "1101" => segments_int <= "10000101"; -- D
				when "1110" => segments_int <= "01100001"; -- E
				when "1111" => segments_int <= "01110001"; -- F
				when others => segments_int <= "11111111";
			end case;
		--end if;
	end process;

	digits <= digits_int;
	segments <= segments_int;
	

end Behavioral;

