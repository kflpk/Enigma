----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:30:37 12/28/2023 
-- Design Name: 
-- Module Name:    seven_seg_top - Behavioral 
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

entity seven_seg_top is
    Port ( 
				leds     : out STD_LOGIC_VECTOR(7 downto 0);
				digits   : out STD_LOGIC_VECTOR(3 downto 0);
				segments : inout STD_LOGIC_VECTOR(7 downto 0);
				data : in  STD_LOGIC_VECTOR (7 downto 0);
				clk : in  STD_LOGIC);
end seven_seg_top;

architecture Behavioral of seven_seg_top is
	
	component seven_segment is 
	port(    segments : out  STD_LOGIC_VECTOR (7 downto 0);
				digits : out  STD_LOGIC_VECTOR (3 downto 0);
				hex_in : in  STD_LOGIC_VECTOR (15 downto 0);
				clk : in  STD_LOGIC);
	end component;
	
	component sevenseg_prescaler is
	port(
		clk_pre : out  STD_LOGIC := '0';
      clk : in  STD_LOGIC := '0'
	);
	end component;
	
	signal dummy : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal clk_pre : STD_LOGIC;
begin
	ssd : seven_segment port map(
		segments => segments,
		digits => digits,
		hex_in(7 downto 0) => data,
		hex_in(15 downto 8) => (X"21"),
		clk => clk_pre
	);
	
	presc : sevenseg_prescaler port map(
		clk => clk,
		clk_pre => clk_pre
	);
	leds <= segments;
end Behavioral;

