library verilog;
use verilog.vl_types.all;
entity CE4720_SimpleCPU is
    port(
        MDenable        : out    vl_logic;
        CPUclk          : out    vl_logic;
        Clock           : in     vl_logic;
        IRload          : out    vl_logic;
        Reset           : in     vl_logic;
        DRload          : out    vl_logic;
        Zload           : out    vl_logic;
        ACload          : out    vl_logic;
        ALUSEL          : out    vl_logic_vector(1 downto 0);
        BUS_ALU         : out    vl_logic;
        BUS_AC          : out    vl_logic;
        BUS_DR          : out    vl_logic;
        PCinc           : out    vl_logic;
        PCload          : out    vl_logic;
        PCloadZ         : out    vl_logic;
        PCloadAR        : out    vl_logic;
        ARload          : out    vl_logic;
        BUS_PC          : out    vl_logic;
        MemWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        BUS_MEM         : out    vl_logic;
        Zflag           : out    vl_logic;
        AC_OUT          : out    vl_logic_vector(7 downto 0);
        AR_IN           : out    vl_logic_vector(7 downto 0);
        AR_OUT          : out    vl_logic_vector(4 downto 0);
        DR_OUT          : out    vl_logic_vector(7 downto 0);
        IR_OUT          : out    vl_logic_vector(2 downto 0);
        MainBus         : out    vl_logic_vector(7 downto 0);
        MEM_OUT         : out    vl_logic_vector(7 downto 0);
        MuxOut          : out    vl_logic_vector(4 downto 0);
        PC_OUT          : out    vl_logic_vector(7 downto 0)
    );
end CE4720_SimpleCPU;
