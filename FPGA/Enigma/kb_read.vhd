----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:40:53 03/26/2016 
-- Design Name: 
-- Module Name:    kb_read - Behavioral 
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
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
use ieee.numeric_std.all;

ENTITY kb_read IS
 PORT(
 clk : IN STD_LOGIC;
 scancode : IN STD_LOGIC_VECTOR(7 downto 0);
 reset : IN STD_LOGIC;
 scan_rdy : IN STD_LOGIC;
 up : OUT STD_LOGIC;
 down : OUT STD_LOGIC;
 left: OUT STD_LOGIC;
 right : OUT STD_LOGIC;
 alt_gr : OUT STD_LOGIC;
 ctrl : OUT STD_LOGIC;
 read_en : OUT STD_LOGIC
 );
END kb_read ;

ARCHITECTURE a OF kb_read IS
 TYPE STATE_TYPE IS (idle, readcode);
 TYPE STATUS_TYPE IS (None, E0code, F0code);
 SIGNAL state : STATE_TYPE;
 SIGNAL status : STATUS_TYPE;
BEGIN

 PROCESS (clk,reset)
 BEGIN
 IF reset = '1' THEN
	state <= idle;
	status <= None; 
	up <= '0';
	down <= '0';
	left <= '0';
	right <= '0';
	alt_gr <= '0';
    ctrl <= '0';
 
 ELSIF (clk'EVENT AND clk='1') THEN
	CASE state IS
		WHEN idle =>
			read_en <= '0';
			IF (scan_rdy = '0') THEN
				state <= idle;
			ELSE
				if scan_rdy = '1' then
					state <= readcode;
				else
					state <= idle;
				end if;
			END IF;
 
		WHEN readcode =>
			read_en <= '1';
			state <= idle;
 
			 CASE scancode IS
				WHEN x"E0" =>
					if (status=None) THEN
						status <= E0code;
					ELSE
						status <= None;
					END IF;
			 
				WHEN x"F0" =>
					if (status=E0code) THEN
						status <= F0code;
					ELSE
						status <= None;
					END IF;
			 
				WHEN OTHERS =>
					if (status=E0code) THEN
						status <= None;
						CASE scancode IS
							WHEN x"74" => right <= '1';
							WHEN x"75" => up <= '1';
							WHEN x"72" => down <= '1';
							WHEN x"6B" => left <= '1';
							WHEN x"11" => alt_gr <= '1';
							WHEN x"14" => ctrl <= '1';
							
							WHEN OTHERS => status <= None;
						END CASE;
			 
					 ELSIF (status=F0code) THEN
						 status <= None;					 
						CASE scancode IS
							WHEN x"75" => up <= '0';
							WHEN x"74" => right <= '0';
							WHEN x"72" => down <= '0';
							WHEN x"6B" => left <= '0';
							WHEN x"11" => alt_gr <= '0';
                            WHEN x"14" => ctrl <= '0';
							
							WHEN OTHERS => status <= None;
						END CASE;
			 
					 ELSE
						status <= None;
					END IF;
			 END CASE;
 

		
		WHEN OTHERS =>
			state <= idle;
	END CASE;
 END IF;
 END PROCESS;
END a;