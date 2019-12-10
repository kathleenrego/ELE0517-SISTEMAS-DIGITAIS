library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
		ula_in0, ula_in1: in std_logic_vector(7 downto 0);
		ula_opcode: in std_logic_vector(2 downto 0);
		ula_flagC, ula_flagO, ula_flagS: out std_logic;
		ula_out: out std_logic_vector(7 downto 0)
	);
end ula;

architecture arc_ula of ula is
signal ula_in0_9, ula_in1_9, ula_out_9: std_logic_vector(8 downto 0);
signal ula_add, ula_sub, ula_and, ula_or, ula_xor, ula_srl, ula_sll, ula_sra: std_logic_vector(8 downto 0);

component add_9 is
port(
		add_in0, add_in1: in std_logic_vector (8 downto 0);
		add_out: out std_logic_vector (8 downto 0)
	);
end component;

component sub_9 is
port(
		sub_in0, sub_in1: in std_logic_vector (8 downto 0);
		sub_out: out std_logic_vector (8 downto 0)
	);
end component;

component and_9 is
port(
		and_in0, and_in1: in std_logic_vector (8 downto 0);
		and_out: out std_logic_vector (8 downto 0)
	);
end component;

component or_9 is
port(
		or_in0, or_in1: in std_logic_vector (8 downto 0);
		or_out: out std_logic_vector (8 downto 0)
	);
end component;

component xor_9 is
port(
		xor_in0, xor_in1: in std_logic_vector (8 downto 0);
		xor_out: out std_logic_vector (8 downto 0)
	);
end component;

component srl_9 is
port(
		srl_in0, srl_in1: in std_logic_vector (8 downto 0);
		srl_out: out std_logic_vector (8 downto 0)
	);
end component;

component sll_9 is
port(
		sll_in0, sll_in1: in std_logic_vector (8 downto 0);
		sll_out: out std_logic_vector (8 downto 0)
	);
end component;

component sra_9 is
port(
		sra_in0, sra_in1: in std_logic_vector (8 downto 0);
		sra_out: out std_logic_vector (8 downto 0)
	);
end component;

component mux8x1_9 is
	port(
		mux_in0, mux_in1, mux_in2, mux_in3, mux_in4, mux_in5, mux_in6, mux_in7: in std_logic_vector(8 downto 0);
		mux_sel: in std_logic_vector(2 downto 0);
		mux_out: out std_logic_vector(8 downto 0)
	);
end component;

begin
	
	process(ula_in0, ula_in1, ula_opcode)
	begin
		if(ula_opcode = "101") then
			ula_in0_9 <= '0' & ula_in0;
			ula_in1_9 <= '0' & ula_in1;
		else
			ula_in0_9 <= ula_in0(7) & ula_in0;
			ula_in1_9 <= ula_in1(7) & ula_in1;
		end if;
	end process;
	
	process(ula_in0, ula_in1, ula_opcode)
	begin
		if(ula_opcode = "010" or ula_opcode = "011" or ula_opcode = "100") then
			ula_flagC <= '0';
		else
			ula_flagC <= ula_out_9(8);
		end if;
	end process;
	
	process(ula_in0, ula_in1, ula_opcode)
	begin
		if(ula_opcode = "000") then
			if(ula_in0(7) = ula_in1(7) and ula_in0(7) /= ula_out_9(7)) then
				ula_flagO <= '1';
			else
				ula_flagO <= '0';
			end if;
		elsif(ula_opcode = "001") then
			if(ula_in0(7) /= ula_in1(7) and ula_in0(7) /= ula_out_9(7)) then
				ula_flagO <= '1';
			else
				ula_flagO <= '0';
			end if;
		else
			ula_flagO <= '0';
		end if;
	end process;
	
	ula_flagS <= ula_out_9(7);
	ula_out <= ula_out_9(7 downto 0);

	add_comp: add_9 port map(ula_in0_9, ula_in1_9, ula_add);
	sub_comp: sub_9 port map(ula_in0_9, ula_in1_9, ula_sub);
	and_comp: and_9 port map(ula_in0_9, ula_in1_9, ula_and);
	or_comp:  or_9 port map(ula_in0_9, ula_in1_9, ula_or);
	xor_comp: xor_9 port map(ula_in0_9, ula_in1_9, ula_xor);
	srl_comp: srl_9 port map(ula_in0_9, ula_in1_9, ula_srl);
	sll_comp: sll_9 port map(ula_in0_9, ula_in1_9, ula_sll);
	sra_comp: sra_9 port map(ula_in0_9, ula_in1_9, ula_sra);
	mux_comp: mux8x1_9 port map(ula_add, ula_sub, ula_and, ula_or, ula_xor, ula_srl, ula_sll, ula_sra, ula_opcode, ula_out_9);
end arc_ula;
