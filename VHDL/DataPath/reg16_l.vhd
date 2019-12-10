library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16_l is
	port(
		reg16_clk, reg16_ld: in std_logic;
		reg16_in: in std_logic_vector (15 downto 0);
		reg16_out: out std_logic_vector (15 downto 0)
	);
end reg16_l;

architecture arc_reg16_l of reg16_l is
begin
	process(reg16_clk)
	begin
		if (rising_edge(reg16_clk)) then
			if (reg16_ld = '1') then
				reg16_out <= reg16_in;
			end if;
		end if;
	end process;
end arc_reg16_l;