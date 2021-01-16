
module bp_burst_to_dram

  import bp_common_pkg::*;
  import bp_common_aviary_pkg::*;
  import bp_me_pkg::*;

 #(parameter bp_params_e bp_params_p = e_bp_default_cfg
  `declare_bp_proc_params(bp_params_p)
  `declare_bp_bedrock_mem_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce)
  , parameter channel_addr_width_p = "inv"
  , parameter data_width_p = "inv"
  , parameter dram_base_p = "inv"
  , parameter cmd_fifo_els_p = "inv"
  , parameter async_fifo_els_p = 0
  , parameter bypass_async_fifos_p = 0

  , localparam write_mask_width_lp = (data_width_p>>3)
  , localparam byte_offset_width_lp =`BSG_SAFE_CLOG2(data_width_p>>3)
  , localparam block_size_in_words_lp = cce_block_width_p / data_width_p
  , localparam lg_block_size_in_words_lp = `BSG_SAFE_CLOG2(block_size_in_words_lp)
  , localparam max_burst_length_lp = cce_block_width_p / dword_width_p
  , localparam lg_max_burst_length_lp = `BSG_SAFE_CLOG2(max_burst_length_lp)
  , localparam reorder_fifo_els_lp = cmd_fifo_els_p * block_size_in_words_lp
  , localparam lg_reorder_fifo_els_lp = `BSG_SAFE_CLOG2(reorder_fifo_els_lp)
  , localparam lg_async_fifo_els_p = bypass_async_fifos_p ? 2 : `BSG_SAFE_CLOG2(async_fifo_els_p)
  )

  (
   // Core Side
   input                                           clk_i
  ,input                                           reset_i

  ,input [cce_mem_msg_header_width_lp-1:0]         mem_cmd_header_i
  ,input                                           mem_cmd_header_v_i
  ,output logic                                    mem_cmd_header_ready_o

  ,input [dword_width_p-1:0]                       mem_cmd_data_i
  ,input                                           mem_cmd_data_v_i
  ,output logic                                    mem_cmd_data_ready_o

  ,output logic [cce_mem_msg_header_width_lp-1:0]  mem_resp_header_o
  ,output logic                                    mem_resp_header_v_o
  ,input                                           mem_resp_header_yumi_i

  ,output logic [dword_width_p-1:0]                mem_resp_data_o
  ,output logic                                    mem_resp_data_v_o
  ,input                                           mem_resp_data_yumi_i

  // DRAM Side
  ,input                                           dram_clk_i
  ,input                                           dram_reset_i

  ,output       [channel_addr_width_p-1:0]         dram_ch_addr_o
  ,output                                          dram_write_not_read_o
  ,output                                          dram_v_o
  ,input                                           dram_yumi_i

  ,output       [data_width_p-1:0]                 dram_data_o
  ,output       [write_mask_width_lp-1:0]          dram_mask_o
  ,output                                          dram_data_v_o
  ,input                                           dram_data_yumi_i

  ,input        [data_width_p-1:0]                 dram_data_i
  ,input        [channel_addr_width_p-1:0]         dram_ch_addr_i
  ,input                                           dram_data_v_i
  ,output                                          dram_data_ready_o
  );

  /********************* Packet definition *********************/

  `declare_bp_bedrock_mem_if(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce);
  bp_bedrock_cce_mem_msg_header_s mem_cmd_header_li, mem_resp_header_lo;

  /********************* Resp queue fifo *********************/

  // Stores CCE packet header information
  logic cmd_queue_v_li, cmd_queue_ready_lo;
  logic cmd_queue_v_lo, cmd_queue_yumi_li;

  bsg_fifo_1r1w_small
 #(.width_p($bits(bp_bedrock_cce_mem_msg_header_s))
  ,.els_p  (cmd_fifo_els_p)
  ) cmd_queue
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.ready_o(cmd_queue_ready_lo)
  ,.data_i (mem_cmd_header_li)
  ,.v_i    (cmd_queue_v_li)
  ,.v_o    (cmd_queue_v_lo)
  ,.data_o (mem_resp_header_lo)
  ,.yumi_i (cmd_queue_yumi_li)
  );

  /********************* core -> dram *********************/

  // req FIFO
  logic req_header_v_li, req_header_v_lo, req_header_ready_lo, req_header_yumi_li;
  logic req_w_v_li, req_w_v_lo;
  logic [channel_addr_width_p-1:0] req_addr_li, req_addr_lo;
  bp_bedrock_msg_size_e req_size_li, req_size_lo;

  // req async FIFO
  logic req_afifo_full_lo;

  // req burst control
  logic req_v_lo, req_yumi_li, req_burst_done_li, wr_req_burst_done_r;
  logic [lg_block_size_in_words_lp-1:0] req_cnt_r, req_cnt_last;
  logic [channel_addr_width_p-1:0] req_word_addr_lo;

  // wdata and wmask converter
  logic cmd_wdata_v_li, cmd_wdata_ready_lo;
  logic [dword_width_p-1:0] cmd_wdata_li;
  logic [(dword_width_p >> 3)-1:0] cmd_wmask_li;
  logic wdata_v_lo, wdata_yumi_li;
  logic [data_width_p-1:0] wdata_lo;
  logic [write_mask_width_lp-1:0] wmask_lo;

  // req wdata and wmask async FIFO
  logic req_data_afifo_full_lo;

  // rdata converter
  logic rdata_v_li, rdata_ready_lo;
  logic [data_width_p-1:0] rdata_li;
  logic resp_rdata_v_lo, resp_rdata_yumi_li;
  logic [dword_width_p-1:0] resp_rdata_lo;

  // resp async FIFO
  logic resp_v_lo, resp_deq_li, resp_full_lo;
  logic [data_width_p-1:0] resp_data_lo;
  logic [channel_addr_width_p-1:0] resp_ch_addr_lo;

  // data reorder FIFO
  logic alloc_id_v_lo, alloc_id_yumi_li;
  logic [lg_reorder_fifo_els_lp-1:0] alloc_id_lo;

  // reordering CAM
  logic cam_w_set_not_clear_i;
  logic [reorder_fifo_els_lp-1:0] cam_w_v_li, resp_id_match_lo, resp_id_dec_lo;
  logic [channel_addr_width_p-1:0] cam_w_tag_li;

  // alloc id decoder
  logic [reorder_fifo_els_lp-1:0] alloc_id_dec_lo;

  // resp id encoder
  logic resp_id_v_lo;
  logic [lg_reorder_fifo_els_lp-1:0] resp_id_lo;

  // resp burst control
  logic rd_resp, rd_resp_burst_done, rd_resp_header_sent;
  logic [lg_max_burst_length_lp-1:0] resp_cnt_r, resp_cnt_last;

  // input mem cmd
  assign mem_cmd_header_li = mem_cmd_header_i;
  assign mem_cmd_header_ready_o = ~reset_i & ~dram_reset_i & cmd_queue_ready_lo & req_header_ready_lo;
  assign mem_cmd_data_ready_o = ~reset_i & ~dram_reset_i & cmd_wdata_ready_lo & (req_header_v_lo & req_w_v_lo); 

  // cmd queue
  assign cmd_queue_v_li = mem_cmd_header_v_i & mem_cmd_header_ready_o;

  // address channel
  assign req_header_v_li = mem_cmd_header_v_i & mem_cmd_header_ready_o;
  assign req_w_v_li = (mem_cmd_header_li.msg_type.mem inside {e_bedrock_mem_uc_wr, e_bedrock_mem_wr});
  assign req_size_li = mem_cmd_header_li.size;
  assign req_addr_li = (mem_cmd_header_li.addr - dram_base_p) & ({channel_addr_width_p{1'b1}} << byte_offset_width_lp);
  assign req_header_yumi_li = req_w_v_lo ? mem_resp_header_yumi_i : req_burst_done_li;

  // Cannot send read requests when receiving data
  assign req_v_lo = req_header_v_lo & (req_w_v_lo ? wdata_v_lo : ~resp_deq_li);
  assign req_yumi_li = req_v_lo & ~req_afifo_full_lo;
  assign req_word_addr_lo = req_addr_lo + (req_cnt_r << byte_offset_width_lp);
  assign req_cnt_last = ((1 << req_size_lo) < write_mask_width_lp) ? 0 : (((1 << req_size_lo) >> byte_offset_width_lp) - 1);
  assign req_burst_done_li = req_yumi_li & (req_cnt_r == req_cnt_last);

  // data channel
  assign cmd_wdata_v_li = mem_cmd_data_v_i & mem_cmd_data_ready_o;
  assign cmd_wdata_li = mem_cmd_data_i << cce_block_width_p'(req_addr_lo[0+:byte_offset_width_lp] << 3);
  assign cmd_wmask_li = ((1 << (1 << req_size_lo)) - 1) << req_addr_lo[0+:byte_offset_width_lp];
  assign wdata_yumi_li = wdata_v_lo & ~req_data_afifo_full_lo;

  // resp async FIFO
  assign resp_deq_li = ~reset_i & ~dram_reset_i & resp_v_lo;

  // CAM (id -> address)
  // Write on sending read requests
  // Clear on receiving read data
  assign cam_w_v_li = alloc_id_yumi_li
                      ? alloc_id_dec_lo
                      : resp_deq_li
                        ? resp_id_dec_lo
                        : '0;
  assign cam_w_set_not_clear_i = alloc_id_yumi_li;
  assign cam_w_tag_li = req_word_addr_lo;

  // reorder FIFO
  // Allocate an id to each read request
  assign alloc_id_yumi_li = req_yumi_li & ~req_w_v_lo;

  // data sipo
  assign resp_rdata_yumi_li = mem_resp_data_yumi_i;

  // resp burst control
  assign rd_resp = mem_resp_header_lo.msg_type.mem inside {e_bedrock_mem_uc_rd, e_bedrock_mem_rd};
  assign rd_resp_burst_done = mem_resp_data_yumi_i & (resp_cnt_r == resp_cnt_last);
  assign resp_cnt_last = ((1 << mem_resp_header_lo.size) < (dword_width_p >> 3)) ? 0
                         : (((1 << mem_resp_header_lo.size) >> `BSG_SAFE_CLOG2(dword_width_p >> 3)) - 1);

  // cmd queue
  assign cmd_queue_yumi_li = rd_resp ? rd_resp_burst_done : (mem_resp_header_v_o & mem_resp_header_yumi_i);

  // mem resp output
  assign mem_resp_header_v_o = rd_resp ? (cmd_queue_v_lo & ~rd_resp_header_sent) : (cmd_queue_v_lo & wr_req_burst_done_r);
  assign mem_resp_header_o = mem_resp_header_lo;

  assign mem_resp_data_v_o = resp_rdata_v_lo & rd_resp_header_sent;
  assign mem_resp_data_o = resp_rdata_lo;

  // resp data
  assign dram_data_ready_o = ~reset_i & ~dram_reset_i & ~resp_full_lo;

  /********************* Req Channel *********************/
  bsg_one_fifo
 #(.width_p(1+$bits(bp_bedrock_msg_size_e)+channel_addr_width_p)
  ) req_one_fifo
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.ready_o(req_header_ready_lo)
  ,.data_i ({req_w_v_li, req_size_li, req_addr_li})
  ,.v_i    (req_header_v_li)
  ,.v_o    (req_header_v_lo)
  ,.data_o ({req_w_v_lo, req_size_lo, req_addr_lo})
  ,.yumi_i (req_header_yumi_li)
  );

if(bypass_async_fifos_p == 0) begin
  bsg_async_fifo
  #(.lg_size_p(lg_async_fifo_els_p)
    ,.width_p(1+channel_addr_width_p)
  ) req_afifo (
    .w_clk_i(clk_i)
    ,.w_reset_i(reset_i)
    ,.w_enq_i(req_yumi_li)
    ,.w_data_i({req_w_v_lo, req_word_addr_lo})
    ,.w_full_o(req_afifo_full_lo)

    ,.r_clk_i(dram_clk_i)
    ,.r_reset_i(dram_reset_i)
    ,.r_deq_i(dram_yumi_i)
    ,.r_data_o({dram_write_not_read_o, dram_ch_addr_o})
    ,.r_valid_o(dram_v_o)
  );
end else begin
  assign {dram_v_o, dram_write_not_read_o, dram_ch_addr_o} = {req_v_lo, req_w_v_lo, req_word_addr_lo};
  assign req_afifo_full_lo = dram_v_o & ~dram_yumi_i;
end

  bsg_counter_clear_up
 #(.max_val_p(block_size_in_words_lp-1)
  ,.init_val_p(0)
  ) req_counter
  (.clk_i(clk_i)
  ,.reset_i(reset_i)
  ,.clear_i(req_burst_done_li)
  ,.up_i(req_yumi_li & ~req_burst_done_li)
  ,.count_o(req_cnt_r)
  );

  bp_parallel_serial_converter
 #(.in_width_p(dword_width_p)
  ,.out_width_p(data_width_p)
  ) wdata_converter
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.v_i    (cmd_wdata_v_li)
  ,.data_i (cmd_wdata_li)
  ,.ready_o(cmd_wdata_ready_lo)
  ,.v_o    (wdata_v_lo)
  ,.data_o (wdata_lo)
  ,.yumi_i (wdata_yumi_li)
  );

  bp_parallel_serial_converter
 #(.in_width_p(dword_width_p>>3)
  ,.out_width_p(write_mask_width_lp)
  ) wmask_converter
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.v_i    (cmd_wdata_v_li)
  ,.data_i (cmd_wmask_li)
  ,.ready_o()
  ,.v_o    ()
  ,.data_o (wmask_lo)
  ,.yumi_i (wdata_yumi_li)
  );

if(bypass_async_fifos_p == 0) begin
  bsg_async_fifo
  #(.lg_size_p(lg_async_fifo_els_p)
    ,.width_p(write_mask_width_lp+data_width_p)
  ) req_data_afifo (
    .w_clk_i(clk_i)
    ,.w_reset_i(reset_i)
    ,.w_enq_i(wdata_yumi_li)
    ,.w_data_i({wmask_lo, wdata_lo})
    ,.w_full_o(req_data_afifo_full_lo)

    ,.r_clk_i(dram_clk_i)
    ,.r_reset_i(dram_reset_i)
    ,.r_deq_i(dram_data_yumi_i)
    ,.r_data_o({dram_mask_o, dram_data_o})
    ,.r_valid_o(dram_data_v_o)
  );
end else begin
  assign {dram_data_v_o, dram_mask_o, dram_data_o} = {wdata_v_lo, wmask_lo, wdata_lo};
  assign req_data_afifo_full_lo = dram_data_v_o & ~dram_data_yumi_i;
end

  /********************* Resp Channel *********************/
if(bypass_async_fifos_p == 0) begin
  bsg_async_fifo
  #(.lg_size_p(lg_async_fifo_els_p)
    ,.width_p(channel_addr_width_p+data_width_p)
  ) resp_afifo (
    .w_clk_i(dram_clk_i)
    ,.w_reset_i(dram_reset_i)
    ,.w_enq_i(dram_data_v_i)
    ,.w_data_i({dram_ch_addr_i, dram_data_i})
    ,.w_full_o(resp_full_lo)

    ,.r_clk_i(clk_i)
    ,.r_reset_i(reset_i)
    ,.r_deq_i(resp_deq_li)
    ,.r_data_o({resp_ch_addr_lo, resp_data_lo})
    ,.r_valid_o(resp_v_lo)
  );
end else begin
  assign {resp_v_lo, resp_ch_addr_lo, resp_data_lo} = {dram_data_v_i, dram_ch_addr_i, dram_data_i};
  assign resp_full_lo = 1'b0; 
end

  bsg_cam_1r1w_tag_array
 #(.els_p(reorder_fifo_els_lp)
  ,.width_p(channel_addr_width_p)
  ,.multiple_entries_p(1)
  ) id_cam
  (.clk_i(clk_i)
  ,.reset_i(reset_i)

  ,.w_v_i(cam_w_v_li)
  ,.w_set_not_clear_i(cam_w_set_not_clear_i)
  ,.w_tag_i(cam_w_tag_li)
  ,.w_empty_o()

  ,.r_v_i(resp_deq_li)
  ,.r_tag_i(resp_ch_addr_lo)
  ,.r_match_o(resp_id_match_lo)
  );

if(reorder_fifo_els_lp == 1) begin
  assign resp_id_lo = 1'b0;
  assign resp_id_v_lo = resp_id_match_lo;
  assign resp_id_dec_lo = resp_id_match_lo;
end
else begin
  bsg_priority_encode
 #(.width_p(reorder_fifo_els_lp)
   ,.lo_to_hi_p(1)
  ) resp_id_enc
  (.i(resp_id_match_lo)
  ,.addr_o(resp_id_lo)
  ,.v_o(resp_id_v_lo)
  );

  bsg_decode
 #(.num_out_p(reorder_fifo_els_lp)
  ) resp_id_dec
  (.i(resp_id_lo)
  ,.o(resp_id_dec_lo)
  );
end

  bsg_decode
 #(.num_out_p(reorder_fifo_els_lp)
  ) alloc_id_dec
  (.i(alloc_id_lo)
  ,.o(alloc_id_dec_lo)
  );

  bsg_fifo_reorder
 #(.width_p(data_width_p)
  ,.els_p(reorder_fifo_els_lp)
  ) reorder_fifo
  (.clk_i(clk_i)
  ,.reset_i(reset_i)

  ,.fifo_alloc_v_o(alloc_id_v_lo)
  ,.fifo_alloc_id_o(alloc_id_lo)
  ,.fifo_alloc_yumi_i(alloc_id_yumi_li)

  ,.write_v_i(resp_id_v_lo)
  ,.write_id_i(resp_id_lo)
  ,.write_data_i(resp_data_lo)

  ,.fifo_deq_v_o(rdata_v_li)
  ,.fifo_deq_data_o(rdata_li)
  ,.fifo_deq_yumi_i(rdata_v_li & rdata_ready_lo)

  ,.empty_o()
  );

  bp_parallel_serial_converter
 #(.in_width_p(data_width_p)
  ,.out_width_p(dword_width_p)
  ) rdata_converter
  (.clk_i  (clk_i)
  ,.reset_i(reset_i)
  ,.v_i    (rdata_v_li)
  ,.ready_o(rdata_ready_lo)
  ,.data_i (rdata_li)
  ,.data_o (resp_rdata_lo)
  ,.v_o    (resp_rdata_v_lo)
  ,.yumi_i (resp_rdata_yumi_li)
  );

  bsg_counter_clear_up
 #(.max_val_p(max_burst_length_lp-1)
  ,.init_val_p(0)
  ) resp_counter
  (.clk_i(clk_i)
  ,.reset_i(reset_i)
  ,.clear_i(rd_resp_burst_done)
  ,.up_i(resp_rdata_yumi_li & ~rd_resp_burst_done)
  ,.count_o(resp_cnt_r)
  );

  bsg_dff_reset_set_clear
 #(.width_p(1)
  ) resp_header_reg
  (.clk_i(clk_i)
  ,.reset_i(reset_i)
  ,.set_i(mem_resp_header_yumi_i & rd_resp)
  ,.clear_i(rd_resp_burst_done)
  ,.data_o(rd_resp_header_sent)
  );

  bsg_dff_reset_set_clear
 #(.width_p(1)
  ) req_burst_reg
  (.clk_i(clk_i)
  ,.reset_i(reset_i)
  ,.set_i(req_burst_done_li & req_w_v_lo)
  ,.clear_i(req_header_v_li & req_w_v_li)
  ,.data_o(wr_req_burst_done_r)
  );

/*
  logic [cce_block_width_p-1:0] dma_data_packed_lo;
  bsg_bus_pack
   #(.width_p(cce_block_width_p))
   pack
    (.data_i(resp_rdata_lo)
     ,.sel_i(mem_resp_lo.header.addr[0+:`BSG_SAFE_CLOG2(cce_block_width_p/8)])
     ,.size_i(mem_resp_lo.header.size)
     ,.data_o(dma_data_packed_lo)
     );
*/

endmodule
