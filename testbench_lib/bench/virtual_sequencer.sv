`ifndef VIRTUAL_SEQUENCER_SV
`define VIRTUAL_SEQUENCER_SV

class virtual_sequencer extends uvm_sequencer;
	//class id
	string tid = get_name();

	//filed autumation
	`uvm_component_utils_begin(virtual_sequencer)
	`uvm_component_utils_end

	//delcare sub sequenver

	//function new
	function new(string name = "virtual_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction:new

	extern virtual task main_phase(uvm_phase phase);
endclass:virtual_sequencer

task virtual_sequencer::main_phase(uvm_phase phase);
	super.main_phase(phase);
endtask:main_phase

`endif