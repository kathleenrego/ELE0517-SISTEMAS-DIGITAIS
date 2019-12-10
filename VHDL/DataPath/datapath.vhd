library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
port(
		dp_clk: in std_logic;
		
		dp_ld_i0, dp_ld_i1: in std_logic;
		data_in_i0, data_in_i1: in std_logic_vector(7 downto 0);
		
		dp_ld_o0, dp_ld_o1: in std_logic;
		data_out_o0, data_out_o1: out std_logic_vector(7 downto 0);
		
		dp_addr_i0, dp_addr_o0, dp_addr_o1, dp_addr_pc: in std_logic_vector(1 downto 0);
		dp_addr_o2: in std_logic;
		
		dp_ld_r0, dp_ld_r1, dp_ld_r2, dp_ld_r3: in std_logic;
		dp_ld_o, dp_ld_c, dp_ld_s: in std_logic;
		dp_ld_pc, dp_rst_pc, dp_ld_rp, dp_ld_ri, dp_ld_eq, dp_ld_lt: in std_logic;
		
		dp_wr_md: in std_logic;
		
		dp_ula_code: in std_logic_vector(2 downto 0);
		
		dp_comp_eq, dp_comp_lt: out std_logic;
		dp_C, dp_O, dp_S: out std_logic;
		dp_RI: buffer std_logic_vector(15 downto 0);
		dp_RI_ext: buffer std_logic_vector(5 downto 0)
		
		-- Controle do PC
		--dp_out_pc: buffer std_logic_vector(9 downto 0)
		
		-- Instrução
		--mp_data_out: buffer std_logic_vector(15 downto 0);
		--dp_ula_in0, dp_ula_in1, dp_ula_out: buffer std_logic_vector(7 downto 0)
	);
end datapath;

architecture arc_datapath of datapath is

signal data_in_ro0, data_in_ro1, data_in_rx: std_logic_vector(7 downto 0); 
signal data_out_ri0, data_out_ri1: std_logic_vector(7 downto 0);
signal data_out_r0, data_out_r1, data_out_r2, data_out_r3: std_logic_vector(7 downto 0);

signal dp_mux_out_o1: std_logic_vector(7 downto 0);

signal md_data_out, dp_md_addres: std_logic_vector(7 downto 0);
signal mp_data_out: std_logic_vector(15 downto 0);

signal dp_out_inc, dp_out_add: std_logic_vector(9 downto 0);
signal dp_in_pc, dp_out_pc, dp_out_rp: std_logic_vector(9 downto 0);

signal dp_ula_in0, dp_ula_in1, dp_ula_out: std_logic_vector(7 downto 0);
signal dp_ula_c, dp_ula_o, dp_ula_s, ula_comp_eq, ula_comp_lt: std_logic;

component add_8 is
port(
		add_in0: in std_logic_vector (6 downto 0);
		add_in1: in std_logic_vector (7 downto 0);
		add_out: out std_logic_vector (7 downto 0)
	);
end component;

component add_10 is
port(
		add_in0: in std_logic_vector (6 downto 0);
		add_in1: in std_logic_vector (9 downto 0);
		add_out: out std_logic_vector (9 downto 0)
	);
end component;

component comp_8 is
	port(
		comp_in0, comp_in1: in std_logic_vector(7 downto 0);
		comp_eq, comp_lt: out std_logic
	);
end component;

component inc_10 is
port(
		inc_in: in std_logic_vector (9 downto 0);
		inc_out: out std_logic_vector (9 downto 0)
	);
end component;

component mux2x1_8 is
port(
		mux_in0, mux_in1: in std_logic_vector (7 downto 0);
		mux_sel: in std_logic;
		mux_out: out std_logic_vector (7 downto 0)
	);
end component;

component mux4x1_8 is
port(
		mux_in0, mux_in1, mux_in2, mux_in3: in std_logic_vector (7 downto 0);
		mux_sel: in std_logic_vector (1 downto 0);
		mux_out: out std_logic_vector (7 downto 0)
	);
end component;

component mux4x1_10 is
port(
		mux_in0, mux_in1, mux_in2, mux_in3: in std_logic_vector (9 downto 0);
		mux_sel: in std_logic_vector (1 downto 0);
		mux_out: out std_logic_vector (9 downto 0)
	);
end component;

component reg1_l is
	port(
		reg1_clk, reg1_ld: in std_logic;
		reg1_in: in std_logic;
		reg1_out: out std_logic
	);
end component;

component reg8_l is
	port(
		reg8_clk, reg8_ld: in std_logic;
		reg8_in: in std_logic_vector (7 downto 0);
		reg8_out: out std_logic_vector (7 downto 0)
	);
end component;

component reg10 is
	port(
		reg10_clk, reg10_ld, reg10_clr: in std_logic;
		reg10_in: in std_logic_vector (9 downto 0);
		reg10_out: out std_logic_vector (9 downto 0)
	);
