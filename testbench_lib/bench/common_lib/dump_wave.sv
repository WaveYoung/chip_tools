`ifndef DUMP_WAVE_SV
`define DUMP_WAVE_SV

module automatic dump_wave();
  //only fsdb can set param and begin end time
  bit[63:0] dump_begin = 'h0;
  bit[63:0] dump_end   = 'h0;
  bit       dump_mda   = 'h0;
  //set dump wave configureation
  string wave_type     = ""; //fsdb vcd
  string wave_name     ="dump_wave";
  string scop_path     ="./dump_scope.cfg";
  string log_path      ="./dump.log";

  initial begin 
    //get set from sim_option
    $value$plusargs("wave=%s",      wave_type);
    $value$plusargs("wave_name=%s", wave_name);
    $value$plusargs("mda=%s",       dump_mda);
    $value$plusargs("dump_begin=%d",dump_begin);
    $value$plusargs("dump_end=%d",  dump_end);
    //fsdb
    if(wave_type == "fsdb") begin
      #dump_begin;
      wave_name = "./"+wave_name+".fsdb"
      $fsdbAutoSwitchDumpfile(2048, wave_name, 10, log_path);
      $fsdbDumpvarsToFile(scop_path);
      if(dump_mda == 1) begin
        $fsdbDumpMDA();
      end
      $fsdbDumpon;
      $fsdbDumpflush;
      if(dump_begin < dump_end) begin
        #(dump_end - dump_begin);
        $fsdbDumpoff;
        $fsdbDumpFinish;
      end
    end
    //vcd
    else if(wave_type == "vcd") begin
      $vcdpluson();
    end
  end
endmodule:dump_wave

`endif