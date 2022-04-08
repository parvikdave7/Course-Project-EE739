library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
entity ROM_sim is
generic (K: integer:=8; -- number of bits per word
			A: integer:=8); -- number of address bits; N = 2^A(Address length)
port(
 address: in std_logic_vector(A-1 downto 0); 
 rom_enable: in std_logic; 
 clock: in std_logic; 
 data_out: out std_logic_vector(K-1 downto 0)
);
end ROM_sim;
architecture Behavioral of ROM_sim is
type rom_array is array (0 to 2**A-1 ) of std_logic_vector (K-1 downto 0);
signal rom_data: rom_array:=(others =>(others=>'0')); 
begin
process(clock)
begin
 if(rising_edge(clock) and rom_enable='1') then
 data_out <= rom_data(to_integer(unsigned(address))) ;
 end if;
end process;
end Behavioral;