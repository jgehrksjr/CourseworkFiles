library verilog;
use verilog.vl_types.all;
entity CE4720_SimpleCPU_vlg_check_tst is
    port(
        AC_OUT          : in     vl_logic_vector(7 downto 0);
        ACload          : in     vl_logic;
        ALUSEL          : in     vl_logic_vector(1 downto 0);
        AR_IN           : in     vl_logic_vector(7 downto 0);
        AR_OUT          : in     vl_logic_vector(4 downto 0);
        ARload          : in     vl_logic;
        BUS_AC          : in     vl_logic;
        BUS_ALU         : in     vl_logic;
        BUS_DR          : in     vl_logic;
        BUS_MEM         : in     vl_logic;
        BUS_PC          : in     vl_logic;
        CPUclk          : in     vl_logic;
        DR_OUT          : in     vl_logic_vector(7 downto 0);
        DRload          : in     vl_logic;
        IR_OUT          : in     vl_logic_vector(2 downto 0);
        IRload          : in     vl_logic;
        MainBus         : in     vl_logic_vector(7 downto 0);
        MDenable        : in     vl_logic;
        MEM_OUT         : in     vl_logic_vector(7 downto 0);
        MemRead         : in     vl_logic;
        MemWrite        : in     vl_logic;
        MuxOut          : in     vl_logic_vector(4 downto 0);
        PC_OUT          : in     vl_logic_vector(7 downto 0);
        PCinc           : in     vl_logic;
        PCload          : in     vl_logic;
        PCloadAR        : in     vl_logic;
        PCloadZ         : in     vl_logic;
        Zflag           : in     vl_logic;
        Zload           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end CE4720_SimpleCPU_vlg_check_tst;
