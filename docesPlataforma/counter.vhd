library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
port(
	clock_50: in std_logic;
	key: in std_logic_vector(0 downto 0); 
	switch1: in std_logic_vector(2 downto 0);
	rst: in std_logic;
	
	display1, display2, display3: out std_logic_vector(6 downto 0)
);
end counter;

architecture arc_counter of counter is

component nios_system
	port(
		signal clk_clk: in std_logic;
		signal reset_reset_n: in std_logic;
		signal switch1_export: in  std_logic_vector(2 downto 0);
		signal rst_export: in  std_logic;
		signal display1_export: out std_logic_vector(6 downto 0);
		signal display2_export: out std_logic_vector(6 downto 0);
		signal display3_export: out std_logic_vector(6 downto 0)
	);
end component;

begin

NiosII: nios_system
	port map(
		clk_clk => clock_50,
		reset_reset_n => key(0),
		switch1_export => switch1,
		rst_export => rst,
		display1_export => display1,
		display2_export => display2,
		display3_export => display3
	);
	
end arc_counter;