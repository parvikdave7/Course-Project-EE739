library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package intermediate_reg is 
    component reg_gen is
        generic ( data_width : integer);
        port(
            clk, ena, clr: in std_logic;
            Din: in std_logic_vector(data_width-1 downto 0);
            Dout: out std_logic_vector(data_width-1 downto 0));
    end component;
    component IF_ID is 
    port(clk: in std_logic;
        clear: in std_logic;
        pc_in: in std_logic_vector(15 downto 0);
        inst_in: in std_logic_vector(15 downto 0);
        pc_inc_in: in std_logic_vector(15 downto 0);
        disable : in std_logic;
        pc_out: out std_logic_vector(15 downto 0);
        inst_out: out std_logic_vector(15 downto 0);
        pc_inc_out:out std_logic_vector(15 downto 0));
        --TO DO: BLUT 
    end component;

    component ID_RR is 
        port(clk: in std_logic;
            clear: in std_logic;
            pc_in: in std_logic_vector(15 downto 0);
            inst_in: in std_logic_vector(15 downto 0);
            pc_inc_in: in std_logic_vector(15 downto 0);
            ar1_in: in std_logic_vector(2 downto 0);
            ar2_in: in std_logic_vector(2 downto 0);
            ar3_in: in std_logic_vector(2 downto 0);
            lm_sm_in : std_logic_vector(7 downto 0);
            opcode_in: in std_logic_vector(3 downto 0);
            immediate_in: in std_logic_vector(15 downto 0);
            cl_sig_in : in std_logic_vector(12 downto 0);
            disable : in std_logic;
            
            pc_out: out std_logic_vector(15 downto 0);
            inst_out: out std_logic_vector(15 downto 0);
            pc_inc_out: out std_logic_vector(15 downto 0);
            ar1_out: out std_logic_vector(2 downto 0);
            ar2_out: out std_logic_vector(2 downto 0);
            ar3_out: out std_logic_vector(2 downto 0);
			inst_out: out std_logic_vector(15 downto 0);
            lm_sm_out : out std_logic_vector(7 downto 0);
            opcode_out: out std_logic_vector(3 downto 0);
            immediate_out: out std_logic_vector(15 downto 0);
            cl_sig_out : out std_logic_vector(12 downto 0));
            
        --TO DO: BLUT 
    end component;

    component RR_EX is 
        port(clk: in std_logic;
            clear: in std_logic;
            pc_in: in std_logic_vector(15 downto 0);
            pc_inc_in: in std_logic_vector(15 downto 0);
            ar1_in: in std_logic_vector(2 downto 0);
            ar3_in: in std_logic_vector(2 downto 0);
            lm_sm_in : std_logic_vector(7 downto 0);
            opcode_in: in std_logic_vector(3 downto 0);
            immediate_in: in std_logic_vector(15 downto 0);
            cl_sig_in : in std_logic_vector(12 downto 0);
            do1_in: in std_logic_vector(15 downto 0);
			do2_in: in std_logic_vector(15 downto 0);
            LM_SM_en : in std_logic;
            disable : in std_logic;
            
            pc_out: out std_logic_vector(15 downto 0);
            pc_inc_out: out std_logic_vector(15 downto 0);
            ar1_out: out std_logic_vector(2 downto 0);
            ar3_out: out std_logic_vector(2 downto 0);
            inst_out: out std_logic_vector(15 downto 0);
            lm_sm_out : out std_logic_vector(7 downto 0);
            opcode_out: out std_logic_vector(3 downto 0);
            immediate_out: out std_logic_vector(15 downto 0);
            cl_sig_out : out std_logic_vector(12 downto 0);
            do1_out: out std_logic_vector(15 downto 0);
			do2_out: out std_logic_vector(15 downto 0));
    end component;

    component EX_MA is 
        port(clk: in std_logic;
            clear: in std_logic;
            pc_inc_in: in std_logic_vector(15 downto 0);
            ar1_in: in std_logic_vector(2 downto 0);
            ar3_in: in std_logic_vector(2 downto 0);
            opcode_in: in std_logic_vector(3 downto 0);
            immediate_in: in std_logic_vector(15 downto 0);
            cl_sig_in : in std_logic_vector(12 downto 0);
            do1_in: in std_logic_vector(15 downto 0);
            do2_in: in std_logic_vector(15 downto 0);
            alu_out_in: in std_logic_vector(15 downto 0);
            disable : in std_logic;
            
            pc_inc_out: out std_logic_vector(15 downto 0);
            pc_out: out std_logic_vector(15 downto 0);
            ar1_out: out std_logic_vector(2 downto 0);
            ar3_out: out std_logic_vector(2 downto 0);
            opcode_out: out std_logic_vector(3 downto 0);
            immediate_out: out std_logic_vector(15 downto 0);
            cl_sig_out : out std_logic_vector(12 downto 0);
            do1_out: out std_logic_vector(15 downto 0);
            do2_out: out std_logic_vector(15 downto 0);
            alu_out_out: out std_logic_vector(15 downto 0));
            
    end component;
    
    component MA_WB is
        port(clk: in std_logic;
            clear: in std_logic;
            pc_inc_in: in std_logic_vector(15 downto 0);
            ar1_in: in std_logic_vector(2 downto 0);
            ar3_in: in std_logic_vector(2 downto 0);
            opcode_in: in std_logic_vector(3 downto 0);
            immediate_in: in std_logic_vector(15 downto 0);
            cl_sig_in : in std_logic_vector(12 downto 0);
            do1_in: in std_logic_vector(15 downto 0);
            do2_in: in std_logic_vector(15 downto 0);
            mem_data_in: in std_logic_vector(15 downto 0);
            alu_out_in: in std_logic_vector(15 downto 0);
            disable : in std_logic;
            
            pc_inc_out: out std_logic_vector(15 downto 0);
            pc_out: out std_logic_vector(15 downto 0);
            ar1_out: out std_logic_vector(2 downto 0);
            ar3_out: out std_logic_vector(2 downto 0);
            opcode_out: out std_logic_vector(3 downto 0);
            immediate_out: out std_logic_vector(15 downto 0);
            cl_sig_out : out std_logic_vector(12 downto 0);
            do1_out: out std_logic_vector(15 downto 0);
            do2_out: out std_logic_vector(15 downto 0);
            alu_out_out: out std_logic_vector(15 downto 0);
            mem_data_out: out std_logic_vector(15 downto 0));

    end component;
