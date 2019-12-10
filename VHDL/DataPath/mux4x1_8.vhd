library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_8 is
port(
		mux_in0, mux_in1, mux_in2, mux_in3: in std_logic_vector (7 downto 0);
		mux_sel: in std_logic_vector (1 downto 0);
		mux_out: out std_logic_vector (7 downto 0)
	);
end mux4x1_8;

architecture arc_mux4x1_8 of mux4x1_8 is
begin
	process(mux_sel, mux_in0, mux_in1, mux_in2, mux_in3)
	begin
		case mux_sel is
			when "00" =>
				mux_out <= mux_in0;
			when "01" =>
				mux_out <= mux_in1;
			when "10" =>
				mux_out <= mux_in2;
			when "11" =>
				mux_out <= mux_in3;
		end case;
	end process;
end arc_mux4x1_8;