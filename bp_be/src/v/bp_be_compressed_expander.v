
`include "bp_common_defines.svh"
`include "bp_be_defines.svh"

module bp_be_compressed_expander
 import bp_common_pkg::*;
 import bp_be_pkg::*;
 #(parameter bp_params_e cfg_p = e_bp_default_cfg
   `declare_bp_proc_params(cfg_p)
   )
  (input [instr_width_gp/2-1:0]        cinstr_i

   , output logic [instr_width_gp-1:0] instr_o
   , output logic                      v_o
   );

  logic [dword_width_gp-1:0] imm;
  logic [rv64_reg_addr_width_gp-1:0] rs1, rs2, rd;
  logic [rv64_reg_addr_width_gp-1:0] rs1p, rs2p, rdp;
  logic [rv64_funct3_width_gp-1:0] funct3;

  localparam rv64_zero_reg_addr_gp = 5'd0;
  localparam rv64_link_reg_addr_gp = 5'd1;
  localparam rv64_sp_reg_addr_gp = 5'd2;

  wire [11:0] zero_imm = '0;

  always_comb
    begin
      instr_o = '0;

      rd  = cinstr_i[11:7];
      rs1 = cinstr_i[11:7];
      rs2 = cinstr_i[6:2];

      rdp  = {2'b01, cinstr_i[4:2]};
      rs1p = {2'b01, cinstr_i[9:7]};
      rs2p = {2'b01, cinstr_i[4:2]};

      funct3 = cinstr_i[15:13];

      casez (cinstr_i)
        `RV64_CADDI16SP:
          imm = `rv64_extract_caddi16sp_imm(cinstr_i);
        `RV64_CADDI4SPN:
          imm = `rv64_extract_caddi4spn_imm(cinstr_i);
        `RV64_CLWSP, `RV64_CSWSP:
          imm = `rv64_extract_clwsp_cswsp_imm(cinstr_i);
        `RV64_CLDSP, `RV64_CSDSP:
          imm = `rv64_extract_cldsp_csdsp_imm(cinstr_i);
        `RV64_CLW, `RV64_CSW:
          imm = `rv64_extract_clw_csw_imm(cinstr_i);
        `RV64_CLD, `RV64_CSD:
          imm = `rv64_extract_cld_csd_imm(cinstr_1);
        `RV64_CJ:
          imm = `rv64_extract_cj_imm(cinstr_1);
        `RV64_CBEQZ, `RV64_CBNEZ:
          imm = `rv64_extract_cbeqz_cbnez_imm(cinstr_1);
        `RV64_CLI:
          imm = `rv64_extract_cli_imm(cinstr_1);
        `RV64_CLUI:
          imm =`rv64_extract_clui_imm(cinstr_1);
        `RV64_CADDI, `RV64_CADDIW, `RV64_CANDI:
          imm = `rv64_extract_caddi_caddiw_candi_imm(cinstr_1);
        `RV64_CSLLI, `RV64_CSRLI, `RV64_CSRAI:
          imm = `rv64_extract_cslli_csrli_csrai_imm(cinstr_1);
        default: imm = '0;
      endcase

      casez (cinstr_i)
        // These cases have priority over the others
        // C.ADDI16SP -> addi x2, x2, nzimm[9:4]
        `RV64_CADDI16SP: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rd, 3'b000, rd, imm);
        // C.ADDI4SPN -> addi rd', x2, nzuimm[9:2]
        `RV64_CADDI4SPN: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rd, 3'b000, rd, imm);
        // C.EBREAK   -> ebreak
        `RV64_CEBREAK: instr_o = `RV64_EBREAK;
        // C.LWSP     -> lw rd, offset[7:2] (x2)
        // C.LDSP     -> ld rd, offset[8:3] (x2)
        `RV64_CLWSP, `RV64_CLDSP: instr_o =
          `rv64_build_i_type(`RV64_LOAD_OP, rd, funct3, rv64_sp_reg_addr_gp, imm);
        // C.SWSP     -> sw rs2, offset[7:2] (x2)
        // C.SDSP     -> sd rs2, offset[8:3] (x2)
        `RV64_CSWSP, `RV64_CSDSP: instr_o =
          `rv64_build_s_type(`RV64_STORE_OP, funct3, rv64_sp_reg_addr_gp, rs1, imm);
        // C.LW       -> lw rd', offset[6:2] (rs1')
        // C.LD       -> ld rd', offset[7:3] (rs1')
        `RV64_CLW, `RV64_CLD: instr_o =
          `rv64_build_i_type(`RV64_LOAD_OP, rdp, funct3, rs1p, imm);
        // C.SW       -> sw rs2', offset[6:2] (rs1')
        // C.SD       -> sd rs2', offset[7:3] (rs1')
        `RV64_CSW, `RV64_CSD: instr_o =
          `rv64_build_s_type(`RV64_STORE_OP, funct3, rs1p, rs2p, imm);
        // C.J        -> jal x0, offset[11:1]
        `RV64_CJ: instr_o =
          `rv64_build_j_type(`RV64_JAL_OP, rv64_zero_reg_addr_gp, imm);
        // C.JR       -> jalr x0, 0(rs1)
        `RV64_CJR: instr_o =
          `rv64_build_i_type(`RV64_JALR_OP, rv64_zero_reg_addr_gp, 3'b000, rs1, zero_imm);
        // C.JALR     -> jalr x1, 0(rs1)
        `RV64_CJALR: instr_o =
          `rv64_build_i_type(`RV64_JALR_OP, rv64_link_reg_addr_gp, 3'b000, rs1, zero_imm);
        // C.BEQZ     -> beq rs1', x0, offset[8:1]
        `RV64_CBEQZ: instr_o =
          `rv64_build_b_type(`RV64_BRANCH_OP, 3'b000, rs1p, rv64_zero_reg_addr_gp, imm);
        // C.BNEZ     -> bne rs1', x0, offset[8:1]
        `RV64_CBNEZ: instr_o =
          `rv64_build_b_type(`RV64_BRANCH_OP, 3'b001, rs1p, rv64_zero_reg_addr_gp, imm);
        // C.LI       -> addi rd, x0, imm[5:0]
        `RV64_CLI: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rd, 3'b000, rv64_zero_reg_addr_gp, imm);
        // C.LUI      -> lui rd, nzimm[17:12]
        `RV64_CLUI: instr_o =
          `rv64_build_u_type(`RV64_LUI_OP, rd, imm);
        // C.NOP      -> addi x0, x0, 0
        `RV64_CNOP: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rv64_zero_reg_addr_gp, 3'b000, rv64_zero_reg_addr_gp, zero_imm);
        // C.ADDI     -> addi rd, rd, nzimm[5:0]
        `RV64_CADDI: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rd, funct3, rd, imm);
        // C.ADDIW    -> addiw rd, rd, imm[5:0]
        `RV64_CADDIW: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_32_OP, rd, funct3, rd, imm);
        // C.SLLI     -> slli rd, rd, shamt[5:0]
        `RV64_CSLLI: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rd, 3'b001, rd, imm);
        // C.SRLI     -> srli rd', rd', shamt[5:0]
        `RV64_CSRLI: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rdp, 3'b101, rdp, imm);
        // C.SRAI     -> srai rd', rd', shamt[5:0]
        `RV64_CSRAI: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rdp, 3'b101, rdp, imm);
        // C.ANDI     -> andi rd', rd', imm[5:0]
        `RV64_CANDI: instr_o =
          `rv64_build_i_type(`RV64_OP_IMM_OP, rdp, 3'b111, rdp, imm);
        // C.MV       -> add rd, x0, rs2
        `RV64_CMV: instr_o =
          `rv64_build_r_type(`RV64_OP_OP, rd, 3'b000, rv64_zero_reg_addr_gp, rs2, 7'b0);
        // C.ADD      -> add rd, rd, rs2
        `RV64_CADD: instr_o =
          `rv64_build_r_type(`RV64_OP_OP, rdp, 3'b000, rdp, rs2p, 7'b0);
        // C.AND      -> and rd', rd', rs2'
        `RV64_CAND: instr_o =
          `rv64_build_r_type(`RV64_OP_OP, rdp, 3'b111, rdp, rs2p, 7'b0);
        // C.OR       -> or rd', rd', rs2'
        `RV64_COR: instr_o =
          `rv64_build_r_type(`RV64_OP_OP, rdp, 3'b110, rdp, rs2p, 7'b0);
        // C.XOR      -> xor rd', rd', rs2'
        `RV64_CXOR: instr_o =
          `rv64_build_r_type(`RV64_OP_OP, rdp, 3'b100, rdp, rs2p, 7'b0);
        // C.SUB      -> sub rd', rd', rs2'
        `RV64_CSUB: instr_o =
          `rv64_build_r_type(`RV64_OP_OP, rdp, 3'b000, rdp, rs2p, 7'b010_0000);
        // C.ADDW     -> addw rd', rd', rs2'
        `RV64_CADDW: instr_o =
          `rv64_build_r_type(`RV64_OP_IMM_32_OP, rdp, 3'b000, rdp, rs2p, 7'b0);
        // C.SUBW     -> subw rd', rd', rs2'
        `RV64_CSUBW: instr_o =
          `rv64_build_r_type(`RV64_OP_IMM_32_OP, rdp, 3'b000, rdp, rs2p, 7'b010_0000);
        default: instr_o = '0;
      endcase

      v_o = (instr_o != '0);
    end

endmodule

