/*
 * bp_fe_instr_scan.sv
 *
 * Instr scan check if the intruction is aligned, compressed, or normal instruction.
 * The entire block is implemented in combinational logic, achieved within one cycle.
*/

`include "bp_common_defines.svh"
`include "bp_fe_defines.svh"

module bp_fe_instr_scan
 import bp_common_pkg::*;
 import bp_fe_pkg::*;
 #(parameter bp_params_e bp_params_p = e_bp_default_cfg
   `declare_bp_proc_params(bp_params_p)

   , localparam instr_scan_width_lp = `bp_fe_instr_scan_width(vaddr_width_p)
   )
  (input [instr_width_gp-1:0]          instr_i

   , output [instr_scan_width_lp-1:0] scan_o
  );

  localparam ra_reg_addr_gp = 5'h1;
  localparam t0_reg_addr_gp = 5'h5;

  `declare_bp_fe_instr_scan_s(vaddr_width_p);

  rv64_instr_rtype_s instr_cast_rtype_i;
  assign instr_cast_rtype_i = instr_i;
  // TODO: packed array?
  wire instr_lower_half_i = instr_i[ c_instr_width_gp-1:0 ];
  wire instr_upper_half_i = instr_i[ instr_width_gp-1  :c_instr_width_gp ];

  bp_fe_instr_scan_s scan_cast_o;
  assign scan_o = scan_cast_o;

  bp_fe_instr_scan_metadata_s whole_instruction_scan_metadata_lo;
  bp_fe_instr_scan_metadata_s lower_half_scan_metadata_lo, upper_half_scan_metadata_lo;
  logic lower_half_is_compressed_instr_lo, upper_half_is_compressed_instr_lo;

  bp_fe_instr_scan_c
   #(.bp_params_p(bp_params_p))
   lower_half_scan
   (.c_instr_i             (instr_lower_half_i)

   ,.scan_o                (lower_half_scan_metadata_lo)
   ,.is_compressed_instr_o (lower_half_is_compressed_instr_lo)
   );

  bp_fe_instr_scan_c
   #(.bp_params_p(bp_params_p))
   upper_half_scan
   (.c_instr_i             (instr_upper_half_i)

   ,.scan_o                (upper_half_scan_metadata_lo)
   ,.is_compressed_instr_o (upper_half_is_compressed_instr_lo)
   );

   // TODO: logic to mux between possible metadata sources and choose the appropriate one, setting source_compressed_upper_half


  wire rtype_jalr_src    = instr_cast_rtype_i.rs1_addr;
  wire rtype_dest_link   = (instr_cast_rtype_i.rd_addr inside {ra_reg_addr_gp, t0_reg_addr_gp});
  wire rtype_dest_src_eq = (instr_cast_rtype_i.rd_addr == instr_cast_rtype_i.rs1_addr);
  wire rtype_src_link    = rtype_jalr_src inside {ra_reg_addr_gp, t0_reg_addr_gp};

  always_comb
    begin
      whole_instruction_scan_metadata_lo.branch = (instr_cast_rtype_i.opcode == `RV64_BRANCH_OP);
      whole_instruction_scan_metadata_lo.jal    = (instr_cast_rtype_i.opcode == `RV64_JAL_OP);
      whole_instruction_scan_metadata_lo.jalr   = (instr_cast_rtype_i.opcode == `RV64_JALR_OP);
      whole_instruction_scan_metadata_lo.call   = (instr_cast_rtype_i.opcode inside {`RV64_JAL_OP, `RV64_JALR_OP}) && rtype_dest_link;
      whole_instruction_scan_metadata_lo.ret    = (instr_cast_rtype_i.opcode == `RV64_JALR_OP) && rtype_src_link && !rtype_dest_src_eq;

      unique casez (instr_cast_rtype_i.opcode)
        `RV64_BRANCH_OP: whole_instruction_scan_metadata_lo.pc_rel_jump_offset = `rv64_signext_b_imm(instr_i);
        `RV64_JAL_OP   : whole_instruction_scan_metadata_lo.pc_rel_jump_offset = `rv64_signext_j_imm(instr_i);
        default        : whole_instruction_scan_metadata_lo.pc_rel_jump_offset = '0;
      endcase
endmodule
