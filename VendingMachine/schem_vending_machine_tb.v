`timescale 1ns/1ps

module schem_vending_machine_tb;

  // DUT inputs
  reg  [1:0] in;
  reg        clk;
  reg        reset;

  // DUT outputs
  wire [1:0] out;
  wire [1:0] change;

  // Instantiate DUT
  schem_vending_machine dut (
    .in(in),
    .clk(clk),
    .reset(reset),
    .out(out),
    .change(change)
  );

  // Clock generation: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // Initialize
    reset = 1;
    in    = 2'b00;
    #20;
    reset = 0;   // release reset

    // Sequence similar to your waveform
    // 1) 01, 01, 10 ...
    #10 in = 2'b01;
    #10 in = 2'b01;
    #10 in = 2'b10;
    #10 in = 2'b00;

    // 2) 01, 10, 01 ...
    #10 in = 2'b01;
    #10 in = 2'b10;
    #10 in = 2'b01;
    #10 in = 2'b00;

    // 3) 10, 10, 01, 00 ...
    #10 in = 2'b10;
    #10 in = 2'b10;
    #10 in = 2'b01;
    #10 in = 2'b00;

    // Add more patterns if you want to test all cases

    #50;
    $finish;
  end

endmodule
