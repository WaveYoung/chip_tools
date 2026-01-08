`ifndef TEST_TOP_SV
`define TEST_TOP_SV

module automatic tb_top;
  
  //define module only time scale
  // timeunit 1ns;
  // timeprecision 100ps; //0.1ns
  // $printtimescale(tb_top);  //print time scale info

  //clock define
  logic clk, nclk;

  //create clock
  parameter CYCLE_100MHZ = 10;
  parameter CYCLE_50MHZ  = 20;
  clk_gen#(CYCLE_50MHZ)  system_clk (.o_clk(clk), .o_nclk(nclk));

  //reset define
  logic rst_n;

  //create reset
  initial begin
    rst_n = 1'b0;
    #1000;
    rst_n = 1'b1;
  end

  //interface define

  //DUT instance
  // dut DUT(.clk(clk),
  //         .rst_n(rst_n),
  //         .rxd(input_if.data),
  //         .rx_dv(input_if.valid),
  //         .txd(output_if.data),
  //         .tx_en(output_if.valid)
  //        );

  //run into testcase
  initial begin
    run_test();
  end

  initial begin
    //config virtual interface
  end

  //dump wava
  // `include "dump_wave.sv"
  dump_wave d_wave();

  //assertion
  // examp_assert exmp_asrt(.clk(clk),.rst_n(rst_n),.rxd(input_if.data),.rx_dv(input_if.valid),.txd(output_if.data),.tx_en(output_if.valid));

  //watch dog
  initial begin:watch_dog //or use uvm_top.set_timeout(time like 9200s,0 or 1)
    #10000000000000;
    $finish();
  end

  //task
  // task task_name(input in ,output out);
  // endtask:task_name

  //function
  // function int func_name(input in ,output out);
  //   return func_name;
  // endfunction:func_name

endmodule:tb_top

`endif