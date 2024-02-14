----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:12:07 02/14/2024 
-- Design Name: 
-- Module Name:    Enigma_top - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;



entity Enigma_top is
	Port(
		seg      : out STD_LOGIC_VECTOR(7 downto 0);
		an       : out STD_LOGIC_VECTOR(3 downto 0);
		tx       : out STD_LOGIC;
		kbd_clk  : in  STD_LOGIC;
		kbd_data : in  STD_LOGIC;
		clk      : in  STD_LOGIC;
		rst      : in  STD_LOGIC
	);
end Enigma_top;

architecture Behavioral of Enigma_top is
	component uart_tx is
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
	end component;
	
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
	
	signal tx_int : STD_LOGIC;
	signal tx_start : STD_LOGIC;
	signal busy_int : STD_LOGIC;
	signal ascii_int : STD_LOGIC_VECTOR(7 downto 0);
	signal ascii : STD_LOGIC_VECTOR(7 downto 0);
	signal prev_new_data : STD_LOGIC;
	signal new_data : STD_LOGIC;
	signal read_data : STD_LOGIC;
	signal scancodes : STD_LOGIC_VECTOR(23 downto 0);
	signal clk_pre : STD_LOGIC;
begin
	transmitter : uart_tx generic map (
		clk_freq   => 100_000_000,
		baudrate   => 9600,
		parity_en  => false,
		data_width => 8
	)
	port map( 
		tx => tx_int,
		tx_data => ascii_int,
		tx_busy => busy_int,
		clk => clk,
		rst => rst,
		tx_start => tx_start
	);
	
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
	);
	
	presc : sevenseg_prescaler port map(
		clk => clk,
		clk_pre => clk_pre
	);
	
	process(clk)
	begin
		if rising_edge(clk) then
			if prev_new_data = '0' and new_data = '1' then
				tx_start <= '1';
				ascii_int <= ascii;
				read_data <= '1';
			else
				tx_start <= '0';
				read_data <= '0';
			end if;
			prev_new_data <= new_data;
		end if;
	end process;
	
	tx <= tx_int;
	
end Behavioral;

