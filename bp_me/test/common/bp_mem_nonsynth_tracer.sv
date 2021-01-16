
/**
 * bp_mem_nonsynth_tracer.v
 */

module bp_mem_nonsynth_tracer
  import bp_common_pkg::*;
  import bp_common_aviary_pkg::*;
  import bp_me_pkg::*;
  #(parameter bp_params_e bp_params_p = e_bp_default_cfg
   `declare_bp_proc_params(bp_params_p)
    `declare_bp_bedrock_mem_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce)

   , parameter trace_file_p = "dram.trace"
   )
  (input                                 clk_i
   , input                               reset_i

   , input [cce_mem_msg_header_width_lp-1:0]        mem_cmd_header_i
   , input                                          mem_cmd_header_v_i
   , input                                          mem_cmd_header_ready_i

   , input [dword_width_p-1:0]                      mem_cmd_data_i
   , input                                          mem_cmd_data_v_i
   , input                                          mem_cmd_data_ready_i

   , input [cce_mem_msg_header_width_lp-1:0]        mem_resp_header_i
   , input                                          mem_resp_header_v_i
   , input                                          mem_resp_header_yumi_i

   , input [dword_width_p-1:0]                      mem_resp_data_i
   , input                                          mem_resp_data_v_i
   , input                                          mem_resp_data_yumi_i
   );

`declare_bp_bedrock_mem_if(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce);

wire unused = &{mem_resp_header_v_i, mem_resp_data_v_i};

integer file;
always_ff @(negedge reset_i) begin
  file = $fopen(trace_file_p, "w");
end

bp_bedrock_cce_mem_msg_s mem_cmd_li, mem_resp_li;
logic                    mem_cmd_v_li, mem_resp_v_li;

always_ff @(posedge clk_i) begin
  if (mem_cmd_v_li)
    case (mem_cmd_li.header.msg_type.mem)
      e_bedrock_mem_rd:
        $fwrite(file, "[%t] CMD  RD  : (%x) %b\n", $time, mem_cmd_li.header.addr, mem_cmd_li.header.size);
      e_bedrock_mem_wr:
        $fwrite(file, "[%t] CMD  WR  : (%x) %b %x\n", $time, mem_cmd_li.header.addr, mem_cmd_li.header.size, mem_cmd_li.data);
      e_bedrock_mem_uc_rd:
        $fwrite(file, "[%t] CMD  UCRD: (%x) %b\n", $time, mem_cmd_li.header.addr, mem_cmd_li.header.size);
      e_bedrock_mem_uc_wr:
        $fwrite(file, "[%t] CMD  UCWR: (%x) %b %x\n", $time, mem_cmd_li.header.addr, mem_cmd_li.header.size, mem_cmd_li.data);
      default:
        $fwrite(file, "[%t] CMD  ERROR: unknown cmd_type %x received!", $time, mem_cmd_li.header.msg_type.mem);
    endcase

  if (mem_resp_v_li)
    case (mem_resp_li.header.msg_type.mem)
      e_bedrock_mem_rd:
        $fwrite(file, "[%t] RESP RD  : (%x) %b %x\n", $time, mem_resp_li.header.addr, mem_resp_li.header.size, mem_resp_li.data);
      e_bedrock_mem_wr:
        $fwrite(file, "[%t] RESP WR  : (%x) %b\n", $time, mem_resp_li.header.addr, mem_resp_li.header.size);
      e_bedrock_mem_uc_rd:
        $fwrite(file, "[%t] RESP UCRD: (%x) %b %x\n", $time, mem_resp_li.header.addr, mem_resp_li.header.size, mem_resp_li.data);
      e_bedrock_mem_uc_wr:
        $fwrite(file, "[%t] RESP UCWR: (%x) %b\n", $time, mem_resp_li.header.addr, mem_resp_li.header.size);
      default:
        $fwrite(file, "[%t] ERROR: unknown resp_type %x received!", $time, mem_resp_li.header.msg_type.mem);
    endcase
end

bp_burst_to_lite
 #(.bp_params_p(bp_params_p)
  ,.in_data_width_p(dword_width_p)
  ,.out_data_width_p(cce_block_width_p)
  ,.payload_mask_p(mem_cmd_payload_mask_gp)
  )
  cmd
  (.clk_i(clk_i)
  ,.reset_i(reset_i)

  ,.mem_header_i(mem_cmd_header_i)
  ,.mem_header_v_i(mem_cmd_header_v_i & mem_cmd_header_ready_i)
  ,.mem_header_ready_and_o()

  ,.mem_data_i(mem_cmd_data_i)
  ,.mem_data_v_i(mem_cmd_data_v_i & mem_cmd_data_ready_i)
  ,.mem_data_ready_and_o()

  ,.mem_o(mem_cmd_li)
  ,.mem_v_o(mem_cmd_v_li)
  ,.mem_ready_and_i(1'b1)
  );

bp_burst_to_lite
 #(.bp_params_p(bp_params_p)
  ,.in_data_width_p(dword_width_p)
  ,.out_data_width_p(cce_block_width_p)
  ,.payload_mask_p(mem_resp_payload_mask_gp)
  )
  resp
  (.clk_i(clk_i)
  ,.reset_i(reset_i)

  ,.mem_header_i(mem_resp_header_i)
  ,.mem_header_v_i(mem_resp_header_yumi_i)
  ,.mem_header_ready_and_o()

  ,.mem_data_i(mem_resp_data_i)
  ,.mem_data_v_i(mem_resp_data_yumi_i)
  ,.mem_data_ready_and_o()

  ,.mem_o(mem_resp_li)
  ,.mem_v_o(mem_resp_v_li)
  ,.mem_ready_and_i(1'b1)
  );


endmodule

