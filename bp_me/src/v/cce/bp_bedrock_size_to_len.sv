/**
 *
 * Name:
 *   bp_bedrock_size_to_len.sv
 *
 * Description:
 *   This module computes the number of flits required to send the data field of
 *   a BedRock message based on a BedRock size field and the specified flit width.
 *
 *   The len_o output is equal to flits-1 (i.e., it is zero based)
 *
 *   width_p is the width to use for the output length integer
 *
 *   (1 << e_bedrock_msg_size_X) gives the number of bytes for the message size enum value
 *
 */

module bp_bedrock_size_to_len
  import bp_common_pkg::*;
  #(parameter flit_width_p = "inv"
    , parameter width_p    = "inv"
  )
  (input bp_bedrock_msg_size_e  size_i
   , output logic [width_p-1:0] len_o
  );

  localparam msg_size_1_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_1)*8, flit_width_p) - 1;
  localparam msg_size_2_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_2)*8, flit_width_p) - 1;
  localparam msg_size_4_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_4)*8, flit_width_p) - 1;
  localparam msg_size_8_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_8)*8, flit_width_p) - 1;
  localparam msg_size_16_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_16)*8, flit_width_p) - 1;
  localparam msg_size_32_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_32)*8, flit_width_p) - 1;
  localparam msg_size_64_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_64)*8, flit_width_p) - 1;
  localparam msg_size_128_flits_lp = `BSG_CDIV((1 << e_bedrock_msg_size_128)*8, flit_width_p) - 1;
  
  always_comb begin
    unique case (size_i)
      e_bedrock_msg_size_1: len_o = width_p'(msg_size_1_flits_lp);
      e_bedrock_msg_size_2: len_o = width_p'(msg_size_2_flits_lp);
      e_bedrock_msg_size_4: len_o = width_p'(msg_size_4_flits_lp);
      e_bedrock_msg_size_8: len_o = width_p'(msg_size_8_flits_lp);
      e_bedrock_msg_size_16: len_o = width_p'(msg_size_16_flits_lp);
      e_bedrock_msg_size_32: len_o = width_p'(msg_size_32_flits_lp);
      e_bedrock_msg_size_64: len_o = width_p'(msg_size_64_flits_lp);
      e_bedrock_msg_size_128: len_o = width_p'(msg_size_128_flits_lp);
      default: len_o = '0;
    endcase
  end

endmodule

