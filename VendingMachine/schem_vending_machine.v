module schem_vending_machine(in,clk,reset,out,change);
input [1:0] in;
input clk,reset;
output reg [1:0] out;
output reg [1:0] change;
parameter s1=0,s2=1,s3=2,s4=3;
reg[1:0] cs,ns;
always @(posedge clk)begin
if(reset==1)begin
cs<=0;
ns<=0;
change<=2'b00;
out<=2'b00;
end
else
case(cs)
s1: if(in==2'b00)
begin
ns<=s1;
out=2'b00;
change=2'b00;
end
else if(in==2'b01)
begin
ns<=s2;
out=2'b00;
change=2'b00;
end
else if(in==2'b10)
begin
ns<=s3;
out=2'b01;
change=2'b00;
end
s2:if(in==2'b00)
begin
ns<=s1;
out=2'b00;
change=2'b01;
end
else if(in==2'b01)
begin
ns<=s3;
out=2'b01;
change=2'b00;
end
else if(in==2'b10)
begin
ns<=s4;
out=2'b01;
change=2'b01;
end
s3:if(in==2'b00)
begin
ns<=s1;
out=2'b01;
change=2'b00;
end
else if(in==2'b01)
begin
ns<=s4;
out=2'b00;
change=2'b00;
end
else if(in==2'b10)
begin
ns<=s1;
out=2'b10;
change=2'b00;
end
s4: if(in==2'b00)
begin
ns<=s1;
out=2'b01;
change=2'b01;
end
else if(in==2'b01)
begin
ns<=s1;
out=2'b10;
change=2'b00;
end
else if(in==2'b10)
begin
ns<=s1;
out=2'b10;
change=2'b01;
end
endcase
end
endmodule
