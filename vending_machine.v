module vending_machine(clk, rst, inN, inD, out);
input clk, rst, inN, inD; // inN for 5 cents; inD for 10 cents
output reg out;
reg [1:0] state, nextstate;

parameter s0=2'b00, // s0 for state 0 cents
          s5=2'b01, // s5 for state 5 cents
          s10=2'b10, // s10 for state 10 cents
          s15=2'b11; // s15 for state 15 cents

// State register: Update state based on clock and reset
always @(posedge clk or posedge rst) begin
  if (rst) begin
    state <= s0;
  end else begin
    state <= nextstate;
  end
end

// Next state logic: Determine the next state based on inputs and current state
always @(*) begin
  case (state)
    s0: begin
      if (inN)      	   nextstate = s5; 
      else if (inD)        nextstate = s10;
      else                 nextstate = s0;
    end
    s5: begin
      if (inN)             nextstate = s10;
      else if (inD)        nextstate = s15;
      else                 nextstate = s5;
    end
    s10: begin
      if (inN)             nextstate = s15; 
      else if (inD)        nextstate = s15;
      else                 nextstate = s10;
    end
    s15: nextstate = s0;                            // Reset to initial state
    default: nextstate = s0;
  endcase
end

// Output logic: Generate output based on current state
always @(state) begin
  case (state)
    s0: out = 0;
    s5: out = 0;
    s10: out = 0;
    s15: out = 1; // Activate output when 15 cents is reached
   // default: out = 0;
  endcase
end

endmodule

