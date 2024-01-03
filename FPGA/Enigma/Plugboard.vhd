----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:57 12/28/2023 
-- Design Name: 
-- Module Name:    Plugboard - Behavioral 
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

entity Plugboard is
    Port ( x1 : in  STD_LOGIC_VECTOR (4 downto 0);
           x2 : in  STD_LOGIC_VECTOR (4 downto 0);
           y : in  STD_LOGIC_VECTOR (4 downto 0);
           load : in  STD_LOGIC;
           data : in  STD_LOGIC;
           clk : in  STD_LOGIC);
end Plugboard;

architecture Behavioral of Plugboard is

begin


end Behavioral;

