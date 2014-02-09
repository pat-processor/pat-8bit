module testbench(sout) ;
  
reg sin, sclk, ssel ;
reg [2:0] saddr ;
reg [2:0] bufselect ;
reg [4:0] bufp ;
output sout ;


buffers theBuffers(sclk, sin, sout, ssel, saddr, bufselect, current_buffer, bufp) ;
    
initial
begin
	sin = 1 ;
	bufp = 0 ;
	sclk = 0 ;
	bufselect = 0 ;
	ssel = 1 ;
  // forever #1 sclk != sclk ;
end 

always #1 sclk = ~sclk;

  
  
endmodule