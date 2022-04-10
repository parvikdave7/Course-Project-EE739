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
library work;
use work.intermediate_reg.all;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;


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

component RAM_sim is
generic (K: integer:=8; -- number of bits per word
			A: integer:=8); -- number of address bits; N = 2^A
port(
 address: in std_logic_vector(A-1 downto 0); 
 data_in: in std_logic_vector(K-1 downto 0);
 write_in: in std_logic; 
 clock: in std_logic; 
 data_out: out std_logic_vector(K-1 downto 0)
);
end component;

component alu is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           R : inout STD_LOGIC_VECTOR (15 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           z : out STD_LOGIC;
           c : out STD_LOGIC);
end component;

component decoder is
  Port (
        instr: in std_logic_vector(15 downto 0);
		ID_PC, LS_PC: out std_logic; 
		LM, SM, LW, BEQ: out std_logic;
		AR1, AR2, AR3, valid: out std_logic_vector(2 downto 0);
		WB_mux, WR_en : out std_logic_vector(1 downto 0);
		ALU_C : out std_logic_vector(1 downto 0);
		CF : in std_logic;
		shift : out std_logic;
		ZF : in std_logic;
		operand : out std_logic_vector(15 downto 0)
  );
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
	
component register_file is
	generic(
		word_length: integer := 16;
		num_words: integer := 8);
		
	port(
		data_in, R7_in: in std_logic_vector(word_length-1 downto 0);
		data_out1, data_out2, R0: out std_logic_vector(word_length-1 downto 0);
		sel_in, sel_out1, sel_out2: in std_logic_vector(integer(ceil(log2(real(num_words))))-1 downto 0);
		clk, wr_ena, R7_ena, reset: in std_logic);
		
end component;

component branch_LUT is
		port(
			clk, reset, is_BEQ, toggle: in std_logic;
			new_PC_in, PC_in, BA_in: in std_logic_vector(15 downto 0);
			BA: out std_logic_vector(15 downto 0);
			is_taken: out std_logic;
			address_in: in std_logic_vector(2 downto 0);
			address_out: out std_logic_vector(2 downto 0));
end component;

signal PC_EN : STD_LOGIC;
signal staller_enable : STD_LOGIC;

signal PC_INP : STD_LOGIC_VECTOR(15 downto 0);
signal PC_OP : STD_LOGIC_VECTOR(15 downto 0);
signal PC_inc : STD_LOGIC_VECTOR(15 downto 0);
signal instruction : STD_LOGIC_VECTOR(15 downto 0);
signal is_BEQ : STD_LOGIC;
signal toggle : STD_LOGIC;
signal new_PC_in, PC_in, SE_PC_ID, BEQ_PC: STD_LOGIC_VECTOR(15 downto 0);
signal BA: STD_LOGIC_VECTOR(15 downto 0);
signal is_taken: STD_LOGIC;
signal BLUT_index_in: STD_LOGIC_VECTOR(2 downto 0);
signal BLUT_index_out: STD_LOGIC_VECTOR(2 downto 0);

signal disable_IF_ID : std_logic;
signal pc_inc_ID : STD_LOGIC_VECTOR(15 downto 0);
signal pc_ID : STD_LOGIC_VECTOR(15 downto 0);
signal instr_ID : STD_LOGIC_VECTOR(15 downto 0);
signal clear_control_IF_ID : STD_LOGIC;
signal disable_ID_RR : STD_LOGIC;
signal ID_PC : STD_LOGIC;
signal staller_disable : STD_LOGIC;
signal CL_ID : STD_LOGIC_VECTOR(11 downto 0);
signal AR1_ID: STD_LOGIC_VECTOR(2 downto 0);
signal AR2_ID: STD_LOGIC_VECTOR(2 downto 0);
signal AR3_ID: STD_LOGIC_VECTOR(2 downto 0);
signal ALU_C_ID: STD_LOGIC_VECTOR(1 downto 0);
signal shift_ID: STD_LOGIC;
signal imm_ID: STD_LOGIC_VECTOR(2 downto 0);
signal CF_ID : STD_LOGIC;
signal ZF_ID : STD_LOGIC;
signal lm_sm_ID : STD_LOGIC_VECTOR(7 downto 0);

signal pc_RR : STD_LOGIC_VECTOR(15 downto 0);
signal instr_RR : STD_LOGIC_VECTOR(15 downto 0);
signal pc_inc_RR : STD_LOGIC_VECTOR(15 downto 0);
signal AR1_RR: STD_LOGIC_VECTOR(2 downto 0);
signal AR2_RR: STD_LOGIC_VECTOR(2 downto 0);
signal AR3_RR: STD_LOGIC_VECTOR(2 downto 0);
signal lm_sm_RR : STD_LOGIC_VECTOR(7 downto 0);
signal imm_RR : STD_LOGIC_VECTOR(15 downto 0);
signal CL_RR : STD_LOGIC_VECTOR(15 downto 0);
signal clear_control_ID_RR : STD_LOGIC;
signal disable_RR_EX : STD_LOGIC;
signal disable_LM_SM : STD_LOGIC;

