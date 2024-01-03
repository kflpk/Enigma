----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:48 01/02/2024 
-- Design Name: 
-- Module Name:    Rotor_top - Structural 
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

entity Rotor_top is
    Port ( letter_out : out STD_LOGIC_VECTOR (5 downto 0);
           cntr_leds  : out STD_LOGIC_VECTOR (5 downto 0);
			  letter_in  : in  STD_LOGIC_VECTOR (5 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end Rotor_top;

architecture Structural of Rotor_top is
	component Rotor1 is 
	Port  ( x1   : in   STD_LOGIC_VECTOR (5 downto 0);
           y1   : out  STD_LOGIC_VECTOR (5 downto 0);
           x2   : in   STD_LOGIC_VECTOR (5 downto 0);
           y2   : out  STD_LOGIC_VECTOR (5 downto 0);
           clk  : in   STD_LOGIC;
           rst  : in   STD_LOGIC;
           data : in   STD_LOGIC_VECTOR (5 downto 0);
			  load : in   STD_LOGIC
	);
	end component;
	
	component mod26counter is 
	port	( Q    : out STD_LOGIC_VECTOR (5 downto 0);
           data : in  STD_LOGIC_VECTOR (5 downto 0);
           load : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           clr : in  STD_LOGIC
	);
	end component;
	
	component seven_segment is 
	Port ( segments : out  STD_LOGIC_VECTOR (7 downto 0);
          digits : out  STD_LOGIC_VECTOR (3 downto 0);
          hex_in : in  STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
          clk : in  STD_LOGIC
			);
	end component;
begin
	cnt : mod26counter port map(
		clk => clk,
		clr => rst,
		Q   => cntr_leds,
		data => (others => '0'),
		load => '0'
	);
	
	rot : Rotor1 port map(
		clk => clk,
		rst => rst,
		x1  => letter_in,
		y1  => letter_out,
		data => (others => '0'),
		load => '0',
		x2   => (others => '0') 
	);
end Structural;

