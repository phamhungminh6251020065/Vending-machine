module vending_machine_tb();
reg clk, rst, inN, inD;
wire out;

vending_machine DUT(clk, rst, inN, inD, out);

always #5 clk=~clk;

initial begin
inN=0; inD=0; clk=0; rst=0;

$monitor("rst=%b; inN=%b; inD=%B; state=%b; nextstate=%b; out=%b", rst, inN, inN, DUT.state, DUT.nextstate, out);

#10 rst=1;
#10 rst=0;
//case 1: add 5 cents
#10 inN=1; //0 cents
#10 inN=0; //0 cents
//case 2: add 10 cents
#10 inN=1; //5 cents
#10 inN=0; //10 cents
//case 3: add 0 cents
#10 inN=0; //10 cents
#10 inD=0; //5 cents

#10 $finish;
end

endmodule 