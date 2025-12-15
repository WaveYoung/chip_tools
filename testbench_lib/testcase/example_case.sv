`ifndef EXAMPLE_CASE_SV
`define EXAMPLE_CASE_SV

class example_case extends base_test;
  //tid
  string tid = get_name();

  //regist to factory
  `uvm_component_utils_begin(example_case)
  `uvm_component_utils_end

  //function new
  function new(string name = "example_case", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(tid, "start function new", UVM_DEBUG)
    `uvm_info(tid, "end function new", UVM_DEBUG)
  endfunction:new

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
endclass:example_case

function void example_case::build_phase(uvm_phase phase);
  `uvm_info(tid, "start build phase", UVM_DEBUG)
  super.build_phase(phase);
  //set default sequence
  uvm_config_db#(uvm_object_wrapper)::set(this,"vseqr.main_phase","default_sequence",virtual_sequence::type_id::get());
  `uvm_info(tid, "end build phase", UVM_DEBUG)
endfunction:build_phase

function void example_case::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(tid, "start end of elaboration phase", UVM_DEBUG)
  super.end_of_elaboration_phase(phase);
  //set sequencer arbitration
  // env.i_agent.sequencer.set_arbitration(SEQ_ARB_STRICT_FIFO); //SEQ_ARB_FIFO(default)、SEQ_ARB_WEIGHTED 、SEQ_ARB_RANDOM、SEQ_ARB_STRICT_FIFO、SEQ_ARB_STRICT_RANDOM、SEQ_ARB_USER
  `uvm_info(tid, "end end of elaboration phase", UVM_DEBUG)
endfunction:end_of_elaboration_phase
`endif