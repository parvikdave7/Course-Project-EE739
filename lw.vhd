----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 14:32:12
-- Design Name: 
-- Module Name: lw - Behavioral
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

entity lw is
  Port (imm : IN STD_LOGIC_VECTOR(5 downto 0);
        data_rb : IN STD_LOGIC_VECTOR(15 downto 0); 
        mem_addr : OUT STD_LOGIC_VECTOR(15 downto 0);
        wr_en : OUT STD_LOGIC_VECTOR;
        rd_en : OUT STD_LOGIC_VECTOR
  );
end lw;

architecture Behavioral of lw is

component KS_Adder is 

port(
    x   : IN std_logic_vector (15 downto 0);
    y   : IN std_logic_vector (15 downto 0);
    cin : IN std_logic;
    sum : OUT std_logic_vector (15 downto 0);
    cout: OUT std_logic);

end component;

signal sgn_ext : STD_LOGIC_VECTOR(15 downto 0);

begin

sgn_ext <= (15 downto 6 => imm(5)) & imm;
addr_computation : KS_Adder port map(x => sgn_ext, y => data_rb, cin => '0', sum => mem_addr); 




end Behavioral;
