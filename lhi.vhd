----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 16:18:33
-- Design Name: 
-- Module Name: lhi - Behavioral
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

entity lhi is
    Port ( --AR1 : in STD_LOGIC_VECTOR (2 downto 0);
           inp : in STD_LOGIC_VECTOR (8 downto 0);
           D_out : out STD_LOGIC_VECTOR (15 downto 0));
      --     a_out : out STD_LOGIC_VECTOR(2 downto 0));
end lhi;

architecture Behavioral of lhi is



begin
    -- a_out <= AR1;     -- Register address given as output, will go to the reg_file as input later
    D_out(15 downto 7) <= inp;
    D_out(6 downto 0) <= "0000000"; 
    
end Behavioral;
