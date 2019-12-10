library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_9 is
port(
		add_in0, add_in1: in std_logic_vector (8 downto 0);
		add_out: out std_logic_vector (8 downto 0)
	);
end add_9;

architecture arc_add9 of add_9 is
begin
	add_out <= std_logic_vector(signed(add_in0) + signed(add_in1));
end arc_add9;