library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x1_9 is
	port(
		mux_in0, mux_in1, mux_in2, mux_in3, mux_in4, mux_in5, mux_in6, mux_in7: in std_logic_vector(8 downto 0);
		mux_sel: in std_logic_vector(2 downto 0);
		mux_out: out std_logic_vector(8 downto 0)
	);
end mux8x1_9;

architecture arc_mux8x1_9 of mux8x1_9 is
begin
	process(mux_sel, mux_in0, mux_in1, mux_in2, mux_in3, mux_in4, mux_in5, mux_in6, mux_in7)
	begin
		case mux_sel is
			when "000" =>
				mux_out <= mux_in0;
			when "001" =>
				mux_out <= mux_in1;
			when "010" =>
				mux_out <= mux_in2;
			when "011" =>
				mux_out <= mux_in3;
			when "100" =>
				mux_out <= mux_in4;
			when "101" =>
				mux_out <= mux_in5;
			when "110" =>
				mux_out <= mux_in6;
			when "111" =>
				mux_out <= mux_in7;
		end case;
	end process;
end arc_mux8x1_9;