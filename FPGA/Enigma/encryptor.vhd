----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:24:26 02/13/2024 
-- Design Name: 
-- Module Name:    encryptor - Structural 
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
use work.types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encryptor is
	port (
		letter_out : out STD_LOGIC_VECTOR(5 downto 0);
		letter_in  : in  STD_LOGIC_VECTOR(5 downto 0);
		clk        : in  STD_LOGIC;
		ce         : in  STD_LOGIC;
		ce_over    : in  STD_LOGIC;
		rst        : in  STD_LOGIC
	);
end encryptor;

architecture Structural of encryptor is
	
	-- COMPONENTS
	
	component Reflector is 
	Generic (
		mapping : in t_alphabet := (24,17,20,7,16,18,11,3,15,23,13,6,14,10,12,8,4,1,5,25,2,22,21,9,0,19)
		-- default wiring is UKW-B
	);
	Port ( 
			x : in   STD_LOGIC_VECTOR (5 downto 0);
			y : out  STD_LOGIC_VECTOR (5 downto 0)
			);
	end component;
	
	component Rotor is 
	Generic (
		fw_map : in t_alphabet;
		bw_map : in t_alphabet;
		turnover : integer range 0 to 25 := 16
	);
	Port  ( x1   : in   STD_LOGIC_VECTOR (5 downto 0);
           y1   : out  STD_LOGIC_VECTOR (5 downto 0);
           x2   : in   STD_LOGIC_VECTOR (5 downto 0);
           y2   : out  STD_LOGIC_VECTOR (5 downto 0);
           clk  : in   STD_LOGIC;
           rst  : in   STD_LOGIC;
           data : in   STD_LOGIC_VECTOR (5 downto 0);
			  load : in   STD_LOGIC;
			  ce   : in   STD_LOGIC;
			  ceo  : out  STD_LOGIC
	);
	end component;
	
	component mod26counter is 
	port	( Q    : out STD_LOGIC_VECTOR (5 downto 0);
           data : in  STD_LOGIC_VECTOR (5 downto 0);
           load : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
			  ce  : in STD_LOGIC
	);
	end component;
	
	-- SIGNALS
	-- first pass - from kbd on way to reflector
	signal r1_to_r2  : STD_LOGIC_VECTOR (5 downto 0);
	signal r2_to_r3  : STD_LOGIC_VECTOR (5 downto 0);
	signal r3_to_ref : STD_LOGIC_VECTOR (5 downto 0);
	-- second pass - from reflector, back through rotors to uart
	signal ref_to_r3 : STD_LOGIC_VECTOR (5 downto 0);
	signal r3_to_r2  : STD_LOGIC_VECTOR (5 downto 0);
	signal r2_to_r1  : STD_LOGIC_VECTOR (5 downto 0);
	-- clock enables
	signal ce1       : STD_LOGIC;
	signal ce2       : STD_LOGIC;
	signal ce3       : STD_LOGIC;
	signal ceo1      : STD_LOGIC;
	signal ceo2      : STD_LOGIC;
	signal ceo3      : STD_LOGIC;
begin
rot1 : Rotor
	generic map (
			-- Rotor I
			fw_map => (4,10,12,5,11,6,3,16,21,25,13,19,14,22,24,7,23,20,18,15,0,8,1,17,2,9),
			bw_map => (20,22,24,6,0,3,5,15,21,25,1,4,2,10,12,19,7,23,18,11,17,8,13,16,14,9),
			turnover => 16
	)
	port map(
		clk => clk,
		rst => rst,
		x1  => letter_in,
		y1  => r1_to_r2,
		data => (others => '0'),
		load => '0',
		x2   => r2_to_r1,
		y2   => letter_out,
		ce   => ce1,
		ceo  => ceo1
	);
	
	rot2 : Rotor
	generic map(
			-- Rotor II
			fw_map => (0,9,3,10,18,8,17,20,23,1,11,7,22,19,12,2,16,6,25,13,15,24,5,21,14,4),
			bw_map => (0,9,15,2,25,22,17,11,5,1,3,10,14,19,24,20,16,6,4,13,7,23,12,8,21,18),
			turnover => 4
	)
	port map(
		clk => clk,
		rst => rst,
		x1  => r1_to_r2,
		y1  => r2_to_r3,
		data => (others => '0'),
		load => '0',
		x2   => r3_to_r2,
		y2   => r2_to_r1,
		ce   => ce2,
		ceo  => ceo2
	);
	
	rot3 : Rotor
	generic map(
			-- Rotor III
			fw_map => (1,3,5,7,9,11,2,15,17,19,23,21,25,13,24,4,8,22,6,0,10,12,20,18,16,14),
			bw_map => (19,0,6,1,15,2,18,3,16,4,20,5,21,13,25,7,24,8,23,9,22,11,17,10,14,12),
			turnover => 21
	)
	port map(
		clk => clk,
		rst => rst,
		x1  => r2_to_r3,
		y1  => r3_to_ref,
		data => (others => '0'),
		load => '0',
		x2   => ref_to_r3,
		y2   => r3_to_r2,
		ce   => ce3,
		ceo  => ceo3
	);
	
	ref : Reflector
	port map(
		x => r3_to_ref,
		y => ref_to_r3
	);
	
	ce1 <= ce   or ce_over;
	ce2 <= ceo1 or ce_over;
	ce3 <= (ceo2 and ceo1) or ce_over;
end Structural;

