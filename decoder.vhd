----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2022 16:08:53
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
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
end decoder;

architecture Behavioral of decoder is

signal ra, rb, rc : STD_LOGIC_VECTOR(2 downto 0);
signal imm6 : STD_LOGIC_VECTOR(5 downto 0) := instr(5 downto 0);
signal imm9 : STD_LOGIC_VECTOR(8 downto 0) := instr(8 downto 0);
signal z7 : STD_LOGIC_VECTOR(6 downto 0) := "0000000";
signal sgn_ext_6 : STD_LOGIC_VECTOR(15 downto 0);
signal sgn_ext_9 : STD_LOGIC_VECTOR(15 downto 0);
signal lhi_opr : STD_LOGIC_VECTOR(15 downto 0); 
begin
    sgn_ext_6 <= (15 downto 6 => imm6(5)) & imm6;
    sgn_ext_9 <= (15 downto 9 => imm9(8)) & imm9;
    lhi_opr(15 downto 7) <= imm9;
    lhi_opr(6 downto 0) <= z7;
    ra <= instr(11 downto 9);
    rb <= instr(8 downto 6);
    rc <= instr(5 downto 3);
    
    decoding_logic: process(instr, ra, rb, rc)
	begin
	    -- WB_mux : 00 - ALU Output, 01 - LHI, 10 - PC++, 11 - LM, LW
	    -- ALU_C : 10 - Add, 00 - NAND, 01 - Comparator
		-- Set the default values
		ID_PC <= '0';
		shift <= '0';
		BEQ <= '0';
		LM <= '0';
		SM <= '0';
		LW <= '0';
		WB_mux <= "00";
		ALU_C <= "10";
		valid <= "111";
		AR1 <= RA;
		AR2 <= RB;
		AR3 <= RC;
		WR_en <= "10";
		
		-- Conditional Settings
		case instr(15 downto 12) is
			when "0000" =>  		--Add immediate
	            operand <= sgn_ext_6;
				AR1 <= ra;
				AR2 <= "---";
				AR3 <= rb;
				valid <= "101";  		     
			
			when "0001" =>			--Add
			 case instr(1 downto 0) is
			     when "00" =>
			     when "01" =>       -- ADZ
			         valid <= ('1' and ZF, '1' and ZF, '1' and ZF);
			     when "10" =>       -- ADC
			         valid <= ('1' and CF, '1' and CF, '1' and CF);
			     when "11" =>       -- ADL
			         shift <= '1';
             end case;
			   
			when "0010" =>			--Nand
			   ALU_C <= "00";  
	           case instr(1 downto 0) is
			     when "00" =>
			     when "01" =>
    			     valid <= ('1' and ZF, '1' and ZF, '1' and ZF);
			     when "10" =>
			         valid <= ('1' and CF, '1' and CF, '1' and CF);
			     when others => 
             end case;
			when "0011" =>			--LHI
			operand <= lhi_opr;
			LS_PC <= '1';
			WB_mux <= "01";
			ALU_C <= "--";
			AR1 <= "---";
			AR2 <= "---";
			AR3 <= ra;
			valid <= "001";
					
			when "0100" =>			--LW
				AR3 <= ra;
				AR1 <= rb;
				LW <= '1';
				AR2 <= "---";
				operand <= sgn_ext_6;
				WB_mux <= "11";
				valid <= "101";
				
			when "0101" => 			--SW
			    operand <= sgn_ext_6;
				WB_mux <= "--";
				WR_en <= "01";
				AR1 <= rb;
				AR2 <= ra;
				AR3 <= "---";
				valid <= "110";
				
			when "1100" => 			--LM
				LM <= '1';
				WB_mux <= "11";
				AR2 <= "---";
				AR3 <= "---";
				valid <= "101";
				
			when "1101" =>			--SM
				SM <= '1';
				WB_mux <= "--";
				WR_en <= "01";
				AR2 <= "---";
				AR3 <= "---";
				valid <= "110";
				
			when "1000" =>			--BEQ
				LS_PC <= '0';
				BEQ <= '1';
				WB_mux <= "---";
				ALU_C <= "01";
				WR_en <= "00";
				AR3 <= "---";
				valid <= "110";
				
			when "1001" =>			--JAL
				ID_PC <= '1';
				LS_PC <= '0';
				WB_mux <= "10";
				ALU_C <= "--";
				WR_en <= "10";
				AR1 <= "---";
				AR2 <= "---";
				AR3 <= RA;
				valid <= "001";
				
			when "1010" =>			--JLR
				WB_mux <= "10";
				ALU_C <= "--";
				WR_en<= "10";
				AR1 <= RB;
				AR2 <= "---";
				AR3 <= RA;
				valid <= "101";
				
		    when "1110" =>          -- LA
		    when "1111" =>          -- SA
			when "1011" =>          -- JRI
			    operand <= sgn_ext_9;
			    ALU_C <= "10";
			    AR1 <= ra;
			    AR2 <= "---";
			    AR3 <= ra;
			    valid <= "101";
			when others =>
		end case;
	end process;




end Behavioral;
