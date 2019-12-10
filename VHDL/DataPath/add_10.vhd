library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_10 is
port(
		add_in0: in std_logic_vector (6 downto 0);
		add_in1: in std_logic_vector (9 downto 0);
		add_out: out std_logic_vector (9 downto 0)
	);
end add_10;

architecture arc_add_10 of add_10 is
begin
	process (add_in0, add_in1)
	begin
		if (add_in0(6) = '1') then
			add_out <= std_logic_vector(signed("111" & add_in0) + signed(add_in1));
		else
			add_out <= std_logic_vector(signed("000" & add_in0) + signed(add_in1));
		end if;
	end process;
end arc_add_10;