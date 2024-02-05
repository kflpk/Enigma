----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:35:25 03/27/2016 
-- Design Name: 
-- Module Name:    kb_read_main - Behavioral 
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

entity kb_main is
port (
      clk, reset: in  std_logic;
      ps2d, ps2c: in  std_logic;  -- key data, key clock
      rx_en: in std_logic;
	  up, down, left, right, alt_gr, ctrl : OUT STD_LOGIC;
	  read_en  :out STD_LOGIC;
	  scode    : out STD_LOGIC_VECTOR(7 downto 0)
		);
end kb_main;

architecture Behavioral of kb_main is

  
  SIGNAL scancode  : STD_LOGIC_VECTOR(7 downto 0);
  SIGNAL scan_rdy : STD_LOGIC;

COMPONENT kb_read
	PORT(
		clk : IN std_logic;
		scancode : IN std_logic_vector(7 downto 0);
		reset : IN std_logic;
		scan_rdy : IN std_logic;          
		up : OUT std_logic;
		down : OUT std_logic;
		left : OUT std_logic;
		right : OUT std_logic;
		alt_gr : OUT STD_LOGIC;
        ctrl : OUT STD_LOGIC;
		read_en : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT ps2_rx
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		ps2d : IN std_logic;
		ps2c : IN std_logic;
		rx_en : IN std_logic;          
		rx_done_tick : OUT std_logic;
		dout : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	

begin

	Inst_kb_read: kb_read PORT MAP(
		clk =>clk ,
		scancode =>scancode,
		reset => reset,
		scan_rdy => scan_rdy,
		up => up,
		down => down,
		left => left,
		right =>right,
		alt_gr => alt_gr,
        ctrl => ctrl,
		read_en => read_en
	);

Inst_ps2_rx: ps2_rx PORT MAP(
		clk => clk,
		reset =>reset,
		ps2d => ps2d,
		ps2c => ps2c,
		rx_en => rx_en,
		rx_done_tick => scan_rdy,
		dout => scancode
	);
	
	scode <= scancode;
end Behavioral;


