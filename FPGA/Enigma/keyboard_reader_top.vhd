----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:03:42 01/10/2024 
-- Design Name: 
-- Module Name:    keyboard_reader_top - Behavioral 
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

entity keyboard_reader_top is
	Port (
			clk         : in  STD_LOGIC;
			kbd_data    : in  STD_LOGIC;
         kbd_clk     : in  STD_LOGIC;
			--letters     : out STD_LOGIC_VECTOR(23 downto 0);
			--led_clk     : out STD_LOGIC;
			seg			: out STD_LOGIC_VECTOR(7 downto 0);
			an				: out STD_LOGIC_VECTOR(3 downto 0)
	);
end keyboard_reader_top;

architecture Behavioral of keyboard_reader_top is
		COMPONENT keyboard_reader
		PORT(
			clk : IN  std_logic;
			kbd_data : IN  std_logic;
			kbd_clk : IN  std_logic;
			letters : OUT  std_logic_vector(23 downto 0);
			led_clk : OUT  std_logic;
			led_data : OUT  std_logic
		  );
		END COMPONENT;
	 
		component seven_segment is 
		port( 
			segments : out  STD_LOGIC_VECTOR (7 downto 0);
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
	 
	 signal scancodes : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
	 signal clk_pre : STD_LOGIC;
begin
	kbd : keyboard_reader port map(
		clk => clk,
		kbd_data => kbd_data,
		kbd_clk  => kbd_clk,
		letters => scancodes
	);
	
	ssg : seven_segment port map(
		segments => seg,
		digits   => an,
		clk      => clk_pre,
		hex_in   => scancodes(15 downto 0)
		--hex_in   => X"1234"
	);
	
	presc : sevenseg_prescaler port map(
		clk => clk,
		clk_pre => clk_pre
	);
	
end Behavioral;

