
module bp_parallel_serial_converter
 #(parameter in_width_p = "inv"
  ,parameter out_width_p = "inv"
  )
  (input clk_i
  ,input reset_i

  ,input                    v_i
  ,input [in_width_p-1:0]   data_i
  ,output                   ready_o

  ,output                   v_o
  ,output [out_width_p-1:0] data_o
  ,input                    yumi_i
  );

  localparam is_piso_lp = (in_width_p > out_width_p);
  localparam is_sipo_lp = (in_width_p < out_width_p);

  // synopsys translate_off
  initial begin
    if(is_piso_lp)
      assert(in_width_p % out_width_p == 0)
      else $fatal("in_width_p(%d) %% out_width_p(%d) != 0", in_width_p, out_width_p);

    if(is_sipo_lp)
      assert(out_width_p % in_width_p == 0)
      else $fatal("out_width_p(%d) %% in_width_p(%d) != 0", out_width_p, in_width_p);
  end
  // synopsys translate_on

  if(is_piso_lp) begin: piso
    bsg_parallel_in_serial_out
   #(.width_p(out_width_p)
    ,.els_p  (in_width_p/out_width_p)
    ) piso
    (.clk_i      (clk_i)
    ,.reset_i    (reset_i)
    ,.valid_i    (v_i)
    ,.data_i     (data_i)
    ,.ready_and_o(ready_o)
    ,.valid_o    (v_o)
    ,.data_o     (data_o)
    ,.yumi_i     (yumi_i)
    );
  end
  else if(is_sipo_lp) begin: sipo
    bsg_serial_in_parallel_out_full
   #(.width_p(in_width_p)
    ,.els_p  (out_width_p/in_width_p)
    ) sipo
    (.clk_i  (clk_i)
    ,.reset_i(reset_i)
    ,.v_i    (v_i)
    ,.data_i (data_i)
    ,.ready_o(ready_o)
    ,.v_o    (v_o)
    ,.data_o (data_o)
    ,.yumi_i (yumi_i)
    );
  end
  else begin: passthrough
    assign ready_o = ~(v_o & ~yumi_i);
    assign v_o = v_i;
    assign data_o = data_i;
  end

endmodule;