signal D3_data : STD_LOGIC_VECTOR(15 downto 0);
signal R7_in : STD_LOGIC_VECTOR(15 downto 0);
signal DO1_RF : STD_LOGIC_VECTOR(15 downto 0);
signal DO2_RF : STD_LOGIC_VECTOR(15 downto 0);
signal Disp : STD_LOGIC_VECTOR(15 downto 0);
signal AR3_WB : STD_LOGIC_VECTOR(2 downto 0);
signal AR2_RF : STD_LOGIC_VECTOR(2 downto 0);
signal R7_write : STD_LOGIC;
signal WR_WB : STD_LOGIC_VECTOR(1 downto 0);

begin
-------------------------------------------
-- Stage 1: Instruction Fetch
-------------------------------------------

PC: reg_gen port map(clk => clk, clr => reset, ena => PC_EN, Din => PC_INP, Dout => PC_OP);

PC_EN <= not(staller_enable);
--Check this again after LM_SM	
PC_inc <= std_logic_vector(unsigned(PC_OP) + to_unsigned(2,16));	

IF_STAGE: ROM_sim
	port map(address => PC_OP, data_out => instruction, rom_enable => '1', clock => clk);
	

BLUT: branch_LUT
		port map(
		clk => clk, reset => reset, is_BEQ => is_BEQ, toggle => toggle,
		new_PC_in => PC_INP, PC_in => PC_OP, BA_in => SE_PC_ID, is_taken => is_taken, 
		BA => BA, address_in => BLUT_index_in, address_out => BLUT_index_out);
		
	BEQ_PC <= PC_inc when (is_taken = '0') else BA;
	
--------------------------------------------------------------
--------------IF-ID piepline register
--------------------------------------------------------------	
	
pipe_IF_ID: IF_ID port map(clk => clk, clear => reset, pc_in => PC_OP, inst_in => instruction, 
pc_inc_in => PC_inc, disable => disable_IF_ID, pc_out => pc_ID, inst_out => instr_ID, pc_inc_out => pc_inc_ID);

clear_control_IF_ID <= ((not disable_ID_RR) and (ID_PC));	-- to clear IFID in case of JAL
disable_IF_ID	    <= staller_disable;

--------------------------------------------------------------
----- Stage 2: Instruction Decode
--------------------------------------------------------------	

decode_instr : decoder port map(instr => instr_ID, ID_PC => ID_PC, LS_PC => CL_ID(0), LM => CL_ID(1), 
SM => CL_ID(2), LW => CL_ID(3), BEQ => CL_ID(4), AR1 => AR1_ID, AR2 => AR2_ID, AR3 => AR3_ID, valid => CL_ID(7 downto 5), WB_mux => CL_ID(9 downto 8),
 WR_en => CL_ID(11 downto 10), ALU_C => ALU_C_ID, CF => CF_ID, ZF => ZF_ID, shift => shift_ID, operand => imm_ID);

--------------------------------------------------------------
--------------ID-RR piepline register
--------------------------------------------------------------	

pipe_ID_RR: ID_RR port map(clk => clk, clear => reset, pc_in => pc_ID, inst_in => instr_ID, pc_inc_in => pc_inc_ID,
ar1_in => AR1_ID, ar2_in => AR2_ID, ar3_in => AR3_ID, lm_sm_in => lm_sm_ID, opcode_in => instr_ID(15 downto 12), 
immediate_in => imm_ID, cl_sig_in => CL_ID, disable => disable_ID_RR, pc_out => pc_RR, inst_out => instr_RR, 
pc_inc_out => pc_inc_RR, ar1_out => AR1_RR, ar2_out => AR2_RR, ar3_out => AR3_RR, lm_sm_out => lm_sm_RR,
opcode_out => instr_RR(15 downto 12), immediate_out => imm_RR, cl_sig_out => CL_RR);

clear_control_ID_RR <= (not disable_RR_EX); 
disable_ID_RR	    <= disable_LM_SM;   

--------------------------------------------------------------
----- Stage 3: Register Read
--------------------------------------------------------------	

RegisterFile: register_file
		port map(data_in => D3_data, R7_in => R7_in, data_out1 => DO1_RF,
				 data_out2 => DO2_RF, R0 => Disp, sel_in => AR3_WB, sel_out1 => AR1_RR,
				 sel_out2 => AR2_RF, clk => clk, wr_ena => WR_WB(1), R7_ena => R7_write, 
				 reset => reset);
				 


end Behavioral;
