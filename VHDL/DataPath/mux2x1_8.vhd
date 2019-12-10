library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_8 is
port(
		mux_in0, mux_in1: in std_logic_vector (7 downto 0);
		mux_sel: in std_logic;
		mux_out: out std_logic_vector (7 downto 0)
	);
end mux2x1_8;

architecture arc_mux2x1_8 of mux2x1_8 is
begin
	process(mux_sel, mux_in0, mux_in1)
	begin
		case mux_sel is
			when '0' =>
				mux_out <= mux_in0;
			when '1' =>
				mux_out <= mux_in1;
		end case;
	end process;
end arc_mux2x1_8;