module MDcounter5 (
    input clk,
    input reset,      // Add your main system reset wire here!
    input MDenable,
    output reg [4:0] MDaddr
);

always @(posedge clk or posedge reset)
begin
    if (reset)
        MDaddr <= 5'b00000;
    else if (!MDenable)
        MDaddr <= 5'b00000; // Stay at 0 during normal execution
    else
        MDaddr <= MDaddr + 1'b1; // Count cleanly during the actual dump
end

endmodule