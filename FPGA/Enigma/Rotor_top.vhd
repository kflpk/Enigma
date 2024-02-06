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
use work.types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rotor_top is
    Port ( letter_out_fw : inout STD_LOGIC_VECTOR (5 downto 0);
	        letter_out_bw : inout STD_LOGIC_VECTOR (5 downto 0);
           cntr_leds  : out STD_LOGIC_VECTOR (5 downto 0);
			  ceo        : out STD_LOGIC;
			  letter_in  : in  STD_LOGIC_VECTOR (5 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ce  : in  STD_LOGIC
			  );
end Rotor_top;

architecture Structural of Rotor_top is
	signal backfeed : STD_LOGIC_VECTOR (5 downto 0);
	
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
		load => '0',
		ce   => ce
	);
	
	rot1 : Rotor
	generic map (
			-- Rotor I
			fw_map => (4,10,12,5,11,6,3,16,21,25,13,19,14,22,24,7,23,20,18,15,0,8,1,17,2,9),
			bw_map => (20,22,24,6,0,3,5,15,21,25,1,4,2,10,12,19,7,23,18,11,17,8,13,16,14,9)
			
			-- Rotor II
			-- (0,9,3,10,18,8,17,20,23,1,11,7,22,19,12,2,16,6,25,13,15,24,5,21,14,4),
			-- (0,9,15,2,25,22,17,11,5,1,3,10,14,19,24,20,16,6,4,13,7,23,12,8,21,18)
			
			-- Rotor III
			-- (1,3,5,7,9,11,2,15,17,19,23,21,25,13,24,4,8,22,6,0,10,12,20,18,16,14)
			-- (19,0,6,1,15,2,18,3,16,4,20,5,21,13,25,7,24,8,23,9,22,11,17,10,14,12)
			
			-- Rotor IV
			-- (4,18,14,21,15,25,9,0,24,16,20,8,17,7,23,11,13,5,19,6,10,3,2,12,22,1)
			-- (7,25,22,21,0,17,19,13,11,6,20,15,23,16,2,4,9,12,1,18,10,3,24,14,8,5)
			
			-- Rotor V
			-- (21,25,1,17,6,8,19,24,20,15,18,3,13,7,11,23,0,22,12,9,16,14,5,4,2,10)
			-- (16,2,24,11,23,22,4,13,5,19,25,14,18,12,21,9,20,3,10,6,8,0,17,15,7,1)

			
			-- Rotor VI
			-- (9,15,6,21,14,20,12,5,24,16,1,4,13,7,25,17,3,10,0,18,23,11,8,2,19,22)
			-- (18,10,23,16,11,7,2,13,22,0,17,21,6,12,4,1,9,15,19,24,5,3,25,20,8,14)
			
			-- Rotor VII
			-- (13,25,9,7,6,17,2,23,12,24,18,22,1,14,20,5,0,8,21,11,15,4,10,16,3,19)
			-- (16,12,6,24,21,15,4,3,17,2,22,19,8,0,13,20,23,5,10,25,14,18,11,7,9,1)
			
			-- Rotor VIII
			-- (5,10,16,7,19,11,23,14,2,1,9,18,15,3,25,17,0,12,4,22,13,8,20,24,6,21)
			-- (16,9,8,13,18,0,24,3,21,10,1,5,17,20,7,12,2,15,11,4,22,25,19,6,23,14)
	)
	port map(
		clk => clk,
		rst => rst,
		x1  => letter_in,
		y1  => letter_out_fw,
		data => (others => '0'),
		load => '0',
		x2   => letter_out_fw,
		y2   => letter_out_bw,
		ce   => ce,
		ceo  => ceo
	);
end Structural;

