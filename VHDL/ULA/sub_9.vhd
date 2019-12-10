library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sub_9 is
port(
		sub_in0, sub_in1: in std_logic_vector (8 downto 0);
		sub_out: out std_logic_vector (8 downto 0)
	);
end sub_9;

architecture arc_sub9 of sub_9 is
begin
	sub_out <= std_logic_vector(signed(sub_in0) - signed(sub_in1));
end arc_sub9;