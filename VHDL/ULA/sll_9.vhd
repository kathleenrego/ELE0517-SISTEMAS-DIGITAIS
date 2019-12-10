library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sll_9 is
port(
		sll_in0, sll_in1: in std_logic_vector (8 downto 0);
		sll_out: out std_logic_vector (8 downto 0)
	);
end sll_9;

architecture arc_sll9 of sll_9 is
begin
	sll_out <= std_logic_vector(shift_left(unsigned(sll_in0), to_integer(unsigned(sll_in1))));
end arc_sll9;