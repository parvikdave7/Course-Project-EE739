----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 16:48:24
-- Design Name: 
-- Module Name: my_reg - Behavioral
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

entity reg_gen is
	generic ( data_width : integer);
	port(
		clk, ena, clr: in std_logic;
		Din: in std_logic_vector(data_width-1 downto 0);
		Dout: out std_logic_vector(data_width-1 downto 0));
end entity;

architecture Behavioral of reg_gen is
begin
	process(clk, clr)	
	begin
		if(rising_edge(clk)) then
			if (ena='1') then
				Dout <= Din;
			end if;
			if(clr = '1') then
				Dout <= (others => '0');
			end if;
		end if;
	end process;
	
end Behavioral;
