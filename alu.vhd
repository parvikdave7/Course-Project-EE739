----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 23:42:42
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           R : inout STD_LOGIC_VECTOR (15 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           z : out STD_LOGIC;
           c : out STD_LOGIC);
end alu;

architecture Behavioral of alu is
component KS_Adder is
port(
    x   : IN std_logic_vector (15 downto 0);
    y   : IN std_logic_vector (15 downto 0);
    cin : IN std_logic;
    sum : OUT std_logic_vector (15 downto 0);
    cout: OUT std_logic);

end component;

component nand_16bit is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           z : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component xor_16bit is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           z : out STD_LOGIC_VECTOR (15 downto 0));
end component;


signal t1,t2,t3,t4: STD_LOGIC_VECTOR(15 downto 0);
signal c1,c2: STD_LOGIC;
begin
signed_addition: KS_Adder port map(x => A, y => B, sum => t1, cin => '0', cout => c1);

nand16bit: nand_16bit port map(x => A, y => B, z => t3);
xor16bit: xor_16bit port map(x => A, y => B, z => t4);
process_ALU : process(A,B,sel) is
begin
    if(sel = "10") then
        R <= t1;
        c <= c1;
    elsif (sel = "00") then
        R <= t3;
    elsif (sel = "01") then
        R <= t4;
    else 
        R <= t1;
        c <= c1;
    end if;            
    if (R = "0000000000000000") then 
        z <= '1';
    else 
        z <= '0';
    end if;                    
end process;   
end Behavioral;
