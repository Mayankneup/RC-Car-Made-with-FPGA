module seg_driver_Y (
    input         rst,
    input         clk,
    input  [9:0]  A_num,
    input         A_int2,
    output [6:0]  HEX2,
    output [6:0]  HEX3
);

    wire [4:0] 	select_data;
    wire       	signed_bit;
    wire [3:0] 	abs_value;
    wire [3:0] 	digit_clamped;

    reg  [1:0] 	int2_shift;
    reg 	[23:0] 	int2_count;
    reg        	en_flag;

    // Select data bits and magnitude
    assign select_data = A_int2 ? A_num[9:5] : (A_num[9] ? (A_num[8] ? A_num[8:4]:5'h10):(A_num[8]?5'hf:A_num[8:4]));
    assign signed_bit = select_data[4];
 	 
    assign abs_value = signed_bit ? ~select_data[3:0] : select_data[3:0];
 	 
    assign digit_clamped = (abs_value > 4'd9) ? 4'd9 : abs_value;

    wire [6:0] hex2_val;
    wire [6:0] hex3_val;

    segment hex2 (.SW(digit_clamped), .HEX(hex2_val));
    assign hex3_val = signed_bit ? 7'b0111111 : 7'b1111111; // '-' or blank

    assign HEX2 = hex2_val;
    assign HEX3 = hex3_val;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            en_flag <= 1'b0; 
            int2_count <= 24'h800000;
        end else begin
            int2_shift <= {int2_shift[0], A_int2};

            if (!int2_shift[1] && int2_shift[0]) begin
                en_flag <= 1'b1;
                int2_count <= 24'h0;
            end else if (int2_count[23]) begin
                en_flag <= 1'b0;
            end else begin
                int2_count <= int2_count + 1;
            end
        end
    end

endmodule