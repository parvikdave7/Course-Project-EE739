----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2022 15:12:03
-- Design Name: 
-- Module Name: main - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
  Port ( 
        clk, reset: IN STD_LOGIC;
        res : OUT STD_LOGIC_VECTOR(15 downto 0));
end main;

architecture Behavioral of main is

component reg_gen is
  Port (clk, ena, clr: in std_logic;
		Din: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(15 downto 0));
end component;

component ROM_SIM is
generic (K: integer:=8; -- number of bits per word
			A: integer:=8); -- number of address bits; N = 2^A(Address length)
port(
 address: in std_logic_vector(A-1 downto 0); 
 rom_enable: in std_logic; 
 clock: in std_logic; 
 data_out: out std_logic_vector(K-1 downto 0)
);
end component;
	
component decoder is
		port(
			instr: in std_logic_vector(15 downto 0);
			ID_PC, LS_PC, LLI: out std_logic; 
			LM, SM, LW, SE_DO2, BEQ: out std_logic;
			WB_mux, AR1, AR2, AR3, valid, Flag_C: out std_logic_vector(2 downto 0);
			ALU_C, Cond, WR: out std_logic_vector(1 downto 0));
end component;

signal PC_EN : STD_LOGIC;
signal staller_enable : STD_LOGIC;

signal PC_INP : STD_LOGIC_VECTOR(15 downto 0);
signal PC_OP : STD_LOGIC_VECTOR(15 downto 0);
signal PC_inc : STD_LOGIC_VECTOR(15 downto 0);
signal instruction : STD_LOGIC_VECTOR(15 downto 0);

begin
-------------------------------------------
-- Stage 1: Instruction Fetch
-------------------------------------------

PC: reg_gen port map(clk => clk, clr => reset, ena => PC_EN, Din => PC_INP, Dout => PC_OP);

PC_EN <= not(staller_enable);
--Check this again after LM_SM	
PC_inc <= std_logic_vector(unsigned(PC_OP) + to_unsigned(1,16));	

IF_STAGE: ROM_sim
	port map(address => PC_OP, data_out => instruction, rom_enable => '1', clock => clk);
	
--- Need to look at branch LUT
-- BEQ_PC <= PCpp when (is_taken = '0') else BA;



end Behavioral;
