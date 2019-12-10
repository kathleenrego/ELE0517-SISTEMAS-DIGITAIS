library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_9 is
port(
		or_in0, or_in1: in std_logic_vector (8 downto 0);
		or_out: out std_logic_vector (8 downto 0)
	);
end or_9;

architecture arc_or9 of or_9 is
begin
	or_out <= or_in0 OR or_in1;
end arc_or9;