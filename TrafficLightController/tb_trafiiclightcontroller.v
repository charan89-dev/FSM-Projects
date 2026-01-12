//============================================================
// Testbench: tb_traffic_light_1
// Description: Testbench for traffic_light_controller
//              Generates clock and reset stimulus.
//============================================================

module tb_traffic_light_1();

    //========================================================
    // Testbench signals
    //========================================================
    reg clk;          // Clock signal
    reg reset;        // Asynchronous reset
    wire [2:0] light_m1;
    wire [2:0] light_m2;
    wire [2:0] light_mT;
    wire [2:0] light_s;

    //========================================================
    // DUT instantiation
    //========================================================
    traffic_light_controller uut (
        .clk      (clk),
        .reset    (reset),
        .light_m1 (light_m1),
        .light_m2 (light_m2),
        .light_mT (light_mT),
        .light_s  (light_s)
    );

    //========================================================
    // Clock generation
    //========================================================
    // Clock period = 10 time units (toggle every 5 units)
    initial begin
        clk = 0;
        forever #(10/2) clk = ~clk;
    end

    //========================================================
    // Reset and simulation control
    //========================================================
    initial begin
        // Initial condition: reset de-asserted
        reset = 0;

        // Wait some time, then assert reset
        #1000;
        reset = 1;

        // Keep reset asserted for some time
        #1000;
        reset = 0;

        // Run simulation for a long duration to observe cycles
        // Note: 100^200 is huge and not meaningful; better to use a fixed delay,
        //       e.g., #100000 or repeat with clock edges in practice.
        #100000;

        // End simulation
        $finish();
    end

endmodule
