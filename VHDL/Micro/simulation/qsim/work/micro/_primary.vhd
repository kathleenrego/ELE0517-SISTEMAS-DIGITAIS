library verilog;
use verilog.vl_types.all;
entity micro is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_i0         : in     vl_logic_vector(7 downto 0);
        data_i1         : in     vl_logic_vector(7 downto 0);
        data_o0         : out    vl_logic_vector(7 downto 0);
        data_o1         : out    vl_logic_vector(7 downto 0)
    );
end micro;
