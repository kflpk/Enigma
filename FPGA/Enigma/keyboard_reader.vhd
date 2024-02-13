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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keyboard_reader is
    Port ( clk         : in  STD_LOGIC;
			  async_rst   : in  STD_LOGIC := '0';
			  kbd_data    : in  STD_LOGIC;
           kbd_clk     : in  STD_LOGIC;
			  letters     : out STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
			  led_clk     : out STD_LOGIC;
			  led_data    : out STD_LOGIC;
			  ascii       : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0')
			 );
end keyboard_reader;

architecture Behavioral of keyboard_reader is
	type state_t is (s_idle, s_start, s_rx, s_parity, s_stop);
	
	signal sreg        : STD_LOGIC_VECTOR(32 downto 0) := (others => '0');
	signal letters_sig : STD_LOGIC_VECTOR(23 downto 0);
	signal prev_clk    : STD_LOGIC := '1';	
	signal state       : state_t := s_idle;
	signal parity_bit  : STD_LOGIC;
	signal idx         : integer := 0;
	signal char_reg    : STD_LOGIC_VECTOR (7 downto 0);
	signal ascii_int   : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal counter     : integer range 0 to 11 := 0;
	signal out_en      : STD_LOGIC := '0';
begin
	process(kbd_clk)
	begin
		if falling_edge(kbd_clk) then
			--sreg <= sreg(sreg'high - 1 downto sreg'low) & kbd_data;
			if counter = 10 then
				counter <= 0;
				out_en  <= '1';
			else 
				counter <= counter + 1;
			end if;
			
			sreg <= kbd_data & sreg(sreg'high downto sreg'low + 1); -- shift right
		end if;
	end process;
	
	--process(async_rst) 
	--begin
	--	if (async_rst = '1') then
	--		counter <= 0;
	--		out_en  <= '0';
	--	end if;
	--end process;
	
	process(sreg)
	begin
		if sreg(19 downto 12) = X"F0" then
			case sreg(30 downto 23) is
--				when => X"15" ascii_int <= "51"; -- Q
--				when => X"1D" ascii_int <= "57"; -- W
--				when => X"24" ascii_int <= "45"; -- E
--				when => X"2D" ascii_int <= "52"; -- R
--				when => X"2C" ascii_int <= "54"; -- T
--				when => X"35" ascii_int <= "59"; -- Y
--				when => X"3C" ascii_int <= "55"; -- U
--				when => X"43" ascii_int <= "49"; -- I
--				when => X"44" ascii_int <= "4F"; -- O
--				when => X"4d" ascii_int <= "50"; -- P
--				when => X"1C" ascii_int <= "41"; -- A
--				when => X"1B" ascii_int <= "53"; -- S
--				when => X"23" ascii_int <= "44"; -- D
--				when => X"2B" ascii_int <= "46"; -- F
--				when => X"34" ascii_int <= "47"; -- G
--				when => X"33" ascii_int <= "48"; -- H
--				when => X"3B" ascii_int <= "4A"; -- J
--				when => X"42" ascii_int <= "4B"; -- K
--				when => X"4B" ascii_int <= "4C"; -- L
--				when => X"1A" ascii_int <= "5A"; -- Z
--				when => X"22" ascii_int <= "58"; -- X
--				when => X"21" ascii_int <= "43"; -- C
--				when => X"2A" ascii_int <= "56"; -- V
--				when => X"32" ascii_int <= "42"; -- B
--				when => X"31" ascii_int <= "4E"; -- N
--				when => X"3A" ascii_int <= "4D"; -- M

				when X"15" => ascii_int <= X"51"; -- Q
				when X"1D" => ascii_int <= X"57"; -- W
				when X"24" => ascii_int <= X"45"; -- E
				when X"2D" => ascii_int <= X"52"; -- R
				when X"2C" => ascii_int <= X"54"; -- T
				when X"35" => ascii_int <= X"59"; -- Y
				when X"3C" => ascii_int <= X"55"; -- U
				when X"43" => ascii_int <= X"49"; -- I
				when X"44" => ascii_int <= X"4F"; -- O
				when X"4d" => ascii_int <= X"50"; -- P
				when X"1C" => ascii_int <= X"41"; -- A
				when X"1B" => ascii_int <= X"53"; -- S
				when X"23" => ascii_int <= X"44"; -- D
				when X"2B" => ascii_int <= X"46"; -- F
				when X"34" => ascii_int <= X"47"; -- G
				when X"33" => ascii_int <= X"48"; -- H
				when X"3B" => ascii_int <= X"4A"; -- J
				when X"42" => ascii_int <= X"4B"; -- K
				when X"4B" => ascii_int <= X"4C"; -- L
				when X"1A" => ascii_int <= X"5A"; -- Z
				when X"22" => ascii_int <= X"58"; -- X
				when X"21" => ascii_int <= X"43"; -- C
				when X"2A" => ascii_int <= X"56"; -- V
				when X"32" => ascii_int <= X"42"; -- B
				when X"31" => ascii_int <= X"4E"; -- N
				when X"3A" => ascii_int <= X"4D"; -- M
				when X"29" => ascii_int <= X"20"; -- space 
				when others => ascii_int <= X"00"; -- NULL
			end case;
			
			out_en <= '0';
		end if;
	end process;
	
	letters <=  sreg(8 downto  1) & sreg(19 downto 12) & sreg(30 downto 23);
	ascii   <= ascii_int;
	
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

