/*
 * bp_fe_instr_scan.v
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
  rv64_instr_crtype_s instr_cast_crtype_i;
  bp_fe_instr_scan_s scan_cast_o;

  assign instr_cast_rtype_i = instr_i;
  assign instr_cast_crtype_i = instr_i;
  assign scan_o = scan_cast_o;

  // Lower bits are not 2'11, i.e. this is a 16-bit instruction
  wire is_compressed = instr_cast_crtype_i.op inside { `RV64_C0_OP, `RV64_C1_OP, `RV64_C2_OP };

  wire jalr_src = is_compressed ? instr_cast_crtype_i.rs1_addr : instr_cast_rtype_i.rs1_addr;

  wire rtype_dest_link   = (instr_cast_rtype_i.rd_addr inside {ra_reg_addr_gp, t0_reg_addr_gp});
  wire rtype_dest_src_eq = (instr_cast_rtype_i.rd_addr == instr_cast_rtype_i.rs1_addr);
  wire src_link          = jalr_src inside {ra_reg_addr_gp, t0_reg_addr_gp});

  always_comb
    begin
      scan_cast_o = '0;


      if (instr_op inside { `RV64_C0_OP, `RV64_C1_OP, `RV64_C2_OP })
        begin
          unique casez (instr_i)
            // TODO: handle EBREAK and any others which take precedence over subsets of this encoding space
            `RV64_CBEQZ, `RV64_CBNEZ: scan_cast_o.branch = 1'b1;
            `RV64_CJ:                 scan_cast_o.jal    = 1'b1;
            `RV64_CJR:
              begin
                scan_cast_o.jalr = 1'b1;
                scan_cast_o.ret  = src_link;
              end
            `RV64_CJALR:
              begin
                scan_cast_o.jalr = 1'b1;
                scan_cast_o.call = 1'b1;
                // To match the behavior as if this instruction had already been expanded, we label
                // a c.jalr as a return iff it is sourcing from ra and writing to t0 (the alternate
                // link register).
                scan_cast_o.ret = src_link && jalr_src != ra_reg_addr_gp;
              end
          endcase

          // TODO: imm
        end
      else
        begin
          scan_cast_o.branch = (instr_cast_rtype_i.opcode == `RV64_BRANCH_OP);
          scan_cast_o.jal    = (instr_cast_rtype_i.opcode == `RV64_JAL_OP);
          scan_cast_o.jalr   = (instr_cast_rtype_i.opcode == `RV64_JALR_OP);
          scan_cast_o.call   = (instr_cast_rtype_i.opcode inside {`RV64_JAL_OP, `RV64_JALR_OP}) && rtype_dest_link;
          scan_cast_o.ret    = (instr_cast_rtype_i.opcode == `RV64_JALR_OP) && src_link && !rtype_dest_src_eq;

          unique casez (instr_cast_rtype_i.opcode)
            `RV64_BRANCH_OP: scan_cast_o.imm = `rv64_signext_b_imm(instr_i);
            `RV64_JAL_OP   : scan_cast_o.imm = `rv64_signext_j_imm(instr_i);
            default        : scan_cast_o.imm = '0;
          endcase
        end

    end

endmodule

