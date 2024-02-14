----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:55:21 02/06/2024 
-- Design Name: 
-- Module Name:    uart_top - Behavioral 
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

entity uart_top is
	port (
		tx  : out STD_LOGIC;
		tx_copy  : out STD_LOGIC;
		tx_busy  : out STD_LOGIC;
		tx_busy2 : out STD_LOGIC;
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		start : in STD_LOGIC;
		data : in STD_LOGIC_VECTOR(7 downto 0)
	);
end uart_top;

architecture Behavioral of uart_top is
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
	
	component Debouncer is 
		 port(
		 CLK : in STD_LOGIC;	   -- clk 100...300Hz
		 CEI : in STD_LOGIC;	   -- clock enable input
		 PUSH : in STD_LOGIC;	   -- pushbutton entry
		 CLR : in STD_LOGIC;	   -- clear
		 PE : out STD_LOGIC        -- debounced output	
	 );
	 end component;
	 
	component Prescaler is
	 	generic(
			divide_factor : integer := 10_000_000
		);
		port(
			CLK : in STD_LOGIC;
			CE : in STD_LOGIC;
			CLR : in STD_LOGIC;
			CEO : out STD_LOGIC
		);	   
	end component;
	
	signal tx_int : STD_LOGIC;
	signal busy_int : STD_LOGIC;
	signal start_dbc : STD_LOGIC;
	signal ce_pd : STD_LOGIC;
begin
	transmitter : uart_tx generic map (
		clk_freq   => 100_000_000,
		baudrate   => 9600,
		parity_en  => false,
		data_width => 8
	)
	port map( 
		tx => tx_int,
		tx_data => data,
		tx_busy => busy_int,
		clk => clk,
		rst => rst,
		tx_start => start_dbc
	);
	
	presc : Prescaler 
	generic map (
		divide_factor => 10_000
	)
	port map(
		clk => clk,
		ce  => '1',
		clr => rst,
		ceo => ce_pd
	);
	
	dbc : debouncer port map(
		clk => clk,
		cei => ce_pd,
		push => start,
		clr => rst,
		pe => start_dbc
	);
	
	tx_copy <= tx_int;
	tx      <= tx_int;
	
	tx_busy  <= busy_int;
	tx_busy2 <= busy_int;
end Behavioral;

