-------------------------------------------------------------------------------
--
-- Title       : Debouncer
-- Design      : TutorVHDL
-- Author      : PJR & JK
-- Company     : AGH
--
-------------------------------------------------------------------------------
--
-- Description : Simple debounce circuit
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Debouncer} architecture {Debouncer}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;



entity Debouncer is
	 port(
		 CLK : in STD_LOGIC;	   -- clk 100...300Hz
		 CEI : in STD_LOGIC;	   -- clock enable input
		 PUSH : in STD_LOGIC;	   -- pushbutton entry
		 CLR : in STD_LOGIC;	   -- clear
		 PE : out STD_LOGIC        -- debounced output	
	 );
end Debouncer;

--}} End of automatically maintained section

architecture Debouncer of Debouncer is

signal DELAY : std_logic_vector(5 downto 0);		-- debounce register

begin
	process(CLK, CLR)
	begin
		if CLR = '1' then
			DELAY <= (others => '0');
		elsif CLK'event and CLK = '1' then
			if CEI = '1' then
				DELAY <= DELAY(4 downto 0) & PUSH;	-- shift register
			end if;
		end if;
	end process;
	
PE <= '1' when DELAY = "011111" and CEI = '1' else '0';
	
end Debouncer;
