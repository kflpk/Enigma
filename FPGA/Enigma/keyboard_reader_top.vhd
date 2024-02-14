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
			o_kbd_data  : out STD_LOGIC;
			o_kbd_clk   : out STD_LOGIC;
			seg			: out STD_LOGIC_VECTOR(7 downto 0);
			an				: out STD_LOGIC_VECTOR(3 downto 0);
			ascii       : out STD_LOGIC_VECTOR(7 downto 0);
			new_data    : out STD_LOGIC;
			read_data   : in STD_LOGIC := '0'
	);
end keyboard_reader_top;

architecture Behavioral of keyboard_reader_top is
		COMPONENT keyboard_reader
		PORT(
			clk      : IN  std_logic;
			kbd_data : IN  std_logic;
			kbd_clk  : IN  std_logic;
			letters  : OUT std_logic_vector(23 downto 0);
			led_clk  : OUT std_logic;
			led_data : OUT std_logic;
			ascii    : out std_logic_vector(7 downto 0);
			new_data : out std_logic;
			read_data : in std_logic
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
	 signal test1 : STD_LOGIC_VECTOR(3 downto 0) := "1010";
	 signal test2 : STD_LOGIC_VECTOR(0 to 3);
	 signal dupa  : STD_LOGIC_VECTOR(15 downto 0) := "0001001000110100";
begin
	kbd : keyboard_reader port map(
		clk => clk,
		kbd_data => kbd_data,
		kbd_clk  => kbd_clk,
		letters => scancodes,
		ascii    => ascii,
		new_data => new_data,
		read_data => read_data
	);
	
	ssg : seven_segment port map(
		segments => seg,
		digits   => an,
		clk      => clk_pre,
		hex_in   => scancodes(15 downto 0)
		--hex_in   => X"1234"
		--hex_in     => dupa
	);
	
	presc : sevenseg_prescaler port map(
		clk => clk,
		clk_pre => clk_pre
	);
	
	test2 <= test1;
	o_kbd_data <= kbd_data;
	o_kbd_clk  <= kbd_clk;
	
end Behavioral;

