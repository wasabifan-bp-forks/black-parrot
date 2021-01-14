/**
 *
 * bp_l2e_tile.v
 *
 */

module bp_l2e_tile
 import bp_common_pkg::*;
 import bp_common_aviary_pkg::*;
 import bp_be_pkg::*;
 import bsg_cache_pkg::*;
 import bsg_noc_pkg::*;
 import bsg_wormhole_router_pkg::*;
 import bp_me_pkg::*;
 #(parameter bp_params_e bp_params_p = e_bp_default_cfg
   `declare_bp_proc_params(bp_params_p)
   `declare_bp_bedrock_lce_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, cce_id_width_p, lce_assoc_p, lce)
   `declare_bp_bedrock_mem_if_widths(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce)
   `declare_bp_bedrock_mem_if_widths(paddr_width_p, dword_width_p, lce_id_width_p, lce_assoc_p, xce)

    , localparam cfg_bus_width_lp        = `bp_cfg_bus_width(vaddr_width_p, core_id_width_p, cce_id_width_p, lce_id_width_p, cce_pc_width_p, cce_instr_width_p)
   // Wormhole parameters
   , localparam coh_noc_ral_link_width_lp = `bsg_ready_and_link_sif_width(coh_noc_flit_width_p)
   , localparam mem_noc_ral_link_width_lp = `bsg_ready_and_link_sif_width(mem_noc_flit_width_p)
   )
  (input                                                      clk_i
   , input                                                    reset_i

   // Memory side connection
   , input [io_noc_did_width_p-1:0]                           my_did_i
   , input [coh_noc_cord_width_p-1:0]                         my_cord_i

   , input [coh_noc_ral_link_width_lp-1:0]                    lce_req_link_i
   , output [coh_noc_ral_link_width_lp-1:0]                   lce_req_link_o

   , input [coh_noc_ral_link_width_lp-1:0]                    lce_cmd_link_i
   , output [coh_noc_ral_link_width_lp-1:0]                   lce_cmd_link_o

   , input [coh_noc_ral_link_width_lp-1:0]                    lce_resp_link_i
   , output [coh_noc_ral_link_width_lp-1:0]                   lce_resp_link_o

   , output [mem_noc_ral_link_width_lp-1:0]                   mem_cmd_link_o
   , input [mem_noc_ral_link_width_lp-1:0]                    mem_resp_link_i
   );

  `declare_bp_cfg_bus_s(vaddr_width_p, core_id_width_p, cce_id_width_p, lce_id_width_p, cce_pc_width_p, cce_instr_width_p);
  `declare_bp_bedrock_lce_if(paddr_width_p, cce_block_width_p, lce_id_width_p, cce_id_width_p, lce_assoc_p, lce);
  `declare_bp_bedrock_mem_if(paddr_width_p, cce_block_width_p, lce_id_width_p, lce_assoc_p, cce);
  `declare_bp_bedrock_mem_if(paddr_width_p, dword_width_p, lce_id_width_p, lce_assoc_p, xce);

  // Cast the routing links
  `declare_bsg_ready_and_link_sif_s(coh_noc_flit_width_p, bp_coh_ready_and_link_s);
  `declare_bsg_ready_and_link_sif_s(mem_noc_flit_width_p, bp_mem_ready_and_link_s);

  bp_coh_ready_and_link_s lce_req_link_cast_i, lce_req_link_cast_o;
  bp_coh_ready_and_link_s lce_resp_link_cast_i, lce_resp_link_cast_o;
  bp_coh_ready_and_link_s lce_cmd_link_cast_i, lce_cmd_link_cast_o;

  assign lce_req_link_cast_i  = lce_req_link_i;
  assign lce_cmd_link_cast_i  = lce_cmd_link_i;
  assign lce_resp_link_cast_i = lce_resp_link_i;

  assign lce_req_link_o  = lce_req_link_cast_o;
  assign lce_cmd_link_o  = lce_cmd_link_cast_o;
  assign lce_resp_link_o = lce_resp_link_cast_o;

  // CCE connections
  logic cce_lce_req_header_v, cce_lce_req_header_ready;
  logic cce_lce_req_data_v, cce_lce_req_data_ready;
  logic cce_lce_resp_header_v, cce_lce_resp_header_ready;
  logic cce_lce_resp_data_v, cce_lce_resp_data_ready;
  logic cce_lce_cmd_header_v, cce_lce_cmd_header_ready;
  logic cce_lce_cmd_data_v, cce_lce_cmd_data_ready;
  bp_bedrock_lce_req_msg_header_s cce_lce_req_header;
  bp_bedrock_lce_resp_msg_header_s cce_lce_resp_header;
  bp_bedrock_lce_cmd_msg_header_s cce_lce_cmd_header;
  logic [dword_width_p-1:0] cce_lce_req_data, cce_lce_resp_data, cce_lce_cmd_data;

  // Mem connections

  // to/from CCE
  logic cce_mem_resp_header_v, cce_mem_resp_header_ready;
  logic cce_mem_resp_data_v, cce_mem_resp_data_ready;
  logic cce_mem_cmd_header_v, cce_mem_cmd_header_ready;
  logic cce_mem_cmd_data_v, cce_mem_cmd_data_ready;
  bp_bedrock_cce_mem_msg_header_s cce_mem_resp_header, cce_mem_cmd_header;
  logic [dword_width_p-1:0] cce_mem_cmd_data, cce_mem_resp_data;

  // to/from Burst-Lite converters
  bp_bedrock_cce_mem_msg_s cce_mem_cmd_lo;
  logic cce_mem_cmd_v_lo, cce_mem_cmd_ready_li;
  bp_bedrock_cce_mem_msg_s cce_mem_resp_li;
  logic cce_mem_resp_v_li, cce_mem_resp_yumi_lo;

  bp_bedrock_cce_mem_msg_s loopback_mem_cmd_li;
  bp_bedrock_xce_mem_msg_s loopback_mem_cmd;
  logic loopback_mem_cmd_v_li, loopback_mem_cmd_ready_lo;
  bp_bedrock_cce_mem_msg_s loopback_mem_resp_lo;
  bp_bedrock_xce_mem_msg_s loopback_mem_resp;
  logic loopback_mem_resp_v_lo, loopback_mem_resp_yumi_li;
  assign loopback_mem_cmd = '{header: loopback_mem_cmd_li.header
                             ,data: loopback_mem_cmd_li.data[0+:dword_width_p]
                             };
  assign loopback_mem_resp_lo = '{header: loopback_mem_resp.header
                                 ,data: {cce_block_width_p/dword_width_p{loopback_mem_resp.data}}
                                 };

  bp_bedrock_cce_mem_msg_s cache_mem_cmd_li;
  logic cache_mem_cmd_v_li, cache_mem_cmd_ready_lo;
  bp_bedrock_cce_mem_msg_s cache_mem_resp_lo;
  logic cache_mem_resp_v_lo, cache_mem_resp_yumi_li;

  bp_bedrock_cce_mem_msg_s cfg_mem_cmd_li;
  bp_bedrock_xce_mem_msg_s cfg_mem_cmd;
  logic cfg_mem_cmd_v_li, cfg_mem_cmd_ready_lo;
  bp_bedrock_cce_mem_msg_s cfg_mem_resp_lo;
  bp_bedrock_xce_mem_msg_s cfg_mem_resp;
  logic cfg_mem_resp_v_lo, cfg_mem_resp_yumi_li;
  assign cfg_mem_cmd = '{header: cfg_mem_cmd_li.header
                        ,data: cfg_mem_cmd_li.data[0+:dword_width_p]
                        };
  assign cfg_mem_resp_lo = '{header: cfg_mem_resp.header
                            ,data: {cce_block_width_p/dword_width_p{cfg_mem_resp.data}}
                            };

  logic reset_r;
  always_ff @(posedge clk_i)
    reset_r <= reset_i;

  bp_cfg_bus_s cfg_bus_lo;
  logic cce_ucode_v_lo;
  logic cce_ucode_w_lo;
  logic [cce_pc_width_p-1:0] cce_ucode_addr_lo;
  logic [cce_instr_width_p-1:0] cce_ucode_data_lo, cce_ucode_data_li;
  bp_cfg
   #(.bp_params_p(bp_params_p))
   cfg
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.mem_cmd_i(cfg_mem_cmd)
     ,.mem_cmd_v_i(cfg_mem_cmd_v_li)
     ,.mem_cmd_ready_and_o(cfg_mem_cmd_ready_lo)

     ,.mem_resp_o(cfg_mem_resp)
     ,.mem_resp_v_o(cfg_mem_resp_v_lo)
     ,.mem_resp_yumi_i(cfg_mem_resp_yumi_li)

     ,.cfg_bus_o(cfg_bus_lo)
     ,.did_i(my_did_i)
     ,.host_did_i('0)
     ,.cord_i(my_cord_i)

     ,.cce_ucode_v_o(cce_ucode_v_lo)
     ,.cce_ucode_w_o(cce_ucode_w_lo)
     ,.cce_ucode_addr_o(cce_ucode_addr_lo)
     ,.cce_ucode_data_o(cce_ucode_data_lo)
     ,.cce_ucode_data_i(cce_ucode_data_li)
     );

  bp_cce_wrapper
   #(.bp_params_p(bp_params_p))
   cce
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.cfg_bus_i(cfg_bus_lo)

     ,.ucode_v_i(cce_ucode_v_lo)
     ,.ucode_w_i(cce_ucode_w_lo)
     ,.ucode_addr_i(cce_ucode_addr_lo)
     ,.ucode_data_i(cce_ucode_data_lo)
     ,.ucode_data_o(cce_ucode_data_li)

     // LCE-CCE Interface
     // BP Burst protocol: ready&valid
     ,.lce_req_header_i(cce_lce_req_header)
     ,.lce_req_header_v_i(cce_lce_req_header_v)
     ,.lce_req_header_ready_and_o(cce_lce_req_header_ready)
     ,.lce_req_data_i(cce_lce_req_data)
     ,.lce_req_data_v_i(cce_lce_req_data_v)
     ,.lce_req_data_ready_and_o(cce_lce_req_data_ready)

     ,.lce_resp_header_i(cce_lce_resp_header)
     ,.lce_resp_header_v_i(cce_lce_resp_header_v)
     ,.lce_resp_header_ready_and_o(cce_lce_resp_header_ready)
     ,.lce_resp_data_i(cce_lce_resp_data)
     ,.lce_resp_data_v_i(cce_lce_resp_data_v)
     ,.lce_resp_data_ready_and_o(cce_lce_resp_data_ready)

     ,.lce_cmd_header_o(cce_lce_cmd_header)
     ,.lce_cmd_header_v_o(cce_lce_cmd_header_v)
     ,.lce_cmd_header_ready_and_i(cce_lce_cmd_header_ready)
     ,.lce_cmd_data_o(cce_lce_cmd_data)
     ,.lce_cmd_data_v_o(cce_lce_cmd_data_v)
     ,.lce_cmd_data_ready_and_i(cce_lce_cmd_data_ready)

     // CCE-MEM Interface
     // BP Burst protocol: ready&valid
     ,.mem_resp_header_i(cce_mem_resp_header)
     ,.mem_resp_header_v_i(cce_mem_resp_header_v)
     ,.mem_resp_header_ready_and_o(cce_mem_resp_header_ready)
     ,.mem_resp_data_i(cce_mem_resp_data)
     ,.mem_resp_data_v_i(cce_mem_resp_data_v)
     ,.mem_resp_data_ready_and_o(cce_mem_resp_data_ready)

     ,.mem_cmd_header_o(cce_mem_cmd_header)
     ,.mem_cmd_header_v_o(cce_mem_cmd_header_v)
     ,.mem_cmd_header_ready_and_i(cce_mem_cmd_header_ready)
     ,.mem_cmd_data_o(cce_mem_cmd_data)
     ,.mem_cmd_data_v_o(cce_mem_cmd_data_v)
     ,.mem_cmd_data_ready_and_i(cce_mem_cmd_data_ready)
     );

  `declare_bp_lce_req_wormhole_packet_s(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, bp_bedrock_lce_req_msg_header_s, cce_block_width_p);
  localparam lce_req_wh_payload_width_lp = `bp_coh_wormhole_payload_width(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, $bits(bp_bedrock_lce_req_msg_header_s), cce_block_width_p);
  bp_lce_req_wormhole_packet_s [1:0] lce_req_packet_lo;
  bp_lce_req_wormhole_header_s [1:0] lce_req_header_lo;

  `declare_bp_lce_cmd_wormhole_packet_s(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, bp_bedrock_lce_cmd_msg_header_s, cce_block_width_p);
  localparam lce_cmd_wh_payload_width_lp = `bp_coh_wormhole_payload_width(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, $bits(bp_bedrock_lce_cmd_msg_header_s), cce_block_width_p);
  bp_lce_cmd_wormhole_packet_s [1:0] lce_cmd_packet_lo, lce_cmd_packet_li;
  bp_lce_cmd_wormhole_header_s [1:0] lce_cmd_header_lo, lce_cmd_header_li;

  `declare_bp_lce_resp_wormhole_packet_s(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, bp_bedrock_lce_resp_msg_header_s, cce_block_width_p);
  localparam lce_resp_wh_payload_width_lp = `bp_coh_wormhole_payload_width(coh_noc_flit_width_p, coh_noc_cord_width_p, coh_noc_len_width_p, coh_noc_cid_width_p, $bits(bp_bedrock_lce_resp_msg_header_s), cce_block_width_p);

  // CCE wormhole connections

  // LCE to CCE request
  localparam pr_len_width_lp = 8;
  logic [coh_noc_flit_width_p-1:0] cce_lce_req_wh_header_pad;
  bp_lce_req_wormhole_header_s cce_lce_req_wh_header;
  assign cce_lce_req_wh_header = cce_lce_req_wh_header_pad[0+:$bits(bp_lce_req_wormhole_header_s)];
  assign cce_lce_req_header = cce_lce_req_wh_header.msg_hdr;

  logic [pr_len_width_lp-1:0] cce_lce_req_pr_len;
  bp_bedrock_size_to_len
   #(.width_p(pr_len_width_lp)
     ,.flit_width_p(dword_width_p)
     )
   cce_lce_req_size_to_len
   (.size_i(cce_lce_req_header.size)
    ,.len_o(cce_lce_req_pr_len)
   );

  bsg_wormhole_stream_out
   #(.flit_width_p(coh_noc_flit_width_p)
     ,.cord_width_p(coh_noc_cord_width_p)
     ,.len_width_p(coh_noc_len_width_p)
     ,.pr_hdr_width_p(lce_req_msg_header_width_lp)
     ,.pr_data_width_p(dword_width_p)
     ,.pr_len_width_p(pr_len_width_lp)
     ,.hdr_width_p(coh_noc_flit_width_p)
     )
   cce_lce_req_stream_out
   (.clk_i(clk_i)
    ,.reset_i(reset_i)

    ,.link_data_i(lce_req_link_cast_i.data)
    ,.link_v_i(lce_req_link_cast_i.v)
    ,.link_ready_and_o(lce_req_link_cast_o.ready_and_rev)

    ,.hdr_o(cce_lce_req_wh_header_pad)
    ,.hdr_v_o(cce_lce_req_header_v)
    ,.hdr_ready_and_i(cce_lce_req_header_ready)
    ,.pr_data_beats_i(cce_lce_req_pr_len)

    ,.data_o(cce_lce_req_data)
    ,.data_v_o(cce_lce_req_data_v)
    ,.data_ready_and_i(cce_lce_req_data_ready)
    );

  // CCE to LCE command
  // encode the header into WH format
  bp_lce_cmd_wormhole_header_s cce_lce_cmd_wh_header_lo;
  bp_me_wormhole_packet_encode_lce_cmd
   #(.bp_params_p(bp_params_p))
   cmd_encode
    (.lce_cmd_header_i(cce_lce_cmd_header)
     ,.wh_header_o(cce_lce_cmd_wh_header_lo)
     );
  wire [coh_noc_flit_width_p-1:0] cce_lce_cmd_wh_header_pad_lo = {'0, cce_lce_cmd_wh_header_lo};

  logic [pr_len_width_lp-1:0] cce_lce_cmd_pr_len;
  bp_bedrock_size_to_len
   #(.width_p(pr_len_width_lp)
     ,.flit_width_p(dword_width_p)
     )
   cce_lce_cmd_size_to_len
   (.size_i(cce_lce_cmd_header.size)
    ,.len_o(cce_lce_cmd_pr_len)
   );

  bsg_wormhole_stream_in
   #(.flit_width_p(coh_noc_flit_width_p)
     ,.cord_width_p(coh_noc_cord_width_p)
     ,.len_width_p(coh_noc_len_width_p)
     ,.pr_hdr_width_p(lce_cmd_msg_header_width_lp)
     ,.pr_data_width_p(dword_width_p)
     ,.pr_len_width_p(pr_len_width_lp)
     ,.hdr_width_p(coh_noc_flit_width_p)
     )
   cce_lce_cmd_stream_in
   (.clk_i(clk_i)
    ,.reset_i(reset_i)

    ,.hdr_i(cce_lce_cmd_wh_header_pad_lo)
    ,.hdr_v_i(cce_lce_cmd_header_v)
    ,.hdr_ready_and_o(cce_lce_cmd_header_ready)
    ,.pr_data_beats_i(cce_lce_cmd_pr_len)

    ,.data_i(cce_lce_cmd_data)
    ,.data_v_i(cce_lce_cmd_data_v)
    ,.data_ready_and_o(cce_lce_cmd_data_ready)

    ,.link_data_o(lce_cmd_link_cast_o.data)
    ,.link_v_o(lce_cmd_link_cast_o.v)
    ,.link_ready_and_i(lce_cmd_link_cast_i.ready_and_rev)
    );

  // LCE to CCE response
  logic [coh_noc_flit_width_p-1:0] cce_lce_resp_wh_header_pad;
  bp_lce_resp_wormhole_header_s cce_lce_resp_wh_header;
  assign cce_lce_resp_wh_header = cce_lce_resp_wh_header_pad[0+:$bits(bp_lce_resp_wormhole_header_s)];
  assign cce_lce_resp_header = cce_lce_resp_wh_header.msg_hdr;

  logic [pr_len_width_lp-1:0] cce_lce_resp_pr_len;
  bp_bedrock_size_to_len
   #(.width_p(pr_len_width_lp)
     ,.flit_width_p(dword_width_p)
     )
   cce_lce_resp_size_to_len
   (.size_i(cce_lce_resp_header.size)
    ,.len_o(cce_lce_resp_pr_len)
   );

  bsg_wormhole_stream_out
   #(.flit_width_p(coh_noc_flit_width_p)
     ,.cord_width_p(coh_noc_cord_width_p)
     ,.len_width_p(coh_noc_len_width_p)
     ,.pr_hdr_width_p(lce_resp_msg_header_width_lp)
     ,.pr_data_width_p(dword_width_p)
     ,.pr_len_width_p(pr_len_width_lp)
     ,.hdr_width_p(coh_noc_flit_width_p)
     )
   cce_lce_resp_stream_out
   (.clk_i(clk_i)
    ,.reset_i(reset_i)

    ,.link_data_i(lce_resp_link_cast_i.data)
    ,.link_v_i(lce_resp_link_cast_i.v)
    ,.link_ready_and_o(lce_resp_link_cast_o.ready_and_rev)

    ,.hdr_o(cce_lce_resp_wh_header_pad)
    ,.hdr_v_o(cce_lce_resp_header_v)
    ,.hdr_ready_and_i(cce_lce_resp_header_ready)
    ,.pr_data_beats_i(cce_lce_resp_pr_len)

    ,.data_o(cce_lce_resp_data)
    ,.data_v_o(cce_lce_resp_data_v)
    ,.data_ready_and_i(cce_lce_resp_data_ready)
    );

  // Mem Command
  logic cce_mem_cmd_v_and_lo;
  bp_burst_to_lite
   #(.bp_params_p(bp_params_p)
     ,.in_data_width_p(dword_width_p)
     ,.out_data_width_p(cce_block_width_p)
     ,.payload_width_p(cce_mem_payload_width_lp)
     ,.payload_mask_p(mem_cmd_payload_mask_gp)
     )
   mem_cmd_burst2lite
    (.clk_i(clk_i)
     ,.reset_i(reset_i)

     ,.in_msg_header_i(cce_mem_cmd_header)
     ,.in_msg_header_v_i(cce_mem_cmd_header_v)
     ,.in_msg_header_ready_and_o(cce_mem_cmd_header_ready)

     ,.in_msg_data_i(cce_mem_cmd_data)
     ,.in_msg_data_v_i(cce_mem_cmd_data_v)
     ,.in_msg_data_ready_and_o(cce_mem_cmd_data_ready)

     ,.out_msg_o(cce_mem_cmd_lo)
     ,.out_msg_v_o(cce_mem_cmd_v_and_lo)
     ,.out_msg_ready_and_i(cce_mem_cmd_ready_li)
     );
  assign cce_mem_cmd_v_lo = cce_mem_cmd_v_and_lo & cce_mem_cmd_ready_li;

  // Mem Response
  logic cce_mem_resp_ready_lo;
  assign cce_mem_resp_yumi_lo = cce_mem_resp_v_li & cce_mem_resp_ready_lo;
  bp_lite_to_burst
   #(.bp_params_p(bp_params_p)
     ,.in_data_width_p(cce_block_width_p)
     ,.out_data_width_p(dword_width_p)
     ,.payload_width_p(cce_mem_payload_width_lp)
     ,.payload_mask_p(mem_resp_payload_mask_gp)
     )
   mem_resp_lite2burst
    (.clk_i(clk_i)
     ,.reset_i(reset_i)

     ,.in_msg_i(cce_mem_resp_li)
     ,.in_msg_v_i(cce_mem_resp_v_li)
     ,.in_msg_ready_and_o(cce_mem_resp_ready_lo)

     ,.out_msg_header_o(cce_mem_resp_header)
     ,.out_msg_header_v_o(cce_mem_resp_header_v)
     ,.out_msg_header_ready_and_i(cce_mem_resp_header_ready)

     ,.out_msg_data_o(cce_mem_resp_data)
     ,.out_msg_data_v_o(cce_mem_resp_data_v)
     ,.out_msg_data_ready_and_i(cce_mem_resp_data_ready)
     );

  /* TODO: Extract local memory map to module */
  wire local_cmd_li        = (cce_mem_cmd_lo.header.addr < dram_base_addr_gp);
  wire [3:0] device_cmd_li = cce_mem_cmd_lo.header.addr[20+:4];
  wire is_cfg_cmd          = local_cmd_li & (device_cmd_li == cfg_dev_gp);
  wire is_cache_cmd        = ~local_cmd_li || (local_cmd_li & (device_cmd_li == cache_dev_gp));
  wire is_loopback_cmd     = local_cmd_li & ~is_cfg_cmd & ~is_cache_cmd;

  assign cfg_mem_cmd_v_li      = is_cfg_cmd   & cce_mem_cmd_v_lo;
  assign cache_mem_cmd_v_li    = is_cache_cmd & cce_mem_cmd_v_lo;
  assign loopback_mem_cmd_v_li = is_loopback_cmd & cce_mem_cmd_v_lo;

  assign cce_mem_cmd_ready_li = &{loopback_mem_cmd_ready_lo, cache_mem_cmd_ready_lo, cfg_mem_cmd_ready_lo};

  assign {loopback_mem_cmd_li, cache_mem_cmd_li, cfg_mem_cmd_li} = {3{cce_mem_cmd_lo}};

  bp_bedrock_cce_mem_msg_s mem_resp_selected_li;
  logic mem_resp_selected_v_li, mem_resp_selected_ready_lo;
  bsg_arb_fixed
   #(.inputs_p(3)
     ,.lo_to_hi_p(1)
     )
   resp_arb
    (.ready_i(mem_resp_selected_ready_lo)
     ,.reqs_i({loopback_mem_resp_v_lo, cfg_mem_resp_v_lo, cache_mem_resp_v_lo})
     ,.grants_o({loopback_mem_resp_yumi_li, cfg_mem_resp_yumi_li, cache_mem_resp_yumi_li})
     );

  bsg_mux_one_hot
   #(.width_p($bits(bp_bedrock_cce_mem_msg_s)), .els_p(3))
   resp_select
    (.data_i({loopback_mem_resp_lo, cfg_mem_resp_lo, cache_mem_resp_lo})
     ,.sel_one_hot_i({loopback_mem_resp_v_lo, cfg_mem_resp_v_lo, cache_mem_resp_v_lo})
     ,.data_o(mem_resp_selected_li)
     );

  assign mem_resp_selected_v_li = loopback_mem_resp_yumi_li | cache_mem_resp_yumi_li | cfg_mem_resp_yumi_li;
  bsg_two_fifo
   #(.width_p($bits(bp_bedrock_cce_mem_msg_s)))
   resp_fifo
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.data_i(mem_resp_selected_li)
     ,.v_i(mem_resp_selected_v_li)
     ,.ready_o(mem_resp_selected_ready_lo)

     ,.data_o(cce_mem_resp_li)
     ,.v_o(cce_mem_resp_v_li)
     ,.yumi_i(cce_mem_resp_yumi_lo)
     );

  bp_bedrock_cce_mem_msg_s dma_mem_cmd_lo;
  logic dma_mem_cmd_v_lo, dma_mem_cmd_ready_li;
  bp_bedrock_cce_mem_msg_s dma_mem_resp_li;
  logic dma_mem_resp_v_li, dma_mem_resp_ready_lo, dma_mem_resp_yumi_lo;
  if (l2_en_p)
    begin : l2s
      bp_bedrock_cce_mem_msg_header_s dma_mem_cmd_header_lo;
      logic dma_mem_cmd_header_v_lo, dma_mem_cmd_header_ready_li;
      logic [dword_width_p-1:0] dma_mem_cmd_data_lo;
      logic dma_mem_cmd_data_v_lo, dma_mem_cmd_data_ready_li;
      bp_bedrock_cce_mem_msg_header_s dma_mem_resp_header_li;
      logic dma_mem_resp_header_v_li, dma_mem_resp_header_ready_lo;
      logic [dword_width_p-1:0] dma_mem_resp_data_li;
      logic dma_mem_resp_data_v_li, dma_mem_resp_data_ready_lo;
      bp_me_cache_slice
       #(.bp_params_p(bp_params_p))
       l2s
        (.clk_i(clk_i)
         ,.reset_i(reset_r)

         ,.mem_cmd_i(cache_mem_cmd_li)
         ,.mem_cmd_v_i(cache_mem_cmd_v_li)
         ,.mem_cmd_ready_o(cache_mem_cmd_ready_lo)

         ,.mem_resp_o(cache_mem_resp_lo)
         ,.mem_resp_v_o(cache_mem_resp_v_lo)
         ,.mem_resp_yumi_i(cache_mem_resp_yumi_li)

         ,.mem_cmd_header_o(dma_mem_cmd_header_lo)
         ,.mem_cmd_header_v_o(dma_mem_cmd_header_v_lo)
         ,.mem_cmd_header_yumi_i(dma_mem_cmd_header_ready_li & dma_mem_cmd_header_v_lo)

         ,.mem_cmd_data_o(dma_mem_cmd_data_lo)
         ,.mem_cmd_data_v_o(dma_mem_cmd_data_v_lo)
         ,.mem_cmd_data_yumi_i(dma_mem_cmd_data_ready_li & dma_mem_cmd_data_v_lo)

         ,.mem_resp_header_i(dma_mem_resp_header_li)
         ,.mem_resp_header_v_i(dma_mem_resp_header_v_li)
         ,.mem_resp_header_ready_o(dma_mem_resp_header_ready_lo)

         ,.mem_resp_data_i(dma_mem_resp_data_li)
         ,.mem_resp_data_v_i(dma_mem_resp_data_v_li)
         ,.mem_resp_data_ready_o(dma_mem_resp_data_ready_lo)
         );

      bp_burst_to_lite
       #(.bp_params_p(bp_params_p)
         ,.in_data_width_p(dword_width_p)
         ,.out_data_width_p(cce_block_width_p)
         ,.payload_width_p(cce_mem_payload_width_lp)
         ,.payload_mask_p(mem_cmd_payload_mask_gp)
         )
       burst2lite
        (.clk_i(clk_i)
         ,.reset_i(reset_r)

         ,.in_msg_header_i(dma_mem_cmd_header_lo)
         ,.in_msg_header_v_i(dma_mem_cmd_header_v_lo)
         ,.in_msg_header_ready_and_o(dma_mem_cmd_header_ready_li)

         ,.in_msg_data_i(dma_mem_cmd_data_lo)
         ,.in_msg_data_v_i(dma_mem_cmd_data_v_lo)
         ,.in_msg_data_ready_and_o(dma_mem_cmd_data_ready_li)

         ,.out_msg_o(dma_mem_cmd_lo)
         ,.out_msg_v_o(dma_mem_cmd_v_lo)
         ,.out_msg_ready_and_i(dma_mem_cmd_ready_li)
         );

      bp_lite_to_burst
       #(.bp_params_p(bp_params_p)
         ,.in_data_width_p(cce_block_width_p)
         ,.out_data_width_p(dword_width_p)
         ,.payload_width_p(cce_mem_payload_width_lp)
         ,.payload_mask_p(mem_resp_payload_mask_gp)
         )
       lite2burst
        (.clk_i(clk_i)
         ,.reset_i(reset_r)

         ,.in_msg_i(dma_mem_resp_li)
         ,.in_msg_v_i(dma_mem_resp_v_li)
         ,.in_msg_ready_and_o(dma_mem_resp_ready_lo)

         ,.out_msg_header_o(dma_mem_resp_header_li)
         ,.out_msg_header_v_o(dma_mem_resp_header_v_li)
         ,.out_msg_header_ready_and_i(dma_mem_resp_header_ready_lo)

         ,.out_msg_data_o(dma_mem_resp_data_li)
         ,.out_msg_data_v_o(dma_mem_resp_data_v_li)
         ,.out_msg_data_ready_and_i(dma_mem_resp_data_ready_lo)
         );
      assign dma_mem_resp_yumi_lo = dma_mem_resp_ready_lo & dma_mem_resp_v_li;
    end
  else
    begin : no_l2s
      assign dma_mem_cmd_lo = cache_mem_cmd_li;
      assign dma_mem_cmd_v_lo = cache_mem_cmd_v_li;
      assign cache_mem_cmd_ready_lo = dma_mem_cmd_ready_li;

      assign cache_mem_resp_lo = dma_mem_resp_li;
      assign cache_mem_resp_v_lo = dma_mem_resp_v_li;
      assign dma_mem_resp_yumi_lo = cache_mem_resp_yumi_li;
    end

  bp_cce_loopback
   #(.bp_params_p(bp_params_p))
   loopback
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.mem_cmd_i(loopback_mem_cmd)
     ,.mem_cmd_v_i(loopback_mem_cmd_v_li)
     ,.mem_cmd_ready_o(loopback_mem_cmd_ready_lo)

     ,.mem_resp_o(loopback_mem_resp)
     ,.mem_resp_v_o(loopback_mem_resp_v_lo)
     ,.mem_resp_yumi_i(loopback_mem_resp_yumi_li)
     );

  localparam dram_y_cord_lp = ic_y_dim_p + cc_y_dim_p + mc_y_dim_p;
  wire [mem_noc_cord_width_p-1:0] dst_cord_li = dram_y_cord_lp;
  bp_me_cce_to_mem_link_master
   #(.bp_params_p(bp_params_p)
     ,.flit_width_p(mem_noc_flit_width_p)
     ,.cord_width_p(mem_noc_cord_width_p)
     ,.cid_width_p(mem_noc_cid_width_p)
     ,.len_width_p(mem_noc_len_width_p)
     )
   dma_link
    (.clk_i(clk_i)
     ,.reset_i(reset_r)

     ,.mem_cmd_i(dma_mem_cmd_lo)
     ,.mem_cmd_v_i(dma_mem_cmd_v_lo)
     ,.mem_cmd_ready_o(dma_mem_cmd_ready_li)

     ,.mem_resp_o(dma_mem_resp_li)
     ,.mem_resp_v_o(dma_mem_resp_v_li)
     ,.mem_resp_yumi_i(dma_mem_resp_yumi_lo)

     ,.my_cord_i(my_cord_i[coh_noc_x_cord_width_p+:mem_noc_y_cord_width_p])
     // TODO: CID == noc cord right now (1 DMC per column)
     ,.my_cid_i(my_cord_i[0+:mem_noc_cid_width_p]-sac_x_dim_p[0+:mem_noc_cid_width_p])
     ,.dst_cord_i(dst_cord_li)
     ,.dst_cid_i('0)

     ,.cmd_link_o(mem_cmd_link_o)
     ,.resp_link_i(mem_resp_link_i)
     );

endmodule

