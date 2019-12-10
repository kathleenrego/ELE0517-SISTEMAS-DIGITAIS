library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg10 is
	port(
		reg10_clk, reg10_ld, reg10_clr: in std_logic;
		reg10_in: in std_logic_vector (9 downto 0);
		reg10_out: out std_logic_vector (9 downto 0)
	);
end reg10;

architecture arc_reg10 of reg10 is
begin
	process(reg10_clk)
	begin
		if (rising_edge(reg10_clk)) then
			if (reg10_clr = '1') then
				reg10_out <= "0000000000";
			elsif (reg10_ld = '1') then
				reg10_out <= reg10_in;
			end if;
		end if;
	end process;
end arc_reg10;