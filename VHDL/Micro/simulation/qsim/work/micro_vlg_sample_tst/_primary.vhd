library verilog;
use verilog.vl_types.all;
entity micro_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        data_i0         : in     vl_logic_vector(7 downto 0);
        data_i1         : in     vl_logic_vector(7 downto 0);
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end micro_vlg_sample_tst;
