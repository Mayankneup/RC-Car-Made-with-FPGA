module segment(SW,HEX);

input [3:0] SW;
output [6:0] HEX;

// Segment 0 (1 + 4 + B + D)
assign HEX[0] =  (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) | //1
						(~SW[3] & SW[2] & ~SW[1] & ~SW[0]) | //4
						(SW[3] & ~SW[2] & SW[1] & SW[0])   | //B
						(SW[3] & SW[2] & ~SW[1] & SW[0]); //D
							

//Segment 1 (5 + 6 + B + E + F)
assign HEX[1] =  (~SW[3] & SW[2] & ~SW[1] & SW[0])|  // 5
                  (SW[3] & SW[2] & ~SW[1] & ~SW[0])|  // C
                  (~SW[3] & SW[2] & SW[1] & ~SW[0])|  // 6
                  (SW[3] & ~SW[2] & SW[1] & SW[0]) |  // B
                  (SW[3] & SW[2] & SW[1] & ~SW[0]) |  // E
                  (SW[3] & SW[2] & SW[1] & SW[0]);    // F


// Segment 2 (2 + C + E + F)
assign HEX[2] =  (~SW[3] & ~SW[2] & SW[1] & ~SW[0])|  // 2
                  (SW[3] & SW[2] & ~SW[1] & ~SW[0]) |  // C
                  (SW[3] & SW[2] & SW[1] & ~SW[0])  |  // E
                  (SW[3] & SW[2] & SW[1] & SW[0]);     // F


// Segment 3 (1 + 4 + 7 + A + F)
assign HEX[3] =  (~SW[3] & ~SW[2] & ~SW[1] & SW[0])|  // 1
                  (~SW[3] & SW[2] & ~SW[1] & ~SW[0])|  // 4
                  (~SW[3] & SW[2] & SW[1] & SW[0])  |  // 7
						(SW[3] & ~SW[2] & SW[1] & ~SW[0]) |  // A
						(SW[3] & SW[2] & SW[1] & SW[0]);     // F


// Segment 4 (1 + 3 + 4 + 5 + 7 + 9)
assign HEX[4] =  (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) |  // 1  
                  (~SW[3] & ~SW[2] & SW[1] & SW[0])  |  // 3  
						(~SW[3] & SW[2] & ~SW[1] & ~SW[0]) |  // 4  
						(~SW[3] & SW[2] & ~SW[1] & SW[0])  |  // 5  
						(~SW[3] & SW[2] & SW[1] & SW[0])   |  // 7    
						(SW[3] & ~SW[2] & ~SW[1] & SW[0]);    // 9  


// Segment 5 (1 + 2 + 3 + 7 + D)
assign HEX[5] =  (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) |  // 1  
						(~SW[3] & ~SW[2] & SW[1] & ~SW[0])  |  // 2  
						(~SW[3] & ~SW[2] & SW[1] & SW[0])   |  // 3  
						(~SW[3] & SW[2] & SW[1] & SW[0])   |   // 7    
						(SW[3] & SW[2] & ~SW[1] & SW[0]);   // D
						
// Segment 6 (1 + 7 + C + 0)
assign HEX[6] = (~SW[3] & ~SW[2] & ~SW[1]) | (~SW[3] & SW[2] & SW[1] & SW[0]) | (SW[3] & SW[2] & ~SW[1] & ~SW[0]);


endmodule
