library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_9 is
port(
		and_in0, and_in1: in std_logic_vector (8 downto 0);
		and_out: out std_logic_vector (8 downto 0)
	);
end and_9;

architecture arc_and9 of and_9 is
begin
	and_out <= and_in0 AND and_in1;
end arc_and9;