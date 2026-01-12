//============================================================
// Module: Traffic Light Controller
// Description: Controls traffic lights for main road (m1, m2, mT) 
//              and side road (s) with timed state transitions.
//============================================================

module traffic_light_controller(clk, reset, light_m1, light_m2, light_mT, light_s);

    // Input ports
    input clk, reset;

    // Output ports for traffic lights (3 bits each: Red/Yellow/Green)
    output reg [2:0] light_m1;
    output reg [2:0] light_m2;
    output reg [2:0] light_mT;
    output reg [2:0] light_s;

    //============================================================
    // State encoding
    //============================================================
    parameter s1 = 0,   // Main road 1 & 2 Green
              s2 = 1,   // Main road 2 Yellow
              s3 = 2,   // Main road Turn (T) Green
              s4 = 3,   // Turn Yellow
              s5 = 4,   // Side road Green
              s6 = 5;   // Side road Yellow

    //============================================================
    // Timing parameters (represent durations in seconds)
    //============================================================
    parameter sec7 = 7,
              sec5 = 5,
              sec3 = 3,
              sec2 = 2;

    //============================================================
    // Internal registers
    //============================================================
    reg [3:0] count;    // Counter for timing control
    reg [2:0] ps;       // Present state register

    //============================================================
    // State transition logic
    //============================================================
    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            ps <= s1;          // Start at state s1 after reset
            count <= 0;
        end
        else begin
            case (ps)

                //---------------- State s1 ----------------
                // Main road 1 & 2 Green for 7 seconds
                s1: if (count <= sec7) begin
                        ps <= s1;
                        count = count + 1;
                    end else begin
                        ps <= s2;
                        count <= 0;
                    end

                //---------------- State s2 ----------------
                // Main road 2 Yellow for 2 seconds
                s2: if (count <= sec2) begin
                        ps <= s2;
                        count = count + 1;
                    end else begin
                        ps <= s3;
                        count <= 0;
                    end

                //---------------- State s3 ----------------
                // Main road Turn Green for 5 seconds
                s3: if (count <= sec5) begin
                        ps <= s3;
                        count = count + 1;
                    end else begin
                        ps <= s4;
                        count <= 0;
                    end

                //---------------- State s4 ----------------
                // Turn Yellow for 2 seconds
                s4: if (count <= sec2) begin
                        ps <= s4;
                        count = count + 1;
                    end else begin
                        ps <= s5;
                        count <= 0;
                    end

                //---------------- State s5 ----------------
                // Side road Green for 5 seconds
                s5: if (count <= sec5) begin
                        ps <= s5;
                        count = count + 1;
                    end else begin
                        ps <= s6;
                        count <= 0;
                    end

                //---------------- State s6 ----------------
                // Side road Yellow for 2 seconds
                s6: if (count <= sec2) begin
                        ps <= s6;
                        count = count + 1;
                    end else begin
                        ps <= s1;   // Go back to state s1
                        count <= 0;
                    end

                default: ps <= s1;
            endcase
        end
    end

    //============================================================
    // Output logic (traffic light color control)
    //============================================================
    // Encoding convention:
    // 3'b100 = Red, 3'b010 = Yellow, 3'b001 = Green
    always @(ps) begin
        case (ps)
            s1: begin
                light_m1 = 3'b001; // Green
                light_m2 = 3'b001; // Green
                light_mT = 3'b100; // Red
                light_s  = 3'b100; // Red
            end

            s2: begin
                light_m1 = 3'b001; // Green
                light_m2 = 3'b010; // Yellow
                light_mT = 3'b100; // Red
                light_s  = 3'b100; // Red
            end

            s3: begin
                light_m1 = 3'b001; // Green
                light_m2 = 3'b100; // Red
                light_mT = 3'b001; // Green
                light_s  = 3'b100; // Red
            end

            s4: begin
                light_m1 = 3'b010; // Yellow
                light_m2 = 3'b100; // Red
                light_mT = 3'b010; // Yellow
                light_s  = 3'b100; // Red
            end

            s5: begin
                light_m1 = 3'b100; // Red
                light_m2 = 3'b100; // Red
                light_mT = 3'b100; // Red
                light_s  = 3'b001; // Green
            end

            s6: begin
                light_m1 = 3'b100; // Red
                light_m2 = 3'b100; // Red
                light_mT = 3'b100; // Red
                light_s  = 3'b010; // Yellow
            end
        endcase
    end

endmodule
