`ifndef BASE_TEST_SV
`define BASE_TEST_SV

class base_test extends uvm_test;
  //tid
  string tid = get_name();

  //regist to factory
  `uvm_component_utils_begin(base_test)
  `uvm_component_utils_end

  //statement children class

  //coverage component
  cov_top cov;

  //statement virutal sequencer
  virtual_sequencer vseqr;

  //register model

  //parameter get from sim
  // int fifo_size = 1;

  //function new
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(tid, "start function new", UVM_DEBUG)
    `uvm_info(tid, "end function new", UVM_DEBUG)
  endfunction:new
  
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);

endclass:base_test

function void base_test::build_phase(uvm_phase phase);
  `uvm_info(tid, "start build phase", UVM_DEBUG)
  super.build_phase(phase);

  //override 
  // set_type_override_by_type(, );
  // set_inst_override_by_type("", , );
  
  //config value
  //uvm_config_db#()::set(this, "", "", );
  // $value$plusargs("FIFO_SIZE=%d", fifo_size);
  // uvm_config_db#(int)::set(this, "env", "FIFO_SIZE", fifo_size);

  //create env

  //create virtual sequencer
  vseqr = virtual_sequencer::type_id::create("vseqr",this);

  //create coverage component
  cov = cov_top::type_id::create("cov",this);

  //create regmodel and adapter

  //set max qiut count
  // set_report_max_quit_count(10);
  
  `uvm_info(tid, "end build phase", UVM_DEBUG)
endfunction:build_phase

function void base_test::connect_phase(uvm_phase phase);
  `uvm_info(tid, "start connect phase", UVM_DEBUG)
  super.connect_phase(phase);
  
  //connect virtual sequenver

  //connect regmodel adapter and predictor
  
  `uvm_info(tid, "end connect phase", UVM_DEBUG)
endfunction:connect_phase

function void base_test::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(tid, "start star of simulation phase", UVM_DEBUG)
  super.start_of_simulation_phase(phase);
  //print factory infor
  uvm_factory::get().print();
  //print testbench topology
  uvm_top.print_topology(); //or use print()
  `uvm_info(tid, "end star of simulation phase", UVM_DEBUG)
endfunction:start_of_simulation_phase

task base_test:: main_phase(uvm_phase phase);
  `uvm_info(tid, "start main phase", UVM_DEBUG)
  super.main_phase(phase);
  `uvm_info(tid, "end main phase", UVM_DEBUG)
endtask:main_phase

function void base_test::report_phase(uvm_phase phase);
  uvm_report_server ser;

  int err_num;
  int inf_num;
  int warn_num;
  int fat_num;

  `uvm_info(tid, "start star of report phase", UVM_DEBUG)
  super.report_phase(phase);
  ser = get_report_server();
  err_num = ser.get_severity_count(UVM_ERROR);
  inf_num = ser.get_severity_count(UVM_INFO);
  warn_num = ser.get_severity_count(UVM_WARNING);
  fat_num = ser.get_severity_count(UVM_FATAL);

  if(err_num || fat_num) begin
    $display("\033[1;31m******************************\033[0m"); //red text (5m flash)
    $display("\033[1;31m*** EXCUTE SIMULATION FAIL ***\033[0m");
    $display("\033[1;31m******************************\033[0m");
  end
  else begin
    $display("\033[1;32m******************************\033[0m");//green text
    $display("\033[1;32m*** EXCUTE SIMULATION PASS ***\033[0m");
    $display("\033[1;32m******************************\033[0m");
  end
  
  `uvm_info(tid, "end report phase", UVM_DEBUG)
endfunction:report_phase

`endif