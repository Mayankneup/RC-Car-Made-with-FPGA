module motor_control (
    input wire clk,
    input wire F, B, L, R,
    output reg O1, O2, O3, O4
);

// State definition
parameter [2:0] STOP     = 3'b000;
parameter [2:0] FORWARD  = 3'b001;
parameter [2:0] BACKWARD = 3'b010;
parameter [2:0] LEFT     = 3'b011;
parameter [2:0] RIGHT    = 3'b100;

reg [2:0] current, next;

// State transitions
always @(posedge clk) begin
    current <= next;
end

// Next state logic
always @(*) begin
    case ({F, B, L, R})
        4'b1000: next = FORWARD;
        4'b0100: next = BACKWARD;
        4'b0010: next = LEFT;
        4'b0001: next = RIGHT;
        default: next = STOP;
    endcase
end

// Output logic based on the current state
always @(posedge clk) begin
    case (current)
        FORWARD: begin
            O1 <= 1;
            O4 <= 1;
            O2 <= 0;
            O3 <= 0;
        end
        BACKWARD: begin
            O2 <= 1;
            O3 <= 1;
            O1 <= 0;
            O4 <= 0;
        end
        LEFT: begin
            O4 <= 1;
            O1 <= 0;
            O2 <= 0;
            O3 <= 0;
        end
        RIGHT: begin
            O1 <= 1;
            O2 <= 0;
            O3 <= 0;
            O4 <= 0;
        end
        STOP: begin
            O1 <= 0;
            O2 <= 0;
            O3 <= 0;
            O4 <= 0;
        end
        default: begin
            O1 <= 0;
            O2 <= 0;
            O3 <= 0;
            O4 <= 0;
        end
    endcase
end

endmodule