--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:25:12 01/09/2024
-- Design Name:   
-- Module Name:   /home/kacper/Programs/Enigma/FPGA/Enigma/keybard_reader_tb.vhd
-- Project Name:  Enigma
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keyboard_reader
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY keybard_reader_tb IS
END keybard_reader_tb;
 
ARCHITECTURE behavior OF keybard_reader_tb IS 
	 procedure SendLetter(	signal kbd_data : out STD_LOGIC;
									signal kbd_clk_stop : out STD_LOGIC;
									constant scode : in STD_LOGIC_VECTOR(8 downto 0);
									constant clk_period : time
								 )
	 is 
	 begin
		--Znak
		kbd_clk_stop <= '0';
		
		kbd_data <= '0';
		wait for clk_period;
	
		kbd_data <= scode(0);
		wait for clk_period;		
		kbd_data <= scode(1);
		wait for clk_period;
		kbd_data <= scode(2);
		wait for clk_period;
		kbd_data <= scode(3);
		wait for clk_period;
		kbd_data <= scode(4);
		wait for clk_period;
		kbd_data <= scode(5);
		wait for clk_period;
		kbd_data <= scode(6);
		wait for clk_period;
		kbd_data <= scode(7);
		wait for clk_period;
		kbd_data <= scode(8);
		wait for clk_period;
		
		kbd_data <= '1';
		
		kbd_clk_stop <= '1';
		wait for clk_period;
	 end procedure;
    
	 -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT keyboard_reader
    PORT(
         clk : IN  std_logic;
         kbd_data : IN  std_logic;
         kbd_clk  : IN  std_logic;
         letters  : OUT std_logic_vector(23 downto 0);
         led_clk  : OUT std_logic;
         led_data : OUT std_logic;
			ascii    : OUT std_logic_vector(7 downto 0);
			new_data    : out STD_LOGIC;
			read_data   : in STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal kbd_data : std_logic := '1';
   signal kbd_clk : std_logic := '1';
	signal read_data : std_logic := '0';

 	--Outputs
   signal letters : std_logic_vector(23 downto 0);
   signal led_clk : std_logic;
   signal led_data : std_logic;
	signal new_data : std_logic;
	
	signal ascii    : std_logic_vector(7 downto 0);
	
	-- scancodes
	signal sC       : std_logic_vector(8 downto 0) :=  "000100001";
	signal sG       : std_logic_vector(8 downto 0) :=  "000110100"; -- 0x34
	signal sL       : std_logic_vector(8 downto 0) :=  "001001011"; -- 0x4B
	signal F0       : std_logic_vector(8 downto 0) :=  "011110000";
	
	-- auxillary signals 
	signal kbd_clk_stop : STD_LOGIC := '1';

   -- Clock period definitions
   constant clk_period     : time := 10 ns;
   constant kbd_clk_period : time := 10 ns;
   constant led_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keyboard_reader PORT MAP (
          clk => clk,
          kbd_data => kbd_data,
          kbd_clk => kbd_clk,
          letters => letters,
          led_clk => led_clk,
          led_data => led_data,
			 ascii    => ascii,
			 new_data => new_data,
			 read_data => read_data
        );

   -- Clock process definitions
   clk_process : process
   begin
		clk <= '0';
		wait for clk_period/20;
		clk <= '1';
		wait for clk_period/20;
   end process;
 
   kbd_clk_process : process
   begin
	
		wait for 0.25*clk_period;
		
		if kbd_clk_stop = '0' then
			for i in 0 to 10 loop
				kbd_clk <= '0';
				wait for kbd_clk_period/2;
				kbd_clk <= '1';
				wait for kbd_clk_period/2;
			end loop;
--		else
--			for i in 0 to 10 loop
--				wait for kbd_clk_period;
--			end loop;
		end if;
		
   end process;
 
   led_clk_process : process
   begin
		led_clk <= '0';
		wait for led_clk_period/2;
		led_clk <= '1';
		wait for led_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc : process
   begin		
      -- hold reset state for 100 ns.
--      wait for 10*clk_period;
--		
--		-- Znak
--		
--		kbd_data <= '0';
--		wait for clk_period;
--	
--		kbd_data <= znak(0);
--		wait for clk_period;		
--		kbd_data <= znak(1);
--		wait for clk_period;
--		kbd_data <= znak(2);
--		wait for clk_period;
--		kbd_data <= znak(3);
--		wait for clk_period;
--		kbd_data <= znak(4);
--		wait for clk_period;
--		kbd_data <= znak(5);
--		wait for clk_period;
--		kbd_data <= znak(6);
--		wait for clk_period;
--		kbd_data <= znak(7);
--		wait for clk_period;
--		kbd_data <= znak(8);
--		wait for clk_period;
--		
--		kbd_data <= '1';
--		wait for clk_period;
--		
--		wait for 10*clk_period;
--		
--		-- F0
--		
--		kbd_data <= '0';
--		wait for clk_period;
--	
--		kbd_data <= F0(0);
--		wait for clk_period;		
--		kbd_data <= F0(1);
--		wait for clk_period;
--		kbd_data <= F0(2);
--		wait for clk_period;
--		kbd_data <= F0(3);
--		wait for clk_period;
--		kbd_data <= F0(4);
--		wait for clk_period;
--		kbd_data <= F0(5);
--		wait for clk_period;
--		kbd_data <= F0(6);
--		wait for clk_period;
--		kbd_data <= F0(7);
--		wait for clk_period;
--		kbd_data <= F0(8);
--		wait for clk_period;
--		
--		kbd_data <= '1';
--		wait for clk_period;
--		
--		wait for 2*clk_period;
--		kbd_data <= '1';
--		wait for 2*clk_period;
--		
--		-- znak
--		kbd_data <= '0';
--		wait for clk_period;
--	
--		kbd_data <= znak(0);
--		wait for clk_period;		
--		kbd_data <= znak(1);
--		wait for clk_period;
--		kbd_data <= znak(2);
--		wait for clk_period;
--		kbd_data <= znak(3);
--		wait for clk_period;
--		kbd_data <= znak(4);
--		wait for clk_period;
--		kbd_data <= znak(5);
--		wait for clk_period;
--		kbd_data <= znak(6);
--		wait for clk_period;
--		kbd_data <= znak(7);
--		wait for clk_period;
--		kbd_data <= znak(8);
--		wait for clk_period;
--		
--		kbd_data <= '1';
--		wait for clk_period;
--		
--		wait;
		wait for 100 ns;
		SendLetter(kbd_data, kbd_clk_stop, sC, kbd_clk_period); wait for 11*kbd_clk_period;
		SendLetter(kbd_data, kbd_clk_stop, f0, kbd_clk_period); wait for 11*kbd_clk_period;
		SendLetter(kbd_data, kbd_clk_stop, sC, kbd_clk_period); wait for 20*kbd_clk_period;
		
		SendLetter(kbd_data, kbd_clk_stop, sG, kbd_clk_period); wait for 11*kbd_clk_period;
		SendLetter(kbd_data, kbd_clk_stop, f0, kbd_clk_period); wait for 11*kbd_clk_period;
		SendLetter(kbd_data, kbd_clk_stop, sG, kbd_clk_period); wait for 20*kbd_clk_period;
		
		
		SendLetter(kbd_data, kbd_clk_stop, sL, kbd_clk_period); wait for 11*kbd_clk_period;
		SendLetter(kbd_data, kbd_clk_stop, f0, kbd_clk_period); wait for 11*kbd_clk_period;
		SendLetter(kbd_data, kbd_clk_stop, sL, kbd_clk_period); wait for 11*kbd_clk_period;
		
		wait;
   end process;
	
	read_data_proc : process
	begin
		wait for 660 ns; 
		read_data <= '1';
		wait for 10 ns;
		read_data <= '0';
		wait;
	end process;
END;
