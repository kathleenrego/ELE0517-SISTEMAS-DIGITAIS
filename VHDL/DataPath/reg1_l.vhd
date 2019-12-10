library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1_l is
	port(
		reg1_clk, reg1_ld: in std_logic;
		reg1_in: in std_logic;
		reg1_out: out std_logic
	);
end reg1_l;

architecture arc_reg1_l of reg1_l is
begin
	process(reg1_clk)
	begin
		if (rising_edge(reg1_clk)) then
			if (reg1_ld = '1') then
				reg1_out <= reg1_in;
			end if;
		end if;
	end process;
end arc_reg1_l;