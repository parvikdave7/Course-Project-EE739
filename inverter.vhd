----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 23:30:53
-- Design Name: 
-- Module Name: inverter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inverter is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : out STD_LOGIC_VECTOR (15 downto 0));
end inverter;

architecture Behavioral of inverter is

begin
y(0) <= not(x(0));
y(1) <= not(x(1));
y(2) <= not(x(2));
y(3) <= not(x(3));
y(4) <= not(x(4));
y(5) <= not(x(5));
y(6) <= not(x(6));
y(7) <= not(x(7));
y(8) <= not(x(8));
y(9) <= not(x(9));
y(10) <= not(x(10));
y(11) <= not(x(11));
y(12) <= not(x(12));
y(13) <= not(x(13));
y(14) <= not(x(14));
y(15) <= not(x(15));

end Behavioral;
