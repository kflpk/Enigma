-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY uart_tb IS
END uart_tb;

ARCHITECTURE behavior OF uart_tb IS 

  -- Component Declaration
	COMPONENT uart_tx
	Generic (
	        clk_freq   : integer := 10_000_000;
           baudrate   : integer := 9600;
			  parity_en  : boolean := true;
			  parity_eo  : integer := 1; 
			  data_width : integer := 8
	);    
	Port ( 
			  tx       : out STD_LOGIC;
			  tx_busy  : out STD_LOGIC;
			  tx_data  : in  STD_LOGIC_VECTOR ((data_width - 1) downto 0);
           clk      : in  STD_LOGIC;
			  rst      : in  STD_LOGIC;
			  tx_start : in  STD_LOGIC
	);
	END COMPONENT;
          
	signal tx : std_logic;
	signal tx_busy : std_logic;
	signal tx_data : std_logic_vector(7 downto 0) := "00000000";
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal tx_start : std_logic := '0';
	constant clk_period : time := 10ns;
 BEGIN

  -- Component Instantiation
	uut: uart_tx 
	Generic map(
		clk_freq => 10000000,
		baudrate => 9600,
		parity_en => false,
		parity_eo => 0,
		data_width => 8
	)
	PORT MAP(
		tx => tx,
		tx_busy => tx_busy,
		tx_data => tx_data,
		clk => clk,
		rst => rst,
		tx_start => tx_start
   );

	clk_process : process
	begin 
		if clk = '1' then
			clk <= '0';
		elsif clk = '0' then
			clk <= '1';
		end if;
		
		wait for clk_period/2;
	end process;
	
	tb : PROCESS
   BEGIN

		wait for 100 ns; 
		
		tx_data <= "10101001";
		
		tx_start <= '1';
		
		wait for clk_period;
		
		tx_start <= '0';

		wait; -- will wait forever
   END PROCESS;

 END;
