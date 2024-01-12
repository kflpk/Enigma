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

entity Rotor is 
    Generic ( fw_map : in t_alphabet := (0,1,2,
					3,5,4,6,7,8,9,10,11,12,13,14,15,
					16,17,18,19,20,21,22,23,24,25);
					bw_map : in t_alphabet := (0,1,2,
					3,5,4,6,7,8,9,10,11,12,13,14,15,
					16,17,18,19,20,21,22,23,24,25)
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
end Rotor;

architecture Structural of Rotor is
	signal Q_INT      : STD_LOGIC_VECTOR (5 downto 0); -- the offset value
	signal LETTER_IN_FW  : STD_LOGIC_VECTOR (5 downto 0); -- before translation 
	signal LETTER_OUT_FW : STD_LOGIC_VECTOR (5 downto 0); -- after translation
	signal LETTER_IN_BW  : STD_LOGIC_VECTOR (5 downto 0); -- before translation 
	signal LETTER_OUT_BW : STD_LOGIC_VECTOR (5 downto 0); -- after translation
	-- signal test 		: STD_LOGIC_VECTOR (5 downto 0);
	
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
			LETTER_IN_FW <= (x1 + Q_INT);
		else
			LETTER_IN_FW <= (x1 + Q_INT - 26);
		end if;
	end process;
	
	process(x2, Q_INT, clk)
	begin
		if x2 + Q_INT < 26 then
			LETTER_IN_BW <= (x2 + Q_INT);
		else
			LETTER_IN_BW <= (x2 + Q_INT - 26);
		end if;
	end process;
	
	process(LETTER_IN_FW)
	begin
		if LETTER_IN_FW >= 0 and LETTER_IN_FW < 26 then
			LETTER_OUT_FW <= std_logic_vector( to_unsigned(fw_map(to_integer(unsigned(LETTER_IN_FW))), LETTER_OUT_FW'length));
		end if;
	end process;
	
	process(LETTER_IN_BW)
	begin
		if LETTER_IN_BW >= 0 and LETTER_IN_BW < 26 then
			LETTER_OUT_BW <= std_logic_vector( to_unsigned(bw_map(to_integer(unsigned(LETTER_IN_BW))), LETTER_OUT_BW'length));
		end if;
	end process;
	
	y1 <= LETTER_OUT_FW - Q_INT when (LETTER_OUT_FW - Q_INT >= 0 and LETTER_OUT_FW - Q_INT < 26) else (LETTER_OUT_FW - Q_INT - 38);
	y2 <= LETTER_OUT_BW - Q_INT when (LETTER_OUT_BW - Q_INT >= 0 and LETTER_OUT_BW - Q_INT < 26) else (LETTER_OUT_BW - Q_INT - 38);
end Structural;

 