library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg8_l is
	port(
		reg8_clk, reg8_ld: in std_logic;
		reg8_in: in std_logic_vector (7 downto 0);
		reg8_out: out std_logic_vector (7 downto 0)
	);
end reg8_l;

architecture arc_reg8_l of reg8_l is
begin
	process(reg8_clk)
	begin
		if (rising_edge(reg8_clk)) then
			if (reg8_ld = '1') then
				reg8_out <= reg8_in;
			end if;
		end if;
	end process;
end arc_reg8_l;