library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inc_10 is
port(
		inc_in: in std_logic_vector (9 downto 0);
		inc_out: out std_logic_vector (9 downto 0)
	);
end inc_10;

architecture arc_inc_10 of inc_10 is
begin
	inc_out <= std_logic_vector(signed(inc_in) + 1);
end arc_inc_10;