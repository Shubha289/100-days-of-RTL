module clock_buffer(master_clk,buffer_clk);

input master_clk;
output buffer_clk;
//BUF is a single-input single-output gate, similar to NOT, that copies its input value to its output without inversion
buf b1(buffer_clk,master_clk);

endmodule