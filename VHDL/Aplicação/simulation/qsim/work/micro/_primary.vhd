library verilog;
use verilog.vl_types.all;
entity micro is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_i0         : in     vl_logic_vector(7 downto 0);
        data_i1         : in     vl_logic_vector(7 downto 0);
        data_o0         : out    vl_logic_vector(7 downto 0);
        data_o1         : out    vl_logic_vector(7 downto 0);
        state           : out    vl_logic_vector(31 downto 0);
        RI              : out    vl_logic_vector(15 downto 0);
        mp_data         : out    vl_logic_vector(15 downto 0);
        in_pc           : out    vl_logic_vector(9 downto 0);
        out_pc          : out    vl_logic_vector(9 downto 0)
    );
end micro;
