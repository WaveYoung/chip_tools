class cov_top extends uvm_component;
    //define cov virtual interface
    virtual interface cov_if cov_if_bind;

    `uvm_component_utils(cov_top)

    covergroup cov_grp;
        cov_pint: coverpoint cov_if_bind.sample_sgn{
            bins sample_sgn0 = {0};
            bins sample_sgn1 = default;
        }
    endgroup

    function new(string name="cov_top", uvm_component parent=null);
        super.new(name,parent);
        cov_grp = new();
    endfunction:new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual cov_if)::get(this,"","cov_if",cov_if_bind)) begin
            `uvm_fatal("cov_top","coverage virtual interface must be set!")
        end
    endfunction:build_phase

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        fork
            while(1) begin
                @(cov_if_bind.cb);
                cov_grp.sample();
            end
        join_none
    endtask:main_phase

endclass