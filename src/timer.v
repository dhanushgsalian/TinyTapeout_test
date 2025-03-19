module timer (input reset, clk, output reg one_sec_timer);

//`define SIM
`ifdef SIM
    localparam FREQ = 50;               //1 us delay  @50 MHz clock
`else
    localparam FREQ = 50 * 1000 * 1000; //1 sec delay @50 MHz clock
`endif


localparam SEC_WIDTH    = 3;

reg [25: 0] count;

  always @ (posedge clk or posedge reset ) begin
    if(reset) begin
	  one_sec_timer <= 0;
	  count <= 0;
    end
    else if (count == FREQ * 1 ) begin
			count <= 0;
			one_sec_timer <= 1'b1;
			end
	else begin
		count <= count + 1'b1;
		one_sec_timer <= 1'b0;
    end
  end
 
endmodule
