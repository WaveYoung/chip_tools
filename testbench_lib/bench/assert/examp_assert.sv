`ifndef EXAMPLE_ASSERT__SV
`define EXAMPLE_ASSERT__SV

module automatic examp_assert #(parameter  DATA_WIDTH = 8) (clk,rst_n,rxd,rx_dv,txd,tx_en);

  input                       clk;
  input                       rst_n;
  input [DATA_WIDTH - 1:0]    rxd;
  input                       rx_dv;
  input [DATA_WIDTH - 1:0]    txd;
  input                       tx_en;

  //define sequence
  sequence examp_seq;
    @(posedge clk) rx_dv ##1 tx_en;
  endsequence:examp_seq

  //define property
  property check_data;
    @(posedge clk) disable iff(!rst_n) rxd |=> txd; //rxd |-> txd
  endproperty:check_data

  property clk_freq_check(period); //propety check clock frequence
    time current_time;
    @(posedge clk) disable iff(!rst_n) (1,current_time = $time) |=> ($time - current_time == period);
  endproperty:clk_freq_check
  
  //assert property
  a_check_data:assert property(check_data) begin
    //success 
    $display("ok");
    `uvm_info("asrt","assert ok",UVM_LOW)
  end
  else begin
    //fail
    $display("error");
    `uvm_error("asrt","assert error")
  end
  a_clk_freq_check:assert property(clk_freq_check(20))begin //check clk 50Mhz
    `uvm_info("asrt","assert ok",UVM_LOW)
  end
  else begin
    `uvm_error("asrt","assert error")
  end

  //property coverage
  //cover property(check_data);
  //cover property(clk_freq_check);

endmodule:examp_assert

`endif