end package;

entity IF_ID is
    port(clk: in std_logic;
	clear: in std_logic;pc_in: in std_logic_vector(15 downto 0);
    inst_in: in std_logic_vector(15 downto 0);
    pc_inc_in: in std_logic_vector(15 downto 0);
    disable : in std_logic;
    pc_out: out std_logic_vector(15 downto 0);
    inst_out: out std_logic_vector(15 downto 0);
    pc_inc_out:out std_logic_vector(15 downto 0));
end entity;

architecture Behavioural_IFID of IF_ID is
    signal ena : std_logic := '1';
    begin
        ena <= not disable;
        pc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_in, Dout => pc_out, clr => clear);

        inst_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => inst_in, Dout => inst_out, clr => clear);

        pc_inc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_inc_in, Dout => pc_inc_out, clr => clear);

end architecture;

entity ID_RR is
    port(clk: in std_logic;
        clear: in std_logic;
        pc_in: in std_logic_vector(15 downto 0);
        inst_in: in std_logic_vector(15 downto 0);
        pc_inc_in: in std_logic_vector(15 downto 0);
        ar1_in: in std_logic_vector(2 downto 0);
        ar2_in: in std_logic_vector(2 downto 0);
        ar3_in: in std_logic_vector(2 downto 0);
        lm_sm_in : std_logic_vector(7 downto 0);
        op_in: in std_logic_vector(3 downto 0);
        immediate_in: in std_logic_vector(15 downto 0);
        cl_sig_in : in std_logic_vector(12 downto 0);
        disable : in std_logic;
        
        pc_out: out std_logic_vector(15 downto 0);
        inst_out: out std_logic_vector(15 downto 0);
        pc_inc_out: out std_logic_vector(15 downto 0);
        ar1_out: out std_logic_vector(2 downto 0);
        ar2_out: out std_logic_vector(2 downto 0);
        ar3_out: out std_logic_vector(2 downto 0);
        inst_out: out std_logic_vector(15 downto 0);
        lm_out : out std_logic_vector(7 downto 0);
        opcode_out: out std_logic_vector(3 downto 0);
        immediate_out: out std_logic_vector(15 downto 0);
        cl_sig_out : out std_logic_vector(12 downto 0));
            
end entity;

architecture Behavioural_IDRR of ID_RR is
    signal ena : std_logic := '1';
    begin
        ena <= not disable;

        pc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_in, Dout => pc_out, clr => clear);

        inst_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => inst_in, Dout => inst_out, clr => clear);

        pc_inc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_inc_in, Dout => pc_inc_out, clr => clear);
         
        ar1: reg_gen
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar1_in, Dout => ar1_out, clr => clear); 
        
        ar2: reg_gen 
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar2_in, Dout => ar2_out, clr => clear);  
                    
        ar3: reg_gen 
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar3_in, Dout => AR3_out, clr => clear);  

        lm_sm_reg: reg_gen 
        generic map(8)
        port map(clk => clk, ena => ena, Din => lm_sm_in, Dout => lm_sm_out, clr => clear);
                
        opcode_reg: reg_gen 
        generic map(4)
        port map(clk => clk, ena => ena, clr => clear, Din => opcode_in, Dout => opcode_out);

        cl_sig_reg: reg_gen
        generic map(13)
        port map(clk => clk, ena => ena, clr => clear, Din => cl_sig_in, Dout => cl_sig_out);

        immediate_reg: reg_gen
        generic map(16)
        port map(clk=> clk, ena => ena, clr => clear, Din => immediate_in, Dout => immediate_out);

