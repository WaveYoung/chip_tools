`ifndef VIRTUAL_SEQUENCE_SV
`define VIRTUAL_SEQUENCE_SV

class virtual_sequence extends uvm_sequence;
	//class id
	string tid = get_name();

	//uvm version
	real uvm_version = 1.1;

	//filed autumation
	`uvm_object_utils_begin(virtual_sequence)
	`uvm_object_utils_end

	//delcar p_sequencer
	`uvm_declare_p_sequencer(virtual_sequencer)  

	//declar sequence

	//function new
	function new(string name = "virtual_sequence");
		super.new(name);
		$value$plusargs("UVM_VERSION=%0f",uvm_version);
		`uvm_info(get_full_name(), $sformatf("UVM_VERSION=%0f", uvm_version), UVM_NONE)
	endfunction:new

	extern virtual task pre_start();
	extern virtual task post_start();
	extern virtual task body();
endclass:virtual_sequence

task virtual_sequence::pre_start();
	if(uvm_version==1.2) begin
		if(starting_phase == null)
			starting_phase = get_starting_phase();//for uvm-1.2, uvm-1.1 do not use this  
	end
	if(starting_phase != null)
		starting_phase.raise_objection(this);//or starting_phase.raise_objection(get_sequencer());
endtask:pre_start

task virtual_sequence::post_start();
	if(uvm_version==1.2) begin
		if(starting_phase == null)
			starting_phase = get_starting_phase();//for uvm-1.2, uvm-1.1 do not use this  
	end
	if(starting_phase != null)
		starting_phase.drop_objection(this);//or starting_phase.drop_objection(get_sequencer());
endtask:post_start

task virtual_sequence::body();
	//`uvm_do_on(seq,p_sequencer.sub_seqr)
	//seq.start(p_sequencer.sub_seqr);
endtask:body

`endif