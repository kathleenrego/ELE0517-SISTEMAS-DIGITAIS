library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity micro is
	port(
		clk, rst: in std_logic;
		data_i0, data_i1: in std_logic_vector(7 downto 0);
		
		data_o0, data_o1: out std_logic_vector(7 downto 0);
		--clk_c: buffer std_logic;
		--rst_out: out std_logic;
		
		RI_ext: buffer std_logic_vector(5 downto 0);
		
		-- Controle de Estado
		--state: out integer;
		
		-- Instrução
		--RI: buffer std_logic_vector(15 downto 0);
		--mp_data: buffer std_logic_vector(15 downto 0);
		--ula_code: buffer std_logic_vector(2 downto 0);
		--ula_in0, ula_in1, ula_out: buffer std_logic_vector(7 downto 0);
		
		-- Controle do PC
		--out_pc: buffer std_logic_vector(9 downto 0)
		
		-- Controle do Comparador
		comp_eq, comp_lt: buffer std_logic
	);
end micro;

architecture arc_micro of micro is

-- signal comp_eq, comp_lt: std_logic;
signal C, O, S: std_logic;
signal RI: std_logic_vector(15 downto 0);

signal ld_i0, ld_i1: std_logic;

signal ld_o0, ld_o1: std_logic;

signal addr_i0, addr_o0, addr_o1, addr_pc: std_logic_vector(1 downto 0);
signal addr_o2: std_logic;

signal ld_r0, ld_r1, ld_r2, ld_r3: std_logic;
signal ld_o, ld_c, ld_s: std_logic;
signal ld_pc, rst_pc, ld_rp, ld_ri, ld_eq, ld_lt: std_logic;

signal wr_md: std_logic;

signal ula_code: std_logic_vector(2 downto 0);

signal clk_c: std_logic;

component ClockDiv is
   port(
	   clkIn  : in std_logic;
		clkOut : out std_logic
	);
end component;

component controller is
	port(
		
		ctl_clk, ctl_rst: in std_logic;
		
		ctl_comp_eq, ctl_comp_lt: in std_logic;
		ctl_C, ctl_O, ctl_S: in std_logic;
		ctl_RI: in std_logic_vector(15 downto 0);
		
		ctl_ld_i0, ctl_ld_i1: out std_logic;
		
		ctl_ld_o0, ctl_ld_o1: out std_logic;
		
		ctl_addr_i0, ctl_addr_o0, ctl_addr_o1, ctl_addr_pc: out std_logic_vector(1 downto 0);
		ctl_addr_o2: out std_logic;
		
		ctl_ld_r0, ctl_ld_r1, ctl_ld_r2, ctl_ld_r3: out std_logic;
		ctl_ld_o, ctl_ld_c, ctl_ld_s: out std_logic;
		ctl_ld_pc, ctl_rst_pc, ctl_ld_rp, ctl_ld_ri, ctl_ld_eq, ctl_ld_lt: out std_logic;
		
		ctl_wr_md: out std_logic;
		
		ctl_ula_code: out std_logic_vector(2 downto 0)
		
		-- Controle de Estado
		--s_state: out integer
	);
end component;

component datapath is
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
end component;

begin

	ctrl: controller port map(clk_c, rst, comp_eq, comp_lt, C, O, S, RI, ld_i0, ld_i1, ld_o0, ld_o1, addr_i0, addr_o0, addr_o1, addr_pc, addr_o2, 
	ld_r0, ld_r1, ld_r2, ld_r3, ld_o, ld_c, ld_s, ld_pc, rst_pc, ld_rp, ld_ri, ld_eq, ld_lt, wr_md, ula_code);
	
	dp: datapath port map (clk_c, ld_i0, ld_i1, data_i0, data_i1, ld_o0, ld_o1, data_o0, data_o1, addr_i0, addr_o0, addr_o1, addr_pc, addr_o2,
	ld_r0, ld_r1, ld_r2, ld_r3, ld_o, ld_c, ld_s, ld_pc, rst_pc, ld_rp, ld_ri, ld_eq, ld_lt, wr_md, ula_code, comp_eq, comp_lt, C, O, S, RI, RI_ext);
	
	clk_div: clockDiv port map (clk, clk_c);

end arc_micro;