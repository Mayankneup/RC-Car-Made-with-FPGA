module clock_divider #(
    parameter DIVISOR = 25  // 50 MHz → 2 MHz (50/25 = 2)
)(
    input clock_in,        // 50 MHz input
    output reg clock_out   // 2 MHz output
);
    reg [7:0] counter = 0;
    
    always @(posedge clock_in) begin
        if (counter >= DIVISOR-1) begin
            counter <= 0;
            clock_out <= ~clock_out;  // Toggle for 50% duty cycle
        end
        else begin
            counter <= counter + 1;
        end
    end
endmodule