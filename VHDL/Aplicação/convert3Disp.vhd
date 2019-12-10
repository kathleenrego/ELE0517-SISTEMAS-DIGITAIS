library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity convert3Disp is
	port(
		num1: in std_logic_vector(7 downto 0);
		disp_0, disp_1, disp_2: out std_logic_vector(6 downto 0)
	);
end convert3Disp;

architecture behaviour of convert3Disp is
	signal n0, n1, n2: unsigned(3 downto 0) := "0000";
	signal tempNum0, tempNum1, tempNum2: unsigned(9 downto 0) := "0000000000";
	
	component convert2Disp7 is
		port(
			num: in unsigned (3 downto 0) := "0000";
			codeDisp: out std_logic_vector (6 downto 0) := "0000000"
		);
	end component;

begin
	tempNum2 <= (unsigned("00" & num1))/20;
	n2 <= tempNum2(3 downto 0);
	tempNum1 <= (unsigned("00" & num1)/2) mod 10;
	n1 <= tempNum1(3 downto 0);
	tempNum0 <= (resize((unsigned(num1)*5), 10)) mod 10;
	
	n0 <= tempNum0(3 downto 0);
	
	conv2 : convert2Disp7 port map(n2, disp_2);
	conv1 : convert2Disp7 port map(n1, disp_1);
	conv0 : convert2Disp7 port map(n0, disp_0);
end behaviour;