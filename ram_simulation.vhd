library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
entity RAM_sim is
generic (K: integer:=8; -- number of bits per word
			A: integer:=8); -- number of address bits; N = 2^A
port(
 address: in std_logic_vector(A-1 downto 0); 
 data_in: in std_logic_vector(K-1 downto 0);
 write_in: in std_logic; 
 clock: in std_logic; 
 data_out: out std_logic_vector(K-1 downto 0)
);
end RAM_sim;
architecture Behavioral of RAM_sim is
type ram_array is array (0 to 2**A-1 ) of std_logic_vector (K-1 downto 0);
signal ram_data: ram_array:=(others =>(others=>'0')); 
begin
process(clock)
begin
 if(rising_edge(clock)) then
 if(write_in='1') then 
 ram_data(to_integer(unsigned(address))) <= data_in;
  end if;
 end if;
end process;
 data_out <= ram_data(to_integer(unsigned(address)));
end Behavioral;