end Behavioural_IDRR ; -- Behavioural_IDRR

entity RR_EX is
    port(clk: in std_logic;
        clear: in std_logic;
        pc_in: in std_logic_vector(15 downto 0);
        pc_inc_in: in std_logic_vector(15 downto 0);
        ar1_in: in std_logic_vector(2 downto 0);
        ar3_in: in std_logic_vector(2 downto 0);
        lm_sm_in : std_logic_vector(7 downto 0);
        opcode_in: in std_logic_vector(3 downto 0);
        immediate_in: in std_logic_vector(15 downto 0);
        cl_sig_in : in std_logic_vector(12 downto 0);
        do1_in: in std_logic_vector(15 downto 0);
        do2_in: in std_logic_vector(15 downto 0);
        lm_sm_en : in std_logic;
        disable : in std_logic;
        
        pc_out: out std_logic_vector(15 downto 0);
        pc_inc_out: out std_logic_vector(15 downto 0);
        ar1_out: out std_logic_vector(2 downto 0);
        ar3_out: out std_logic_vector(2 downto 0);
        inst_out: out std_logic_vector(15 downto 0);
        lm_sm_out : out std_logic_vector(7 downto 0);
        opcode_out: out std_logic_vector(3 downto 0);
        immediate_out: out std_logic_vector(15 downto 0);
        cl_sig_out : out std_logic_vector(12 downto 0);
        do1_out: out std_logic_vector(15 downto 0);
        do2_out: out std_logic_vector(15 downto 0));
end entity;

architecture Behavioural_RREX of RR_EX is

    signal ena : std_logic := '1';
    begin
        ena <= not disable;
        lm_sm_en <= (ena or lm_sm_en);

        pc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_in, Dout => pc_out, clr => clear);

        pc_inc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_inc_in, Dout => pc_inc_out, clr => clear);
         
        ar1: reg_gen
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar1_in, Dout => ar1_out, clr => clear); 
        
        ar3: reg_gen 
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar3_in, Dout => AR3_out, clr => clear);  

        lm_sm_reg: reg_gen 
        generic map(8)
        port map(clk => clk, ena => ena, Din => lm_sm_in, Dout => lm_sm_out, clr => clear);
                
        opcode_reg: reg_gen 
        generic map(4)
        port map(clk => clk, ena => ena, clr => clear, Din => opcode_in, Dout => opcode_out);

        cl_sig_reg: reg_gen
        generic map(13)
        port map(clk => clk, ena => ena, clr => clear, Din => cl_sig_in, Dout => cl_sig_out);

        immediate_reg: reg_gen
        generic map(16)
        port map(clk=> clk, ena => ena, clr => clear, Din => immediate_in, Dout => immediate_out);

        do1_reg: reg_gen
		generic map(16)
		port map(clk => clk, ena => lm_sm_en, Din => do1_in, Dout => do1_out, clr => clear); 
	
        do2_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => lm_sm_en, Din => do2_in, Dout => do2_out, clr => clear); 

end Behavioural_RREX ; -- Behavioural_RREX

entity EX_MA is
    port(clk: in std_logic;
            clear: in std_logic;
            pc_inc_in: in std_logic_vector(15 downto 0);
            ar1_in: in std_logic_vector(2 downto 0);
            ar3_in: in std_logic_vector(2 downto 0);
            opcode_in: in std_logic_vector(3 downto 0);
            immediate_in: in std_logic_vector(15 downto 0);
            cl_sig_in : in std_logic_vector(12 downto 0);
            do1_in: in std_logic_vector(15 downto 0);
            do2_in: in std_logic_vector(15 downto 0);
            alu_out_in: in std_logic_vector(15 downto 0);
            disable : in std_logic;
            
            pc_inc_out: out std_logic_vector(15 downto 0);
            pc_out: out std_logic_vector(15 downto 0);
            ar1_out: out std_logic_vector(2 downto 0);
            ar3_out: out std_logic_vector(2 downto 0);
            opcode_out: out std_logic_vector(3 downto 0);
            immediate_out: out std_logic_vector(15 downto 0);
            cl_sig_out : out std_logic_vector(12 downto 0);
            do1_out: out std_logic_vector(15 downto 0);
            do2_out: out std_logic_vector(15 downto 0);
            alu_out_out: out std_logic_vector(15 downto 0));
