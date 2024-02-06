----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:15:48 02/04/2024 
-- Design Name: 
-- Module Name:    uart_tx - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx is
	Generic (
	        clk_freq   : integer := 10_000_000;
           baudrate   : integer := 9600;
			  parity_en  : boolean := true;
			  parity_eo  : integer := 1; 
			  data_width : integer := 8
			);    
	 Port ( 
			  tx       : out STD_LOGIC := '1';
			  tx_busy  : out STD_LOGIC := '0';
			  tx_data  : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           clk      : in  STD_LOGIC;
			  rst      : in  STD_LOGIC;
			  tx_start : in  STD_LOGIC
			);
end uart_tx;

architecture Behavioral of uart_tx is
	type t_tx_state is ( s_idle, s_start, s_trans, s_parity, s_stop);
	signal tx_state : t_tx_state := s_idle;
	signal parity_bit : STD_LOGIC; 
	--signal parity_cnt : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal tx_cnt  : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal tx_data_int : STD_LOGIC_VECTOR((data_width - 1) downto 0);
	signal tx_int     : STD_LOGIC := '1';
	signal busy_int   : STD_LOGIC := '0';
	
	constant cycles_per_bit : integer := clk_freq / baudrate + 1;
	signal clk_cnt : integer range 0 to cycles_per_bit := 0;
begin
	process(clk)
	begin 
		if rising_edge(clk) then
			case tx_state is 
				when s_idle => 
					tx_data_int <= tx_data;
					busy_int    <= '0';
					
					if tx_start = '1' then
						tx_state <= s_start;
						busy_int <= '1';
					end if;
				when s_start =>
					tx_int <= '0'; -- start bit is 0
					if clk_cnt < cycles_per_bit then
						clk_cnt <= clk_cnt + 1;
					else 
						clk_cnt <= 0;
						tx_state <= s_trans;
					end if;
				when s_trans => 
					
--					if tx_cnt < data_width then
--						tx_int <= tx_data_int(to_integer(unsigned(tx_cnt)));
--						tx_cnt <= tx_cnt + 1;
--					else
--						tx_cnt <= "00000";
--						
--						if parity_en then
--							tx_state <= s_parity;
--						else
--							tx_state <= s_stop;
--						end if;
--						
--					end if;

					tx_int <= tx_data_int(to_integer(unsigned(tx_cnt))); -- assign value
					
					if clk_cnt < cycles_per_bit then -- wait until bit end
						clk_cnt <= clk_cnt + 1;
						-- don't change state
					else -- proceed with transmission
						clk_cnt <= 0;
						
						if tx_cnt < data_width - 1 then
							tx_cnt <= tx_cnt + 1;
						else
							tx_cnt <= "00000";
							
							if parity_en = true then
								tx_state <= s_parity;
							else
								tx_state <= s_stop;
							end if;
						end if;
					end if;
				when s_parity =>
					tx_int <= '0'; -- temporary, to be fixed later, but probly not, 
									   -- 'cause i don't intent to use parity anyway
					if clk_cnt < cycles_per_bit then
						clk_cnt <= clk_cnt + 1;
					else 
						clk_cnt <= 0;
						tx_state <= s_stop;
					end if;
				when s_stop =>
					tx_int <= '1';
					
					if clk_cnt < cycles_per_bit then
						clk_cnt <= clk_cnt + 1;
						-- don't change state
					else 
						clk_cnt  <= 0;
						tx_state <= s_idle;
					end if;
			end case;
		end if;
	end process;
	
	tx <= tx_int;
	tx_busy <= busy_int;
	
end Behavioral;

