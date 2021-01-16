/**
 * bp_me_cce_to_wormhole_link_master.v
 */
 
`include "bp_mem_wormhole.svh"

module bp_burst_to_xui
 import bp_common_pkg::*;
 import bp_common_aviary_pkg::*;
 import bp_me_pkg::*;
 import bsg_dmc_pkg::*;
 #(parameter bp_params_e bp_params_p = e_bp_default_cfg
   `declare_bp_proc_params(bp_params_p)
   `declare_bp_bedrock_mem_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce)

  , localparam max_burst_length_lp = cce_block_width_p / dword_width_p
  , localparam lg_max_burst_length_lp = `BSG_SAFE_CLOG2(max_burst_length_lp)
  )
  (input                                      clk_i
   , input                                    reset_i

   , input [cce_mem_msg_header_width_lp-1:0]  mem_cmd_header_i
   , input                                    mem_cmd_header_v_i
   , output                                   mem_cmd_header_ready_o

   , input [dword_width_p-1:0]                mem_cmd_data_i
   , input                                    mem_cmd_data_v_i
   , output                                   mem_cmd_data_ready_o

   , output [cce_mem_msg_header_width_lp-1:0] mem_resp_header_o
   , output                                   mem_resp_header_v_o
   , input                                    mem_resp_header_yumi_i

   , output [dword_width_p-1:0]               mem_resp_data_o
   , output                                   mem_resp_data_v_o
   , input                                    mem_resp_data_yumi_i

   // xilinx user interface
   , output [paddr_width_p-1:0]               app_addr_o
   , output app_cmd_e                         app_cmd_o
   , output                                   app_en_o
   , input                                    app_rdy_i
   , output                                   app_wdf_wren_o
   , output [dword_width_p-1:0]               app_wdf_data_o
   , output [(dword_width_p>>3)-1:0]          app_wdf_mask_o
   , output                                   app_wdf_end_o
   , input                                    app_wdf_rdy_i
   , input                                    app_rd_data_valid_i
   , input [dword_width_p-1:0]                app_rd_data_i
   , input                                    app_rd_data_end_i
   );
  
// CCE-MEM interface packets
`declare_bp_bedrock_mem_if(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce);

bp_bedrock_cce_mem_msg_header_s mem_cmd_header_li, mem_resp_header_lo; 

logic header_sent_r, app_en_sent_r, wr_burst_done_r;
logic header_v_lo, header_yumi_li, header_ready_lo;
logic [lg_max_burst_length_lp-1:0] cnt_r, cnt_last;

wire is_rd = (mem_resp_header_lo.msg_type inside {e_bedrock_mem_uc_rd, e_bedrock_mem_rd});

assign mem_cmd_header_li = mem_cmd_header_i;
assign mem_resp_header_o = mem_resp_header_lo;

assign mem_cmd_header_ready_o = ~reset_i & header_ready_lo;
assign mem_cmd_data_ready_o = ~reset_i & ~is_rd & app_wdf_rdy_i & app_en_sent_r & ~wr_burst_done_r;

assign app_addr_o      = mem_resp_header_lo.addr;
assign app_cmd_o       = app_cmd_e'(is_rd);
assign app_en_o        = ~app_en_sent_r & header_v_lo & app_rdy_i;

assign app_wdf_wren_o  = (mem_cmd_data_v_i & mem_cmd_data_ready_o) | (wr_burst_done_r & app_wdf_rdy_i);
assign app_wdf_data_o  = (cnt_r > cnt_last) ? '0 : mem_cmd_data_i;
assign app_wdf_mask_o  = (cnt_r > cnt_last) ? {(dword_width_p>>3){1'b1}} : '0;
assign app_wdf_end_o   = app_wdf_wren_o & (cnt_r == (max_burst_length_lp-1));

assign mem_resp_data_v_o = ~reset_i & app_rd_data_valid_i & (cnt_r <= cnt_last);
assign mem_resp_data_o = app_rd_data_i;

assign mem_resp_header_v_o = ~reset_i & header_v_lo & ~header_sent_r;

// fix end shit

assign header_yumi_li = is_rd ? mem_resp_data_yumi_i & (cnt_r == cnt_last) : app_wdf_end_o;

bsg_one_fifo
 #(.width_p($bits(bp_bedrock_cce_mem_msg_header_s))
  ) 
  header_fifo
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.v_i    (mem_cmd_header_v_i & mem_cmd_header_ready_o)
  ,.data_i (mem_cmd_header_li)
  ,.ready_o(header_ready_lo)
  ,.v_o    (header_v_lo)
  ,.data_o (mem_resp_header_lo)
  ,.yumi_i (header_yumi_li)
  );

assign cnt_last = ((1 << mem_resp_header_lo.size) < (dword_width_p >> 3)) ? 0
                : (((1 << mem_resp_header_lo.size) >> `BSG_SAFE_CLOG2(dword_width_p >> 3)) - 1);

bsg_counter_clear_up
 #(.max_val_p(max_burst_length_lp)
  ,.init_val_p(0)
  )
  req_counter
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.clear_i(mem_cmd_header_v_i & mem_cmd_header_ready_o)
  ,.up_i   (is_rd ? app_rd_data_valid_i : app_wdf_wren_o)
  ,.count_o(cnt_r)
  );

bsg_dff_reset_set_clear
 #(.width_p(1)
  )
  resp_header_reg
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.clear_i(header_yumi_li)
  ,.set_i  (mem_resp_header_yumi_i)
  ,.data_o (header_sent_r)
  );

bsg_dff_reset_set_clear
 #(.width_p(1)
  )
  app_en_reg
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.clear_i(header_yumi_li)
  ,.set_i  (app_en_o & app_rdy_i)
  ,.data_o (app_en_sent_r)
  );

bsg_dff_reset_set_clear
 #(.width_p(1)
  )
  wr_burst_reg
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.clear_i(header_yumi_li)
  ,.set_i  (app_wdf_wren_o & (cnt_r == cnt_last) & ~app_wdf_end_o)
  ,.data_o (wr_burst_done_r)
  );

endmodule
