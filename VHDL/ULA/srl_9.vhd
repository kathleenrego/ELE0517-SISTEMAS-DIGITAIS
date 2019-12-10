library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity srl_9 is
port(
		srl_in0, srl_in1: in std_logic_vector (8 downto 0);
		srl_out: out std_logic_vector (8 downto 0)
	);
end srl_9;

architecture arc_srl9 of srl_9 is
begin
	srl_out <= std_logic_vector(shift_right(unsigned(srl_in0), to_integer(unsigned(srl_in1))));
end arc_srl9;