library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg10_l is
	port(
		reg10_clk, reg10_ld: in std_logic;
		reg10_in: in std_logic_vector (9 downto 0);
		reg10_out: out std_logic_vector (9 downto 0)
	);
end reg10_l;

architecture arc_reg10_l of reg10_l is
begin
	process(reg10_clk)
	begin
		if (rising_edge(reg10_clk)) then
			if (reg10_ld = '1') then
				reg10_out <= reg10_in;
			end if;
		end if;
	end process;
end arc_reg10_l;