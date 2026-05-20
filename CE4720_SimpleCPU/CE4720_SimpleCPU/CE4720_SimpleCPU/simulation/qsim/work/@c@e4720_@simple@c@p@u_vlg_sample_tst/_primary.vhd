library verilog;
use verilog.vl_types.all;
entity CE4720_SimpleCPU_vlg_sample_tst is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end CE4720_SimpleCPU_vlg_sample_tst;
