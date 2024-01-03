----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:27 12/28/2023 
-- Design Name: 
-- Module Name:    Rotor1 - Behavioral 
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use work.types.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rotor1 is 
    Generic ( mapping : in t_alphabet := (0,1,2,
					3,5,4,6,7,8,9,10,11,12,13,14,15,
					16,17,18,19,20,21,22,23,24,25,26)
				);
	 Port ( x1   : in   STD_LOGIC_VECTOR (5 downto 0);
           y1   : out  STD_LOGIC_VECTOR (5 downto 0);
           x2   : in   STD_LOGIC_VECTOR (5 downto 0);
           y2   : out  STD_LOGIC_VECTOR (5 downto 0);
           clk  : in   STD_LOGIC;
           rst  : in   STD_LOGIC;
           data : in   STD_LOGIC_VECTOR (5 downto 0);
			  load : in   STD_LOGIC
			  );
end Rotor1;

architecture Structural of Rotor1 is
	signal Q_INT      : STD_LOGIC_VECTOR (5 downto 0); -- the offset value
	signal LETTER_IN  : STD_LOGIC_VECTOR (5 downto 0); -- before translation 
	signal LETTER_OUT : STD_LOGIC_VECTOR (5 downto 0); -- after translation
	signal test 		: STD_LOGIC_VECTOR (5 downto 0);
	
	component mod26counter is port( 
			  Q    : out  STD_LOGIC_VECTOR (5 downto 0); 
           data : in   STD_LOGIC_VECTOR (5 downto 0);
           load : in   STD_LOGIC;
           clk  : in   STD_LOGIC;
           clr  : in   STD_LOGIC);
	end component;
begin
	cntr : mod26counter port map(
		Q => Q_INT,
		data => data,
		load => load,
		clr => rst,
		clk => clk
	);
	
	process(x1, Q_INT, clk)
	begin
		if x1 + Q_INT < 26 then
			LETTER_IN <= (x1 + Q_INT);
		else
			LETTER_IN <= (x1 + Q_INT - 26);
		end if;
	end process;
	
	process(LETTER_IN)
	begin
		if LETTER_IN >= 0 and LETTER_IN < 26 then
			LETTER_OUT <= std_logic_vector( to_unsigned(mapping(to_integer(unsigned(LETTER_IN))), LETTER_OUT'length));
		end if;
	end process;
	
	y1 <= LETTER_OUT - Q_INT when (LETTER_OUT - Q_INT >= 0 and LETTER_OUT - Q_INT < 26) else (LETTER_OUT - Q_INT - 38);
	test <= "000000" - "001001";
end Structural;

 