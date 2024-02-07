----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:42 01/07/2024 
-- Design Name: 
-- Module Name:    keyboard_reader - Behavioral 
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

entity keyboard_reader is
    Port ( clk         : in  STD_LOGIC;
			  kbd_data    : in  STD_LOGIC;
           kbd_clk     : in  STD_LOGIC;
			  letters     : out STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
			  led_clk     : out STD_LOGIC;
			  led_data    : out STD_LOGIC
			 );
end keyboard_reader;

architecture Behavioral of keyboard_reader is
	signal sreg : STD_LOGIC_VECTOR(32 downto 0) := (others => '0');
	signal letters_sig : STD_LOGIC_VECTOR(23 downto 0);
	signal prev_clk    : STD_LOGIC := '1';
	type state_t is (s_idle, s_start, s_rx, s_parity, s_stop);
	signal state : state_t := s_idle;
	signal parity_bit : STD_LOGIC;
	signal idx  : integer := 0;
	signal char_reg   : STD_LOGIC_VECTOR (7 downto 0);
begin
	process(kbd_clk)
	begin
		if falling_edge(kbd_clk) then
			--sreg <= sreg(sreg'high - 1 downto sreg'low) & kbd_data;
			sreg <= kbd_data & sreg(sreg'high downto sreg'low + 1);
		end if;
	end process;
	
	letters <=  sreg(9 downto  2) & sreg(19 downto 12) & sreg(30 downto 23);
	
--	process(clk)
--	begin
--		if rising_edge(clk) then
--			if	prev_clk = '1' and kbd_clk = '0' then  -- falling edge
--				case state is
--				when s_idle =>
--					state <= s_start;
--				when s_start =>
--					state <= s_rx;
--				when s_rx => 
--					if idx < 7 then
--						char_reg(idx) <= kbd_data;
--						idx <= idx + 1;
--					else 
--						char_reg(idx) <= kbd_data;
--						idx   <= 0;
--						state <= s_parity;
--					end if;
--				
--					
--				when s_parity =>
--					state <= s_stop;
--				when s_stop =>
--					state <= s_idle;
--				end case;
--			end if;
--		
--			prev_clk <= kbd_clk;
--		end if;
--	end process;
--	
--	letters(7 downto 0) <= char_reg;
	
end Behavioral;

