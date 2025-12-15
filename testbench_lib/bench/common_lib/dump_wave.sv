`ifndef DUMP_WAVE_SV
`define DUMP_WAVE_SV

module automatic dump_wave();
  //only fsdb can set param and begin end time
  bit[63:0] dump_begin = 'h0;
  bit[63:0] dump_end   = 'h0;
  int dump_deep        = 'd0;
  int scope_fd         =   0;
  //se dump wave file name fix here 
  string wave_type     = "";
  string wava_path     ="./wave.fsdb";
  string scop_path     ="./dump_scope.txt";
  string scop_heri     ="test_top";

  initial begin 
    //get set from sim_option
    $value$plusargs("wave=%s", wave_type);
    $value$plusargs("dump_begin=%d", dump_begin);
    $value$plusargs("dump_end=%d", dump_end);
    $value$plusargs("dump_deep=%d", dump_deep);
    $value$plusargs("scop_heri=%s", scop_heri);
    //fsdb
    if(wave_type == "fsdb") begin
      scope_fd = $fopen(scop_path, "w+");
      if(scope_fd) begin
        $fwrite(scope_fd, "%0d %s", dump_deep, scop_heri);
        $fclose(scope_fd);
      end
      else begin
        $display("write dump scope file failed!");
        $finish;
      end
      #dump_begin;
      // $fsdbDumpfile(“file_name.fsdb”); //set wavafile name
      $fsdbAutoSwitchDumpfile(2048, wava_path, 10, "fsdb.log");
      $fsdbDumpvarsToFile(scop_path);
      // $fsdbDumpvars(0);
      $fsdbDumpon;
      $fsdbDumpflush;
      if(dump_begin < dump_end) begin
        #(dump_end - dump_begin);
        $fsdbDumpoff;
        $fsdbDumpFinish;
      end
    end
    //vpd
    if(wave_type == "vpd") begin
      $vcdpluson();
    end
  end
endmodule:dump_wave

`endif