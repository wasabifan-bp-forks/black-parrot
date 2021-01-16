
/**
 * bp_mem.v
 */

// Set default DRAM package
`ifndef dram_pkg
`define dram_pkg bsg_dramsim2_hmb2_4gb_x128_pkg
`endif

module bp_mem
  import bp_common_pkg::*;
  import bp_common_aviary_pkg::*;
  import bp_me_pkg::*;
  #(parameter bp_params_e bp_params_p = e_bp_default_cfg
   `declare_bp_proc_params(bp_params_p)
   `declare_bp_bedrock_mem_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce)

   , parameter mem_offset_p         = 0
   , parameter mem_cap_in_bytes_p   = "inv"
   , parameter mem_load_p           = 0
   , parameter mem_file_p           = "inv"
   , parameter use_ddr_p            = 0
   , parameter use_dramsim3_p       = 0
   , parameter dram_fixed_latency_p = 0
   )
  (input                                            clk_i
   , input                                          reset_i

   , input                                          dram_clk_i
   , input                                          dram_reset_i

   // BP side
   // ready->valid (ready then valid)
   , input [cce_mem_msg_header_width_lp-1:0]        mem_cmd_header_i
   , input                                          mem_cmd_header_v_i
   , output logic                                   mem_cmd_header_ready_o

   , input [dword_width_p-1:0]                      mem_cmd_data_i
   , input                                          mem_cmd_data_v_i
   , output logic                                   mem_cmd_data_ready_o

   , output logic [cce_mem_msg_header_width_lp-1:0] mem_resp_header_o
   , output logic                                   mem_resp_header_v_o
   , input                                          mem_resp_header_yumi_i

   , output logic [dword_width_p-1:0]               mem_resp_data_o
   , output logic                                   mem_resp_data_v_o
   , input                                          mem_resp_data_yumi_i
   );

if(use_ddr_p) begin: ddr

  bp_ddr
   #(.bp_params_p(bp_params_p)
    ,.mem_offset_p(mem_offset_p)
    )
    ddr
    (.clk_i(clk_i)
    ,.reset_i(reset_i)

    ,.mem_cmd_header_i(mem_cmd_header_i)
    ,.mem_cmd_header_v_i(mem_cmd_header_v_i)
    ,.mem_cmd_header_ready_o(mem_cmd_header_ready_o)

    ,.mem_cmd_data_i(mem_cmd_data_i)
    ,.mem_cmd_data_v_i(mem_cmd_data_v_i)
    ,.mem_cmd_data_ready_o(mem_cmd_data_ready_o)

    ,.mem_resp_header_o(mem_resp_header_o)
    ,.mem_resp_header_v_o(mem_resp_header_v_o)
    ,.mem_resp_header_yumi_i(mem_resp_header_yumi_i)

    ,.mem_resp_data_o(mem_resp_data_o)
    ,.mem_resp_data_v_o(mem_resp_data_v_o)
    ,.mem_resp_data_yumi_i(mem_resp_data_yumi_i)
    );

  if (mem_load_p) $fatal("Preloading is not current supported in DDR model");
end
else if(use_dramsim3_p) begin: dramsim3

  logic [`dram_pkg::num_channels_p-1:0] dram_v_li, dram_w_li, dram_data_v_li, dram_data_v_lo;
  logic [`dram_pkg::num_channels_p-1:0] dram_yumi_lo, dram_data_yumi_lo;
  logic [`dram_pkg::num_channels_p-1:0][`dram_pkg::channel_addr_width_p-1:0] dram_ch_addr_li, dram_read_done_ch_addr_lo;
  logic [`dram_pkg::num_channels_p-1:0][`dram_pkg::data_width_p-1:0] dram_data_li, dram_data_lo;
  logic [`dram_pkg::num_channels_p-1:0][(`dram_pkg::data_width_p >> 3)-1:0] dram_mask_li;

  genvar i;
  for (i=1; i<`dram_pkg::num_channels_p; i=i+1) begin
    assign dram_v_li[i] = '0;
    assign dram_w_li[i] = '0;
    assign dram_data_v_li[i] = '0;
  end

  bp_burst_to_dram
    #(.bp_params_p(bp_params_p)
      ,.channel_addr_width_p(`dram_pkg::channel_addr_width_p)
      ,.data_width_p(`dram_pkg::data_width_p)
      ,.dram_base_p(mem_offset_p)
      ,.cmd_fifo_els_p(16)
      ,.async_fifo_els_p(16)
     )
    mem2dram
     (.clk_i(clk_i)
      ,.reset_i(reset_i)

      ,.mem_cmd_header_i(mem_cmd_header_i)
      ,.mem_cmd_header_v_i(mem_cmd_header_v_i)
      ,.mem_cmd_header_ready_o(mem_cmd_header_ready_o)

      ,.mem_cmd_data_i(mem_cmd_data_i)
      ,.mem_cmd_data_v_i(mem_cmd_data_v_i)
      ,.mem_cmd_data_ready_o(mem_cmd_data_ready_o)

      ,.mem_resp_header_o(mem_resp_header_o)
      ,.mem_resp_header_v_o(mem_resp_header_v_o)
      ,.mem_resp_header_yumi_i(mem_resp_header_yumi_i)

      ,.mem_resp_data_o(mem_resp_data_o)
      ,.mem_resp_data_v_o(mem_resp_data_v_o)
      ,.mem_resp_data_yumi_i(mem_resp_data_yumi_i)

      ,.dram_clk_i(dram_clk_i)
      ,.dram_reset_i(dram_reset_i)

      ,.dram_ch_addr_o(dram_ch_addr_li[0])
      ,.dram_write_not_read_o(dram_w_li[0])
      ,.dram_v_o(dram_v_li[0])
      ,.dram_yumi_i(dram_yumi_lo[0])

      ,.dram_data_o(dram_data_li[0])
      ,.dram_mask_o(dram_mask_li[0])
      ,.dram_data_v_o(dram_data_v_li[0])
      ,.dram_data_yumi_i(dram_data_yumi_lo[0])

      ,.dram_data_i(dram_data_lo[0])
      ,.dram_ch_addr_i(dram_read_done_ch_addr_lo[0])
      ,.dram_data_v_i(dram_data_v_lo[0])
      ,.dram_data_ready_o()
     );

  bsg_nonsynth_dramsim3
    #(.channel_addr_width_p(`dram_pkg::channel_addr_width_p)
      ,.data_width_p(`dram_pkg::data_width_p)
      ,.num_channels_p(`dram_pkg::num_channels_p)
      ,.num_columns_p(`dram_pkg::num_columns_p)
      ,.num_rows_p(`dram_pkg::num_rows_p)
      ,.num_ba_p(`dram_pkg::num_ba_p)
      ,.num_bg_p(`dram_pkg::num_bg_p)
      ,.num_ranks_p(`dram_pkg::num_ranks_p)
      ,.address_mapping_p(`dram_pkg::address_mapping_p)
      ,.size_in_bits_p(`dram_pkg::size_in_bits_p)
      ,.config_p(`dram_pkg::config_p)
      ,.masked_p(1)
      ,.debug_p(0)
      ,.init_mem_p(1)
     )
    dram
     (.clk_i(dram_clk_i)
      ,.reset_i(dram_reset_i)

      ,.v_i(dram_v_li)
      ,.write_not_read_i(dram_w_li)
      ,.ch_addr_i(dram_ch_addr_li)
      ,.yumi_o(dram_yumi_lo)

      ,.data_v_i(dram_data_v_li)
      ,.data_i(dram_data_li)
      ,.mask_i(dram_mask_li)
      ,.data_yumi_o(dram_data_yumi_lo)

      ,.data_v_o(dram_data_v_lo)
      ,.data_o(dram_data_lo)
      ,.read_done_ch_addr_o(dram_read_done_ch_addr_lo)

      ,.write_done_o()
      ,.write_done_ch_addr_o()
     );

  localparam mem_els_lp = mem_cap_in_bytes_p / cce_block_width_p;
  localparam lg_mem_els_lp = `BSG_SAFE_CLOG2(mem_els_lp);
  if (mem_load_p)
    begin : preload
      `ifndef VERILATOR
        logic [cce_block_width_p-1:0] mem [0:mem_els_lp];
        always_ff @(negedge reset_i)
          begin
            $readmemh(mem_file_p, mem);
            for (integer i = 0; i < mem_els_lp; i++)
              dram.channels[0].channel.bsg_mem_dma_set(dram.channels[0].channel.memory, i, mem[i]);
          end
      `else
         $fatal("Preloading with Verilator is not current supported, due to the dot references");
      `endif
    end

