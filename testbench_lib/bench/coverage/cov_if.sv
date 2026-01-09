interface automatic cov_if(input clk, input rstn);
    logic sample_sgn;
    
    clocking cb@(posedge clk);
        default input #1 output #1;
        input sample_sgn;
    endclocking

endinterface