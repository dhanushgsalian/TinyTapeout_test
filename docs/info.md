<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a 4-floor elevator controller in Verilog using a Finite State Machine (FSM) and a timer module. The controller responds to user requests, moving the elevator step-by-step between floors while maintaining the current state.

## How to test

To test the elevator controller, first, reset the system by setting rst_n = 0 and then rst_n = 1. Next, request a floor by assigning a value to ui_in (e.g., ui_in = 4'b0100 for Floor 2). Observe the uo_out signal, which indicates the current floor. The elevator moves step-by-step, transitioning floors every one second. Test different cases such as moving up, moving down, or staying on the same floor. You can simulate the design using a testbench or implement it on an FPGA for real-world testing.

## External hardware

GPIO, LED