end entity;

architecture Behavioural_EXMA of EX_MA is

    signal ena : std_logic := '1';
    begin
        ena <= not disable;

        pc_inc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_inc_in, Dout => pc_inc_out, clr => clear);
         
        ar1: reg_gen
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar1_in, Dout => ar1_out, clr => clear); 
        
        ar3: reg_gen 
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar3_in, Dout => AR3_out, clr => clear);  
                
        opcode_reg: reg_gen 
        generic map(4)
        port map(clk => clk, ena => ena, clr => clear, Din => opcode_in, Dout => opcode_out);

        cl_sig_reg: reg_gen
        generic map(13)
        port map(clk => clk, ena => ena, clr => clear, Din => cl_sig_in, Dout => cl_sig_out);

        immediate_reg: reg_gen
        generic map(16)
        port map(clk=> clk, ena => ena, clr => clear, Din => immediate_in, Dout => immediate_out);

        do1_reg: reg_gen
		generic map(16)
		port map(clk => clk, ena => lm_sm_en, Din => do1_in, Dout => do1_out, clr => clear); 
	
        do2_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => lm_sm_en, Din => do2_in, Dout => do2_out, clr => clear); 

        alu_out_reg: reg_gen
		generic map(16)
		port map(clk => clk, ena => ena, Din => alu_out_in, Dout => alu_out_out, clr => clear);

end Behavioural_EXMA ; -- Behavioural_EXMA

entity MA_WB is
    port(clk: in std_logic;
        clear: in std_logic;
        pc_inc_in: in std_logic_vector(15 downto 0);
        ar1_in: in std_logic_vector(2 downto 0);
        ar3_in: in std_logic_vector(2 downto 0);
        opcode_in: in std_logic_vector(3 downto 0);
        immediate_in: in std_logic_vector(15 downto 0);
        cl_sig_in : in std_logic_vector(12 downto 0);
        do1_in: in std_logic_vector(15 downto 0);
        do2_in: in std_logic_vector(15 downto 0);
        mem_data_in: in std_logic_vector(15 downto 0);
        alu_out_in: in std_logic_vector(15 downto 0);
        disable : in std_logic;
        
        pc_inc_out: out std_logic_vector(15 downto 0);
        pc_out: out std_logic_vector(15 downto 0);
        ar1_out: out std_logic_vector(2 downto 0);
        ar3_out: out std_logic_vector(2 downto 0);
        opcode_out: out std_logic_vector(3 downto 0);
        immediate_out: out std_logic_vector(15 downto 0);
        cl_sig_out : out std_logic_vector(12 downto 0);
        do1_out: out std_logic_vector(15 downto 0);
        do2_out: out std_logic_vector(15 downto 0);
        alu_out_out: out std_logic_vector(15 downto 0);
        mem_data_out: out std_logic_vector(15 downto 0));
end entity;

architecture Behavioural_EXMA of EX_MA is

    signal ena : std_logic := '1';
    begin
        ena <= not disable;

        pc_inc_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => ena, Din => pc_inc_in, Dout => pc_inc_out, clr => clear);
         
        ar1: reg_gen
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar1_in, Dout => ar1_out, clr => clear); 
        
        ar3: reg_gen 
        generic map(3)
        port map(clk => clk, ena => ena, Din => ar3_in, Dout => AR3_out, clr => clear);  
                
        opcode_reg: reg_gen 
        generic map(4)
        port map(clk => clk, ena => ena, clr => clear, Din => opcode_in, Dout => opcode_out);

        cl_sig_reg: reg_gen
        generic map(13)
        port map(clk => clk, ena => ena, clr => clear, Din => cl_sig_in, Dout => cl_sig_out);

        immediate_reg: reg_gen
        generic map(16)
        port map(clk=> clk, ena => ena, clr => clear, Din => immediate_in, Dout => immediate_out);

        do1_reg: reg_gen
		generic map(16)
		port map(clk => clk, ena => lm_sm_en, Din => do1_in, Dout => do1_out, clr => clear); 
	
        do2_reg: reg_gen
        generic map(16)
        port map(clk => clk, ena => lm_sm_en, Din => do2_in, Dout => do2_out, clr => clear); 

        alu_out_reg: reg_gen
		generic map(16)
		port map(clk => clk, ena => ena, Din => alu_out_in, Dout => alu_out_out, clr => clear);

        mem_data_reg: reg_gen
        generic map(16)
		port map(clk => clk, ena => ena, Din => mem_data_in, Dout => mem_data_out, clr => clear);

end Behavioural_EXMA ; -- Behavioural_EXMA