end
else begin: fixed_latency

  logic dram_v_lo, dram_write_not_read_lo, dram_data_v_lo, dram_data_v_li, mem_data_v_lo;
  logic dram_yumi_li, dram_data_yumi_li, dram_data_ready_lo;
  logic [paddr_width_p-1:0] dram_ch_addr_lo, dram_ch_addr_li, mem_ch_addr_lo;
  logic [dword_width_p-1:0] dram_data_lo, dram_data_li, mem_data_lo;
  logic [(dword_width_p >> 3)-1:0] dram_mask_lo;

  assign dram_yumi_li = dram_v_lo;
  assign dram_data_yumi_li = dram_data_v_lo;

  bsg_shift_reg
    #(.width_p (paddr_width_p+dword_width_p)
     ,.stages_p(dram_fixed_latency_p)
    ) delay_shift_reg
    (.clk    (clk_i)
    ,.reset_i(reset_i)
    ,.valid_i(mem_data_v_lo)
    ,.data_i ({mem_ch_addr_lo, mem_data_lo})
    ,.valid_o(dram_data_v_li)
    ,.data_o ({dram_ch_addr_li, dram_data_li})
    );

  bsg_dff_reset
    #(.width_p(1+paddr_width_p))
    addr_reg
     (.clk_i(clk_i)
      ,.reset_i(reset_i)
      ,.data_i({dram_v_lo, dram_ch_addr_lo})
      ,.data_o({mem_data_v_lo, mem_ch_addr_lo})
     );

  bp_burst_to_dram
    #(.bp_params_p(bp_params_p)
      ,.channel_addr_width_p(paddr_width_p)
      ,.data_width_p(dword_width_p)
      ,.dram_base_p(mem_offset_p)
      ,.cmd_fifo_els_p(16)
      ,.bypass_async_fifos_p(1)
     )
    mem2dram
     (.clk_i(clk_i)
      ,.reset_i(reset_i)

      ,.mem_cmd_header_i(mem_cmd_header_i)
      ,.mem_cmd_header_v_i(mem_cmd_header_v_i)
      ,.mem_cmd_header_ready_o(mem_cmd_header_ready_o)

      ,.mem_cmd_data_i(mem_cmd_data_i)
      ,.mem_cmd_data_v_i(mem_cmd_data_v_i)
      ,.mem_cmd_data_ready_o(mem_cmd_data_ready_o)

      ,.mem_resp_header_o(mem_resp_header_o)
      ,.mem_resp_header_v_o(mem_resp_header_v_o)
      ,.mem_resp_header_yumi_i(mem_resp_header_yumi_i)

      ,.mem_resp_data_o(mem_resp_data_o)
      ,.mem_resp_data_v_o(mem_resp_data_v_o)
      ,.mem_resp_data_yumi_i(mem_resp_data_yumi_i)

      ,.dram_clk_i(clk_i)
      ,.dram_reset_i(reset_i)

      ,.dram_ch_addr_o(dram_ch_addr_lo)
      ,.dram_write_not_read_o(dram_write_not_read_lo)
      ,.dram_v_o(dram_v_lo)
      ,.dram_yumi_i(dram_yumi_li)

      ,.dram_data_o(dram_data_lo)
      ,.dram_mask_o(dram_mask_lo)
      ,.dram_data_v_o(dram_data_v_lo)
      ,.dram_data_yumi_i(dram_data_yumi_li)

      ,.dram_data_i(dram_data_li)
      ,.dram_ch_addr_i(dram_ch_addr_li)
      ,.dram_data_v_i(dram_data_v_li)
      ,.dram_data_ready_o(dram_data_ready_lo)
   );

  localparam mem_els_lp = mem_cap_in_bytes_p / (dword_width_p/8);
  localparam lg_mem_els_lp = `BSG_SAFE_CLOG2(mem_els_lp);
  localparam block_offset_width_lp = `BSG_SAFE_CLOG2(dword_width_p/8);
  bsg_nonsynth_mem_1rw_sync_mask_write_byte_dma
   #(.width_p(dword_width_p)
     ,.els_p(mem_els_lp)
     ,.id_p(0)
     ,.init_mem_p(1)
     )
   dram
    (.clk_i(clk_i)
     ,.reset_i(reset_i)

     ,.v_i(dram_yumi_li)
     ,.w_i(dram_write_not_read_lo)

     ,.addr_i(dram_ch_addr_lo[block_offset_width_lp+:lg_mem_els_lp])
     ,.data_i(dram_data_lo)
     ,.w_mask_i(dram_mask_lo)

     ,.data_o(mem_data_lo)
     );

  if (mem_load_p)
    begin : preload
      `ifndef VERILATOR
        logic [7:0] mem [0:mem_cap_in_bytes_p];
        always_ff @(negedge reset_i)
          begin
            $readmemh(mem_file_p, mem);
            for (integer i = 0; i < mem_cap_in_bytes_p; i++)
              dram.mem.bsg_mem_dma_set(dram.mem.memory, i, mem[i]);
          end
      `else
         $fatal("Preloading with Verilator is not current supported, due to the dot references");
      `endif
    end

end
endmodule
