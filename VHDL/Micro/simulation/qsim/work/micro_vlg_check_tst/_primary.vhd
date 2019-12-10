library verilog;
use verilog.vl_types.all;
entity micro_vlg_check_tst is
    port(
        data_o0         : in     vl_logic_vector(7 downto 0);
        data_o1         : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end micro_vlg_check_tst;
