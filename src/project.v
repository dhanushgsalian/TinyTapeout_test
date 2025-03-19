/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_escalator (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);



  // List all unused inputs to prevent warnings
    wire _unused = &{ena, uio_in, uio_out, uio_oe, 1'b0};

    reg [3:0] present_floor;
    wire [3:0] requested_floor;
    wire reset;
	
    assign reset = rst_n;
    assign ui_in = requested_floor; 
    assign uo_out = present_floor;
    
    // Define states for different floors
    parameter FLOOR_0 = 4'b0001;
    parameter FLOOR_1 = 4'b0010;
    parameter FLOOR_2 = 4'b0100;
    parameter FLOOR_3 = 4'b1000;

    reg [3:0] state, next_state;

    wire one_sec_timer;

    timer q1(.reset(reset), 
	     .clk(clk),
	     .one_sec_timer(one_sec_timer));
			
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= FLOOR_0;  // Reset to Ground Floor
        else if (one_sec_timer) 
            state <= next_state;
    end
	 
    // Next State Logic (Step-by-Step Movement)
    always @(*) begin
        case (state)
            FLOOR_0: begin
                if (requested_floor > state) 
                    next_state = FLOOR_1;
                else 
                    next_state = FLOOR_0;
            end

            FLOOR_1: begin
                if (requested_floor > state) 
                    next_state = FLOOR_2;
                else if (requested_floor < state) 
                    next_state = FLOOR_0;
                else 
                    next_state = FLOOR_1;
            end
				
            FLOOR_2: begin
                if (requested_floor > state) 
                    next_state = FLOOR_3;
                else if (requested_floor < state) 
                    next_state = FLOOR_1;
                else 
                    next_state = FLOOR_2;
            end
				
            FLOOR_3: begin
                if (requested_floor < state) 
                    next_state = FLOOR_2;
                else 
                    next_state = FLOOR_3;
            end

            default: next_state = FLOOR_0;
        endcase
    end
	 
    // Output Logic
    always @(posedge clk) begin
        present_floor <= state;
    end
	 
endmodule