end component;

component reg10_l is
	port(
		reg10_clk, reg10_ld: in std_logic;
		reg10_in: in std_logic_vector (9 downto 0);
		reg10_out: out std_logic_vector (9 downto 0)
	);
end component;

component reg16_l is
	port(
		reg16_clk, reg16_ld: in std_logic;
		reg16_in: in std_logic_vector (15 downto 0);
		reg16_out: out std_logic_vector (15 downto 0)
	);
end component;

component ula is
	port(
		ula_in0, ula_in1: in std_logic_vector(7 downto 0);
		ula_opcode: in std_logic_vector(2 downto 0);
		ula_flagC, ula_flagO, ula_flagS: out std_logic;
		ula_out: out std_logic_vector(7 downto 0)
	);
end component;

COMPONENT men_dados IS
	PORT(
		address: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock: IN STD_LOGIC  := '1';
		data: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren: IN STD_LOGIC ;
		q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT men_prog IS
	PORT(
		address: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		clock: IN STD_LOGIC  := '1';
		q: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END COMPONENT;

begin

	md: men_dados port map (dp_md_addres, dp_clk, dp_ula_in0, dp_wr_md, md_data_out);
	mp: men_prog port map (dp_out_pc, NOT(dp_clk), mp_data_out);
	ula_cmp: ula port map (dp_ula_in0, dp_ula_in1, dp_ula_code, dp_ula_c, dp_ula_o, dp_ula_s, dp_ula_out);
	
	inc_PC: inc_10 port map (dp_out_pc, dp_out_inc);
	add_PC: add_10 port map (dp_RI(6 downto 0), dp_out_pc, dp_out_add);
	add_MD: add_8 port map (dp_RI(6 downto 0), dp_ula_in1, dp_md_addres);
	comp: comp_8 port map (dp_ula_in0, dp_ula_in1, ula_comp_eq, ula_comp_lt);
	reg_eq: reg1_l port map (NOT(dp_clk), dp_ld_eq, ula_comp_eq, dp_comp_eq);
	reg_lt: reg1_l port map (NOT(dp_clk), dp_ld_lt, ula_comp_lt, dp_comp_lt);
	
	reg_i0: reg8_l port map (NOT(dp_clk), dp_ld_i0, data_in_i0, data_out_ri0);
	reg_i1: reg8_l port map (NOT(dp_clk), dp_ld_i1, data_in_i1, data_out_ri1);
	
	reg_o0: reg8_l port map (dp_clk, dp_ld_o0, dp_ula_in0, data_out_o0);
	reg_o1: reg8_l port map (dp_clk, dp_ld_o1, dp_ula_in0, data_out_o1);
	
	reg_r0: reg8_l port map (dp_clk, dp_ld_r0, "00000000", data_out_r0);
	reg_r1: reg8_l port map (dp_clk, dp_ld_r1, data_in_rx, data_out_r1);
	reg_r2: reg8_l port map (dp_clk, dp_ld_r2, data_in_rx, data_out_r2);
	reg_r3: reg8_l port map (dp_clk, dp_ld_r3, data_in_rx, data_out_r3);
	
	reg_C: reg1_l port map (dp_clk, dp_ld_c, dp_ula_c, dp_C);
	reg_O: reg1_l port map (dp_clk, dp_ld_o, dp_ula_o, dp_O);
	reg_S: reg1_l port map (dp_clk, dp_ld_s, dp_ula_s, dp_S);
	
	reg_PC: reg10 port map (dp_clk, dp_ld_pc, dp_rst_pc, dp_in_pc, dp_out_pc);
	reg_RP: reg10_l port map (dp_clk, dp_ld_rp, dp_out_inc, dp_out_rp);
	reg_RI: reg16_l port map (dp_clk, dp_ld_ri, mp_data_out, dp_RI);
	
	mux_i0: mux4x1_8 port map (data_out_ri0, data_out_ri1, md_data_out, dp_ula_out, dp_addr_i0, data_in_rx);
	mux_o0: mux4x1_8 port map (data_out_r0, data_out_r1, data_out_r2, data_out_r3, dp_addr_o0, dp_ula_in0);
	mux_o1: mux4x1_8 port map (data_out_r0, data_out_r1, data_out_r2, data_out_r3, dp_addr_o1, dp_mux_out_o1);
	mux_o2: mux2x1_8 port map (dp_mux_out_o1, dp_RI(7 downto 0), dp_addr_o2, dp_ula_in1);
	mux_pc: mux4x1_10 port map (dp_out_inc, dp_RI(9 downto 0), dp_out_rp, dp_out_add, dp_addr_pc, dp_in_pc);
	
	dp_RI_ext <= dp_RI(15 downto 10);
	
end arc_datapath;