`ifndef CLK_GEN_SV
`define CLK_GEN_SV

module automatic clk_gen #(parameter cycle = 10, parameter phase = 10) (o_clk, o_nclk);
  output o_clk;
  output o_nclk;

  reg o_clk;
  reg clk_en;

  real delay;

  initial begin
    clk_en = 1'b1;
    #1;
    o_clk = 1'b0;
    delay = (($urandom_range(0,99)/100.0) * phase);
    #(delay);
    forever #(cycle/2.0) o_clk = ~o_clk & clk_en;
  end

  assign o_nclk = ~o_clk;

endmodule

`endif