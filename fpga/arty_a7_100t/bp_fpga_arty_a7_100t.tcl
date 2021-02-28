
# Check file required for this script exists
proc checkRequiredFiles { origin_dir} {
  set status true
  set files [list \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_fp_to_rec.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_rec_to_fp.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_aux.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_dcache/bp_be_dcache_decoder.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_ctl.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_fma.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_int.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_long.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_regfile.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_scoreboard.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_cacc_complex.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_cacc_tile_node.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_alu.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_arbitrate.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_branch.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir_lru_extract.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir_tag_checker.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_gad.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_decode.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_predecode.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_stall.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_pending_bits.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_pma.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_spec_bits.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_core_complex.sv" \
   "${origin_dir}/../../bp_fe/src/v/bp_fe_bht.sv" \
   "${origin_dir}/../../bp_fe/src/v/bp_fe_btb.sv" \
   "${origin_dir}/../../bp_fe/src/v/bp_fe_instr_scan.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_io_complex.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_io_tile_node.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_l2e_tile_node.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_addr_to_cce_id.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_id_to_cord.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cord_to_id.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_lce_id_to_cord.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_mem_complex.sv" \
   "${origin_dir}/../../bp_common/src/v/bp_mmu.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_multicore.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_nd_socket.sv" \
   "${origin_dir}/../../bp_common/src/v/bp_pma.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_sacc_complex.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_sacc_tile_node.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_tile_node.sv" \
   "${origin_dir}/../../bp_common/src/v/bp_tlb.sv" \
   "${origin_dir}/../../bp_top/src/v/bsg_async_noc_link.sv" \
   "${origin_dir}/../../bp_common/src/v/bsg_bus_pack.sv" \
   "${origin_dir}/../../bp_common/src/v/bsg_fifo_1r1w_rolly.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_issue_queue.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_calculator_top.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_top.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_ptw.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_sys.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_scheduler.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_mem.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_director.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_dcache/bp_be_dcache.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_detector.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_instr_decoder.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_csr.sv" \
   "${origin_dir}/../../bp_be/src/v/bp_be_dcache/bp_be_dcache_wbuf.sv" \
   "${origin_dir}/../../bp_fe/src/v/bp_fe_pc_gen.sv" \
   "${origin_dir}/../../bp_fe/src/v/bp_fe_top.sv" \
   "${origin_dir}/../../bp_fe/src/v/bp_fe_icache.sv" \
   "${origin_dir}/../../bp_me/src/v/cache/bp_me_cache_slice.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_loopback.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_msg.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_mem_cmd.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_burst_to_lite.sv" \
   "${origin_dir}/../../bp_me/src/v/cache/bp_me_cce_to_cache_dma.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_io_cce.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_cmd.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_lite_to_stream.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_src_sel.sv" \
   "${origin_dir}/../../bp_me/src/v/lce/bp_lce.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_lite_to_burst.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_mem_resp.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_uce.sv" \
   "${origin_dir}/../../bp_me/src/v/lce/bp_lce_cmd.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_ram.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_req.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_master.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_resp.sv" \
   "${origin_dir}/../../bp_me/src/v/cache/bp_me_cce_to_cache.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir_segment.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_client.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_fsm.sv" \
   "${origin_dir}/../../bp_me/src/v/lce/bp_lce_req.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_bidir.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_fsm_top.sv" \
   "${origin_dir}/../../bp_me/src/v/wormhole/bp_stream_to_lite.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_wrapper.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce_reg.sv" \
   "${origin_dir}/../../bp_me/src/v/cache/bp_me_cache_dma_to_cce.sv" \
   "${origin_dir}/../../bp_me/src/v/cce/bp_cce.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_cfg.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_core.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_clint_slice.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_cacc_tile.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_io_link_to_lce.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_cacc_vdp.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_io_tile.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_core_minimal.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_l2e_tile.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_tile.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_sacc_vdp.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_unicore.sv" \
   "${origin_dir}/../../bp_top/src/v/bp_sacc_tile.sv" \
   "${origin_dir}/../../bp_fe/src/include/bp_fe_icache_defines.svh" \
   "${origin_dir}/../../bp_fe/src/include/bp_fe_icache_pkgdef.svh" \
   "${origin_dir}/../../bp_fe/src/include/bp_fe_pkg.sv" \
   "${origin_dir}/../../bp_fe/src/include/bp_fe_defines.svh" \
   "${origin_dir}/../../bp_fe/src/include/bp_fe_decompress.svh" \
   "${origin_dir}/../../bp_top/src/include/bp_top_defines.svh" \
   "${origin_dir}/../../bp_top/src/include/bp_top_pkg.sv" \
   "${origin_dir}/../../bp_be/src/include/bp_be_defines.svh" \
   "${origin_dir}/../../bp_be/src/include/bp_be_dcache_defines.svh" \
   "${origin_dir}/../../bp_be/src/include/bp_be_pkg.sv" \
   "${origin_dir}/../../bp_be/src/include/bp_be_dcache_pkgdef.svh" \
   "${origin_dir}/../../bp_be/src/include/bp_be_ctl_pkgdef.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_bedrock_if.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_core_pkgdef.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_rv64_csr_defines.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_cache_engine_if.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_aviary_defines.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_pkg.sv" \
   "${origin_dir}/../../bp_common/src/include/bp_common_cache_engine_pkgdef.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_rv64_pkgdef.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_rv64_instr_defines.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_cfg_bus_pkgdef.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_defines.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_cfg_bus_defines.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_core_if.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_log_defines.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_aviary_pkgdef.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_bedrock_pkgdef.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_addr_defines.svh" \
   "${origin_dir}/../../bp_common/src/include/bp_common_addr_pkgdef.svh" \
   "${origin_dir}/../../bp_me/src/include/bp_me_defines.svh" \
   "${origin_dir}/../../bp_me/src/include/bp_me_cce_inst_pkgdef.svh" \
   "${origin_dir}/../../bp_me/src/include/bp_me_cce_defines.svh" \
   "${origin_dir}/../../bp_me/src/include/bp_me_pkg.sv" \
   "${origin_dir}/../../bp_me/src/include/bp_me_cce_inst_defines.svh" \
   "${origin_dir}/../../bp_me/src/include/bp_me_wormhole_defines.svh" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_miss.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_client.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel_wormhole.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_overflow_set_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_xor.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_v2/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_i2f.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_clear_up.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_set_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_banked.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_set_down.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_cam_1r1w_sync_unmanaged/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset_en_bypass.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset_set_clear.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_small_hardened/bsg_fifo_1r1w_small_hardened_tester.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/send_config_tag.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_two_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_ddr_downstream.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_async/bsg_sync_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/mul_32/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_iddr_phy.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router_decoder_dor.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_defines.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mux_bitwise.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/test_assembler_defines.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_logic_analyzer.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_lru_pseudo_tree_encode/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_misc/bsg_mux.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/tests/test_bsg_source_sync/test_bsg_source_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sort_4.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_var.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_rotate_left.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_hash_bank/tb.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_rp_clk_gen_atomic_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/master_calib_skip/bsg_comm_link_master_calib_skip_rom.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_narrow.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dramsim3/testbench_multi.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_muxi2_gatestack.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_one_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_concentrator.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_clock_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small_hardened.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_n_to_1.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_synth.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_64/basic_checker.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_comp42.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_miss_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mul/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_gatestack.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_link.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_bypass.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_array_concentrate_static.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_axi_tx.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_clear_up_one_hot.v" \
   "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1rw_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_buf.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_flow_convert.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_synth.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_rocket/bsg_chip_rocket.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_comm_link.vh" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_2r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_chain.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1rw_sync_mask_write_byte_assoc.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lru_pseudo_tree_backup.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1rw_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_butterfly.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_network/bsg_wormhole_network_test_node_client.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_large.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_synth.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_async_buffer.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_wait_after_reset.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_tielo.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_from_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_level_shift_fsb_domain.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_tiehi.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out/bsg_parallel_in_serial_out_tester.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_array.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_hash_bank_reverse.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/1024Mb_mobile_ddr_parameters.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_assembler_in.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_dataflow/bsg_fifo_shift_datapath.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_reset_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/definitions.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_and.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_adder_cin.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router_buffered.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_wait_after_reset/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_cycle_counter.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mux_bitwise/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/tasks.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_network/bsg_wormhole_network_test_node_master.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_banked_crossbar.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_arb_round_robin.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_pseudo_large/bsg_test.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_sbuf.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_file_setter.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1rw_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1r1w.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_dynamic_limit.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_noc_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_parallel_in_serial_out_passthrough.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/cfgtaggw.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_clock_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_classify.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1rw_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_overflow_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small_credit_on_input.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_one_hot.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_adapter.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_large_banked.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_synth.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel_in.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_clk_gen_osc.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_idiv_iterative_controller.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_tag/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_two_buncher.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_synth.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/common/bsg_nonsynth_random_yumi_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/config_defs.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_f2i.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_random_gen/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_controller.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_id_pool.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_input.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_channel_control_slave.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_strobe.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mux_test/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_2r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_tag_mem.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_trace_replay.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_flow_counter.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_concentrator_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_tielo.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_async/bsg_sync_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/common/bsg_nonsynth_non_blocking_dma_model.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_tiehi.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mul/bsg_mul_and_csa_block_hard.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mul/bsg_mul_booth_4_block_rep.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/axe_test/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_decode.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_serial_in_parallel_out_passthrough/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_channel_control_master.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux2_gatestack.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_imul_iterative.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_master.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_adapter_in.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_1_to_n_tagged_fifo_shared.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth2/cache_miss_counter.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_oddr_phy.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_xor.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mul/bsg_mul_booth_4_block_rep.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/manycore_dram/bsg_test_node_master.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/all_to_all/test_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1rw_sync_assoc.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff_reset.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_dram_clk_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_core.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_nor3.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_sync_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_adder_one_hot/test.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mul/bsg_mul_and_csa_block_hard.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_dma.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mux/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_8b10b_encode_comb.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w_sync_synth.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1r1w_sync_dma.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_cam_1r1w_sync/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_and.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_router_crossbar_o_by_i.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sbox_ctrl.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out_full.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_swap.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_fifo_to_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mux_one_hot.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_1r1w/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_decode_with_v.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_tracker.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_make_2D_array.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_phy.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_mask_write_var.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_rotate_right.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_lru_pseudo_tree_backup/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lru_pseudo_tree_decode.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dpi/top.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_inv.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_imul_iterative/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth2/vcache_blocking.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_clk_gen_osc.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counting_leading_zeros.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_dff/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_reorder/remote_node.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_math/bsg_hypotenuse/bsg_hypotenuse.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_tl_stage.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_stat_mem.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/tests/test_bsg_assembler/test_bsg_assembler.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_level_shift_node_domain.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_source_sync_downstream.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/ainv_checker.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_out/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_utils.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_rocket/bsg_nonsynth_chipset_rocket_fsb.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_front_side_bus_hop_in_no_fc.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_async_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_edge_balanced_mux4.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_inv.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small_unhardened.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sort_stable.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_mhu.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_level_shift_up_down_sink.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/add_sub_32/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_nonsynth_cache_axe_tracer.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/dmc/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff_reset_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_abs.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/bsg_fpu_sticky/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_miss_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset_en.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_defines.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_nor3.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_client_unsync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/dmc/bsg_trace_rom.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_axi_rx.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_launch_sync_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dpi_rom/top.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_flatten_2D_array.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/test_bsg_data_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_banked.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_out/bsg_trace_rom.v" \
   "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_clkbuf.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/f2i_32/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_circular_ptr.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_idiv_iterative.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_sticky.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_in/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_up_down.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/tests/mesosynctb.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_snooper_bind.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_in/bsg_trace_rom.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_binary_plus_one_to_gray/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_strobe/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_parallel_in_serial_out_dynamic.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_channel_control_master_master.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_node.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_nand.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/128Mb_mobile_ddr_parameters.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_wait_cycles.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_expand_bitmask.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_to_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_locking_arb_fixed.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_sbuf_queue.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_compare_and_swap.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lfsr.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_en_bypass.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_negedge_reset.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_nor2.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_concentrator/bsg_wormhole_concentrator_tester.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_async_ptr_gray.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_add_sub.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_3r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mux.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_booth_4_block_rep.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_stitch.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_clk_rst_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_mhu.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_decoder_dor.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_nasti/bsg_fsb_to_nasti_slave_connector.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_pseudo_large/test_bsg_fifo_1r1w_pseudo_large.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_htif/bsg_fsb_to_htif_connector.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/rNandMeta.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_dramsim3.vh" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mux_one_hot.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_2r1w.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_rp_clk_gen_atomic_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_replacement.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_credit_to_token.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_array_reverse.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_one_hot.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_mux2_gatestack.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_thermometer_count.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_counter_clock_downsample/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_buf_ctrl.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_priority_encode/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/tb.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1r1w.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_inv.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram_rx_reorder.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/cmp_32/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_clk_gen/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_and.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_misc/bsg_mux.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_xnor.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_buf.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/256Mb_mobile_ddr_parameters.vh" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_1_to_n_tagged_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_mul.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_clock_downsample.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_rp_clk_gen_fine_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_rp_clk_gen_coarse_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/hard/ultrascale_plus/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram_rx.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_ready_and_link_async_to_wormhole.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_encode_one_hot/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_clkgate_optional.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_scan.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_reduce.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_nonsynth_mem_1rw_sync_mask_write_byte_dma/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_compare_and_swap/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_dramsim3_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_cmp.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out/bsg_parallel_in_serial_out_test_node.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_rp_clk_gen_fine_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth2/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/tests/test_bsg_comm_link/test_bsg_comm_link.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_channel_narrow/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_top.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_binary_plus_one_to_gray.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_array_row.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_axi.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/common/bsg_nonsynth_dma_model.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/relay_node.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_ddr_upstream.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_macros.vh" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out_passthrough/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/i2f_32/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_1rw_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_node_bind.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_nasti/bsg_nasti_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_val_watcher_1p.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_source_sync_upstream.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_concentrator/bsg_wormhole_concentrator_test_node.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_reduce.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_test_rom.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_channel_tunnel/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_front_side_bus_hop_in.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dlatch.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_adder_ripple_carry.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_xnor.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/mobile_ddr.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w_sync_synth.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1r1w_sync_mask_write_byte_dma.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/2048Mb_mobile_ddr_parameters.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_banked_crossbar/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_clk_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_sync_unmanaged.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_clkgate_optional.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_popcount.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_2r1w/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_shift_datapath.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_parallel_in_serial_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_dma.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit_synth.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3_map.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_random_gen.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/master_calib_skip/bsg_source_sync_channel_control_master_master.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mux_one_hot/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_dram_ctrl_tx.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_macros.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_xnor.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_v2/basic_checker.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_priority_encode_one_hot_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_cycle_counter.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_clk_gen_osc.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_macros.vh" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_trace_replay/dut.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff_reset.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_tielo.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_tiehi.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_hasti/bsg_vscale_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_legacy/bsg_murn_converter.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_pg_tree.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out_dynamic.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_reduce.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_unmanaged.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/test_bsg_clock_params.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_pg_tree/test.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w_synth.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_2r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router/bsg_wormhole_router_tester.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_thermometer_count/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_misc/bsg_level_shift_up_down_source.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mul/bsg_mul_comp42_rep.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_pseudo_large.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_crossbar_o_by_i.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_trace_replay.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_to_ring_stitch.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_setter.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_snooper.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_edge_detect.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_large/test_bsg_fifo_1r1w_large.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_narrowed.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_rp_clk_gen_fine_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_output.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/mobile_ddr_mcp.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_round_robin_arb/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_misc/bsg_level_shift_up_down_sink.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_nonsynth_mixin_motherboard.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_assembler_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_concentrate_static.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_concentrator_in.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_clk_gen/bsg_nonsynth_clk_gen_tester.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/512Mb_mobile_ddr_parameters.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_math/bsg_hypotenuse/test_bsg_hypotenuse.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_rp_clk_gen_coarse_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/basic_checker.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_scatter_gather.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1rw_large.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_encode_one_hot/another_test.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/all_to_all/test_tile.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_delay_line.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/tests/cfgtaggw_test/cfg_tag_tb.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_2r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_dly_line.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_nand.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_dff_en_reset/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_network/bsg_wormhole_network_tester.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/tests/cfgtaggw_test/config_defs.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_dff_gatestack.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_noc_links.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out_passthrough.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_reduce_segmented.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_popcount/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w_synth.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_unconcentrate_static.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_arb_round_robin/test.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_output.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mux.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_reorder.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_clz.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/tests/mesosynctb_gate_level.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_1rw_sync/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_clk_gen.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_encode_one_hot.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_decode.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_adapter_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_ramulator_hbm.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_bypass/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_gray_to_binary/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_round_robin_arb.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_preprocess.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_nonsynth_fsb_node_trace_replay.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_rocket/bsg_rocket_core_fsb.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router/bsg_wormhole_router_test_node.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_wait_cycles/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag.vh" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_rotate_left/main.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_dynamic_limit_en.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_async/bsg_launch_sync_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_8b10b_shift_decoder.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_hash_bank.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_data_mem.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_clock_gen_plusarg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/subtest.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_adder_one_hot.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_2r1w.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_nonsynth_clk_watcher.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_ascii_writer.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_relay_fifo.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_clkbuf.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_bitwise.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_xor.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_counter_dynamic_limit/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_hasti/bsg_vscale_hasti_converter.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_trace_replay/test_bench.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_2r1w_sync_macros.vh" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff_reset_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_crossbar_control_basic_o_by_i.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/tag_checker.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_lru_pseudo_tree_decode/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/test_bsg_comm_link_checker.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_ready_to_credit_flow_converter.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lru_pseudo_tree_encode.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_scan/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_input.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_1_to_n_tagged.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_transpose.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3_unmap.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram_tx.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_rp_clk_gen_atomic_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/dmc/bsg_test_master.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out_passthrough_arb/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/all_to_all/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/master_calib_skip/bsg_source_sync_channel_control_master.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_2r1w_sync.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff_en.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_gray_to_binary.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_to_ring_stitch/test_mesh_to_ring_stitch.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/block_ld_checker.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_async/bsg_launch_sync_sync.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_round_robin_reset_arb/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_murn_gateway.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_nand.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_nor3.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_gpio.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_multiport.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_booth_4_block.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_segmented.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_rom.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_small_hardened/bsg_fifo_1r1w_small_hardened_test_node.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_pkg.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dramsim3/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sbox_ctrl_concentrate.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1rw_sync_mask_write_byte_dma.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_2_to_2.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mul/bsg_mul_comp42_rep.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sbox.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_banked.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_defs.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_tag_array.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_idiv_iterative/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_input_control.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_shift_reg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_front_side_bus_hop_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_trace_replay.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_reorder/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_decode.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_level_shift_up_down_source.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_up_down_variable.v" \
   "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_muxi2_gatestack.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_ramulator_hbm/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_nasti/bsg_fsb_to_nasti_master_connector.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel_out.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3.svh" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/manycore_dram/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_output_control.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1r1w_sync_macros.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_buf.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/tests/cfgtaggw_test/cfgtag.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_cycle_counter/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_pipelined.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_1_to_n.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_noc_repeater_node.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/common/fpu_common.h" \
   "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_comm_link.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_8b10b_decode_comb.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_triwire.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_comp42_rep.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_64/testbench.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_permute_box.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_ddr_sampler.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_dly_line.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1r1w.v" \
   "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_counter_up_down/test_bsg.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_less_than.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_rp_clk_gen_coarse_delay_tuner.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_async_credit_counter.v" \
   "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_3r1w_sync_macros.vh" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_dram_ctrl_rx.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_dram_ctrl.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_synth.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_arb_fixed.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_clkbuf.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_priority_encode.v" \
   "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_clk_gen_osc.v" \
   "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_tl_stage.v" \
   "${origin_dir}/../../fpga/arty_a7_100t/arty_a7_100.xdc" \
  ]
  foreach ifile $files {
    if { ![file isfile $ifile] } {
      puts " Could not find remote file $ifile "
      set status false
    }
  }

  return $status
}
# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Set the project name
set _xil_proj_name_ "bp_fpga_arty_a7_100t"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "bp_fpga_arty_a7_100t.tcl"

# Help information for this script
proc print_help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--project_name <name>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--project_name <name>\] Create project with the specified name. Default"
  puts "                       name is the name of the project from where this"
  puts "                       script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < $::argc} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--project_name" { incr i; set _xil_proj_name_ [lindex $::argv $i] }
      "--help"         { print_help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/bp_fpga_arty_a7_100t"]"

# Check for paths and files needed for project creation
set validate_required 0
if { $validate_required } {
  if { [checkRequiredFiles $origin_dir] } {
    puts "Tcl file $script_file is valid. All files required for project creation is accesable. "
  } else {
    puts "Tcl file $script_file is not valid. Not all files required for project creation is accesable. "
    return
  }
}

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7a100tcsg324-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "board_part_repo_paths" -value "[file normalize "$origin_dir/../../../../AppData/Roaming/Xilinx/Vivado/2020.2/xhub/board_store/xilinx_board_store"]" -objects $obj
set_property -name "board_part" -value "digilentinc.com:arty-a7-100:part0:1.0" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "arty-a7-100" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "source_mgmt_mode" -value "DisplayOnly" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_fp_to_rec.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_rec_to_fp.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_aux.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_dcache/bp_be_dcache_decoder.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_ctl.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_fma.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_int.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_long.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_regfile.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_scoreboard.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_cacc_complex.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_cacc_tile_node.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_alu.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_arbitrate.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_branch.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir_lru_extract.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir_tag_checker.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_gad.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_decode.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_predecode.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_stall.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_pending_bits.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_pma.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_spec_bits.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_core_complex.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/v/bp_fe_bht.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/v/bp_fe_btb.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/v/bp_fe_instr_scan.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_io_complex.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_io_tile_node.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_l2e_tile_node.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_addr_to_cce_id.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_id_to_cord.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cord_to_id.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_lce_id_to_cord.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_mem_complex.sv"] \
 [file normalize "${origin_dir}/../../bp_common/src/v/bp_mmu.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_multicore.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_nd_socket.sv"] \
 [file normalize "${origin_dir}/../../bp_common/src/v/bp_pma.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_sacc_complex.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_sacc_tile_node.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_tile_node.sv"] \
 [file normalize "${origin_dir}/../../bp_common/src/v/bp_tlb.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bsg_async_noc_link.sv"] \
 [file normalize "${origin_dir}/../../bp_common/src/v/bsg_bus_pack.sv"] \
 [file normalize "${origin_dir}/../../bp_common/src/v/bsg_fifo_1r1w_rolly.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_issue_queue.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_calculator_top.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_top.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_ptw.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_sys.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_scheduler.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_mem.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_director.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_dcache/bp_be_dcache.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_detector.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_checker/bp_be_instr_decoder.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_calculator/bp_be_csr.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/v/bp_be_dcache/bp_be_dcache_wbuf.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/v/bp_fe_pc_gen.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/v/bp_fe_top.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/v/bp_fe_icache.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cache/bp_me_cache_slice.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_loopback.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_msg.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_mem_cmd.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_burst_to_lite.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cache/bp_me_cce_to_cache_dma.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_io_cce.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_cmd.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_lite_to_stream.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_src_sel.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/lce/bp_lce.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_lite_to_burst.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_mem_resp.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_uce.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/lce/bp_lce_cmd.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_inst_ram.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_req.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_master.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_resp.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cache/bp_me_cce_to_cache.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_dir_segment.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_client.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_fsm.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/lce/bp_lce_req.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_bidir.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_fsm_top.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/wormhole/bp_stream_to_lite.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_wrapper.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce_reg.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cache/bp_me_cache_dma_to_cce.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/v/cce/bp_cce.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_cfg.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_core.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_clint_slice.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_cacc_tile.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_io_link_to_lce.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_cacc_vdp.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_io_tile.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_core_minimal.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_l2e_tile.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_tile.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_sacc_vdp.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_unicore.sv"] \
 [file normalize "${origin_dir}/../../bp_top/src/v/bp_sacc_tile.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/include/bp_fe_icache_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_fe/src/include/bp_fe_icache_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_fe/src/include/bp_fe_pkg.sv"] \
 [file normalize "${origin_dir}/../../bp_fe/src/include/bp_fe_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_fe/src/include/bp_fe_decompress.svh"] \
 [file normalize "${origin_dir}/../../bp_top/src/include/bp_top_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_top/src/include/bp_top_pkg.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/include/bp_be_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_be/src/include/bp_be_dcache_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_be/src/include/bp_be_pkg.sv"] \
 [file normalize "${origin_dir}/../../bp_be/src/include/bp_be_dcache_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_be/src/include/bp_be_ctl_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_bedrock_if.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_core_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_rv64_csr_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_cache_engine_if.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_aviary_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_pkg.sv"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_cache_engine_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_rv64_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_rv64_instr_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_cfg_bus_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_cfg_bus_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_core_if.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_log_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_aviary_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_bedrock_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_addr_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_common/src/include/bp_common_addr_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_me/src/include/bp_me_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_me/src/include/bp_me_cce_inst_pkgdef.svh"] \
 [file normalize "${origin_dir}/../../bp_me/src/include/bp_me_cce_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_me/src/include/bp_me_pkg.sv"] \
 [file normalize "${origin_dir}/../../bp_me/src/include/bp_me_cce_inst_defines.svh"] \
 [file normalize "${origin_dir}/../../bp_me/src/include/bp_me_wormhole_defines.svh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_miss.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_client.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel_wormhole.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_overflow_set_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_xor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_v2/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_i2f.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_clear_up.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_set_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_banked.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_set_down.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_cam_1r1w_sync_unmanaged/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset_en_bypass.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset_set_clear.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_small_hardened/bsg_fifo_1r1w_small_hardened_tester.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/send_config_tag.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_two_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_ddr_downstream.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_async/bsg_sync_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/mul_32/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_iddr_phy.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router_decoder_dor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_defines.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mux_bitwise.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/test_assembler_defines.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_logic_analyzer.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_lru_pseudo_tree_encode/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_misc/bsg_mux.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/tests/test_bsg_source_sync/test_bsg_source_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sort_4.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_var.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_rotate_left.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_hash_bank/tb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_rp_clk_gen_atomic_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/master_calib_skip/bsg_comm_link_master_calib_skip_rom.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_narrow.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dramsim3/testbench_multi.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_muxi2_gatestack.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_one_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_concentrator.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_clock_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small_hardened.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_n_to_1.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_64/basic_checker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_comp42.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_miss_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mul/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_gatestack.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_link.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_bypass.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_array_concentrate_static.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_axi_tx.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_clear_up_one_hot.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1rw_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_buf.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_flow_convert.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_rocket/bsg_chip_rocket.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_comm_link.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_2r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_chain.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1rw_sync_mask_write_byte_assoc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lru_pseudo_tree_backup.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1rw_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_butterfly.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_network/bsg_wormhole_network_test_node_client.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_large.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_async_buffer.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_wait_after_reset.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_tielo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_from_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_level_shift_fsb_domain.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_tiehi.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out/bsg_parallel_in_serial_out_tester.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_array.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_hash_bank_reverse.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/1024Mb_mobile_ddr_parameters.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_assembler_in.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_dataflow/bsg_fifo_shift_datapath.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_reset_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/definitions.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_and.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_adder_cin.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router_buffered.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_wait_after_reset/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_cycle_counter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mux_bitwise/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/tasks.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_network/bsg_wormhole_network_test_node_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_banked_crossbar.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_arb_round_robin.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_pseudo_large/bsg_test.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_sbuf.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_file_setter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1rw_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_dynamic_limit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_noc_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_parallel_in_serial_out_passthrough.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/cfgtaggw.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_clock_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_classify.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1rw_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_overflow_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small_credit_on_input.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_one_hot.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_adapter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_large_banked.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel_in.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_clk_gen_osc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_idiv_iterative_controller.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_tag/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_two_buncher.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/common/bsg_nonsynth_random_yumi_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/config_defs.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_f2i.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_random_gen/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_controller.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_id_pool.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_input.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_channel_control_slave.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_strobe.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mux_test/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_2r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_tag_mem.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_trace_replay.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_flow_counter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_concentrator_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_tielo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_async/bsg_sync_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/common/bsg_nonsynth_non_blocking_dma_model.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_tiehi.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mul/bsg_mul_and_csa_block_hard.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mul/bsg_mul_booth_4_block_rep.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/axe_test/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_decode.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_serial_in_parallel_out_passthrough/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_channel_control_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux2_gatestack.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_imul_iterative.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_adapter_in.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_1_to_n_tagged_fifo_shared.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth2/cache_miss_counter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_oddr_phy.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_xor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mul/bsg_mul_booth_4_block_rep.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/manycore_dram/bsg_test_node_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/all_to_all/test_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1rw_sync_assoc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff_reset.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_dram_clk_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_core.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_nor3.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_sync_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_adder_one_hot/test.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mul/bsg_mul_and_csa_block_hard.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_dma.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mux/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_8b10b_encode_comb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w_sync_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1r1w_sync_dma.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_cam_1r1w_sync/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_and.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_router_crossbar_o_by_i.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sbox_ctrl.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out_full.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_swap.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_fifo_to_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mux_one_hot.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_1r1w/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_decode_with_v.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_tracker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_make_2D_array.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_phy.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_mask_write_var.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_rotate_right.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_lru_pseudo_tree_backup/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lru_pseudo_tree_decode.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dpi/top.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_inv.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_imul_iterative/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth2/vcache_blocking.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_clk_gen_osc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counting_leading_zeros.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_dff/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_reorder/remote_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_math/bsg_hypotenuse/bsg_hypotenuse.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_tl_stage.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_stat_mem.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/tests/test_bsg_assembler/test_bsg_assembler.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_level_shift_node_domain.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_source_sync_downstream.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/ainv_checker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_out/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_utils.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_rocket/bsg_nonsynth_chipset_rocket_fsb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_front_side_bus_hop_in_no_fc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_async_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_edge_balanced_mux4.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_inv.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small_unhardened.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sort_stable.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_mhu.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_level_shift_up_down_sink.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/add_sub_32/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_nonsynth_cache_axe_tracer.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/dmc/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff_reset_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_abs.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/bsg_fpu_sticky/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_miss_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_defines.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_nor3.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_client_unsync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/dmc/bsg_trace_rom.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_axi_rx.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_launch_sync_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dpi_rom/top.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_flatten_2D_array.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/test_bsg_data_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_banked.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_out/bsg_trace_rom.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_clkbuf.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/f2i_32/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_circular_ptr.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_idiv_iterative.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_sticky.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_in/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_up_down.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/tests/mesosynctb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_snooper_bind.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router_adapter_in/bsg_trace_rom.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_binary_plus_one_to_gray/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_strobe/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_parallel_in_serial_out_dynamic.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_channel_control_master_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_nand.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/128Mb_mobile_ddr_parameters.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_wait_cycles.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_expand_bitmask.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_to_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_locking_arb_fixed.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_sbuf_queue.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_compare_and_swap.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lfsr.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_en_bypass.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_negedge_reset.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_nor2.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_concentrator/bsg_wormhole_concentrator_tester.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_async_ptr_gray.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_add_sub.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dff_reset.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_3r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mux.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_booth_4_block_rep.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_stitch.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_clk_rst_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_mhu.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_decoder_dor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_nasti/bsg_fsb_to_nasti_slave_connector.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_pseudo_large/test_bsg_fifo_1r1w_pseudo_large.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_htif/bsg_fsb_to_htif_connector.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/rNandMeta.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_dramsim3.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mux_one_hot.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_2r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_rp_clk_gen_atomic_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_replacement.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_credit_to_token.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_array_reverse.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_one_hot.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_mux2_gatestack.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_thermometer_count.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_counter_clock_downsample/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_buf_ctrl.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_priority_encode/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/tb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_inv.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram_rx_reorder.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/cmp_32/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_clk_gen/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_and.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_misc/bsg_mux.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_xnor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_buf.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/256Mb_mobile_ddr_parameters.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_1_to_n_tagged_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_mul.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_clock_downsample.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_rp_clk_gen_fine_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_rp_clk_gen_coarse_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/ultrascale_plus/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram_rx.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_ready_and_link_async_to_wormhole.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_encode_one_hot/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_clkgate_optional.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_scan.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_reduce.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_nonsynth_mem_1rw_sync_mask_write_byte_dma/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_compare_and_swap/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_dramsim3_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_cmp.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out/bsg_parallel_in_serial_out_test_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_rp_clk_gen_fine_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/dramsim3_bandwidth2/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/tests/test_bsg_comm_link/test_bsg_comm_link.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_channel_narrow/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/cov_top.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_binary_plus_one_to_gray.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_array_row.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_axi.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/common/bsg_nonsynth_dma_model.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/relay_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_ddr_upstream.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_macros.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out_passthrough/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/i2f_32/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/pickle_40/bsg_mem/bsg_mem_1rw_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_node_bind.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_nasti/bsg_nasti_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_val_watcher_1p.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_link/bsg_link_source_sync_upstream.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_concentrator/bsg_wormhole_concentrator_test_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_reduce.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_test_rom.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_channel_tunnel/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_front_side_bus_hop_in.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_dlatch.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_adder_ripple_carry.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_xnor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_router_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/mobile_ddr.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w_sync_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1r1w_sync_mask_write_byte_dma.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/2048Mb_mobile_ddr_parameters.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_banked_crossbar/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_clk_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_sync_unmanaged.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_clkgate_optional.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_popcount.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_2r1w/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_shift_datapath.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_parallel_in_serial_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_dma.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3_map.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_random_gen.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/master_calib_skip/bsg_source_sync_channel_control_master_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_mux_one_hot/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_dram_ctrl_tx.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_macros.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_xnor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_v2/basic_checker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_priority_encode_one_hot_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_cycle_counter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_clk_gen_osc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_macros.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_trace_replay/dut.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff_reset.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_tielo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_tiehi.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_hasti/bsg_vscale_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_legacy/bsg_murn_converter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_pg_tree.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out_dynamic.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_reduce.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_unmanaged.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/test_bsg_clock_params.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_pg_tree/test.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_2r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router/bsg_wormhole_router_tester.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_thermometer_count/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_misc/bsg_level_shift_up_down_source.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mul/bsg_mul_comp42_rep.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_pseudo_large.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_crossbar_o_by_i.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_trace_replay.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_mesh_to_ring_stitch.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/sim/config_setter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_snooper.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_edge_detect.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_large/test_bsg_fifo_1r1w_large.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1r1w_narrowed.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_rp_clk_gen_fine_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_source_sync_output.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/mobile_ddr_mcp.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_round_robin_arb/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_misc/bsg_level_shift_up_down_sink.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_nonsynth_mixin_motherboard.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_assembler_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_concentrate_static.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_concentrator_in.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_clk_gen/bsg_nonsynth_clk_gen_tester.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/512Mb_mobile_ddr_parameters.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_math/bsg_hypotenuse/test_bsg_hypotenuse.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_rp_clk_gen_coarse_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/basic_checker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_scatter_gather.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_1rw_large.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_encode_one_hot/another_test.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/all_to_all/test_tile.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_delay_line.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/tests/cfgtaggw_test/cfg_tag_tb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_2r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_dly_line.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_nand.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_dff_en_reset/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_network/bsg_wormhole_network_tester.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/tests/cfgtaggw_test/config_defs.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_dff_gatestack.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_noc_links.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out_passthrough.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_reduce_segmented.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_popcount/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_3r1w_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_unconcentrate_static.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_arb_round_robin/test.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_output.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_mux.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_fifo_reorder.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_clz.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/tests/mesosynctb_gate_level.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_mem/bsg_mem_1rw_sync/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_clk_gen.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_encode_one_hot.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_decode.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_adapter_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_ramulator_hbm.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_bypass/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_gray_to_binary/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_round_robin_arb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fpu/bsg_fpu_preprocess.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_nonsynth_fsb_node_trace_replay.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_chip/bsg_rocket/bsg_rocket_core_fsb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_wormhole_router/bsg_wormhole_router_test_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_wait_cycles/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/bsg_tag.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_rotate_left/main.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_dynamic_limit_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_async/bsg_launch_sync_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_8b10b_shift_decoder.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_hash_bank.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_data_mem.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_clock_gen_plusarg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/subtest.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_adder_one_hot.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_mem/bsg_mem_2r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_clk_gen/bsg_nonsynth_clk_watcher.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_ascii_writer.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_relay_fifo.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_clkbuf.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_serial_in_parallel_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_bitwise.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_xor.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_counter_dynamic_limit/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_hasti/bsg_vscale_hasti_converter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_trace_replay/test_bench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_2r1w_sync_macros.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_dff_reset_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_crossbar_control_basic_o_by_i.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/tag_checker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_lru_pseudo_tree_decode/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/test_bsg_comm_link_checker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_ready_to_credit_flow_converter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_lru_pseudo_tree_encode.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_scan/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_mesosync_input.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_1_to_n_tagged.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_transpose.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3_unmap.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_test_dram_tx.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_rp_clk_gen_atomic_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/dmc/bsg_test_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_parallel_in_serial_out_passthrough_arb/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_router/all_to_all/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/master_calib_skip/bsg_source_sync_channel_control_master.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_2r1w_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff_en.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_gray_to_binary.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_noc/bsg_mesh_to_ring_stitch/test_mesh_to_ring_stitch.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/block_ld_checker.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_16/bsg_async/bsg_launch_sync_sync.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_round_robin_reset_arb/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_murn_gateway.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_nand.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_nor3.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_gpio.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_multiport.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_booth_4_block.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mux_segmented.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dpi_rom.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_1r1w_small_hardened/bsg_fifo_1r1w_small_hardened_test_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dmc/bsg_dmc_pkg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_dramsim3/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sbox_ctrl_concentrate.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_nonsynth_mem_1rw_sync_mask_write_byte_dma.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_2_to_2.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_misc/bsg_mul/bsg_mul_comp42_rep.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_sbox.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_banked.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/src/config_defs.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_cam_1r1w_tag_array.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_idiv_iterative/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_input_control.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_shift_reg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_front_side_bus_hop_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_fsb/bsg_fsb_node_trace_replay.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_dataflow/bsg_fifo_reorder/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_decode.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_level_shift_up_down_source.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_counter_up_down_variable.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/saed_90/bsg_misc/bsg_muxi2_gatestack.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_test/bsg_nonsynth_ramulator_hbm/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_riscv/bsg_nasti/bsg_fsb_to_nasti_master_connector.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_channel_tunnel_out.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3.svh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/manycore_dram/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_wormhole_router_output_control.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1r1w_sync_macros.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_buf.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_tag/legacy/config_net/tests/cfgtaggw_test/cfgtag.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_misc/bsg_dff.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_cycle_counter/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul_pipelined.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_round_robin_1_to_n.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_noc/bsg_noc_repeater_node.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_fpu/common/fpu_common.h"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_comm_link/bsg_comm_link.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_2r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_non_blocking/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_8b10b_decode_comb.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_test/bsg_nonsynth_triwire.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_mul/bsg_mul_comp42_rep.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_cache/regression_64/testbench.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_dataflow/bsg_permute_box.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mesosync_io/src/bsg_ddr_sampler.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_40/bsg_clk_gen/bsg_dly_line.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_mem/bsg_mem_1r1w.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/testing/bsg_misc/bsg_counter_up_down/test_bsg.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_less_than.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_mask_write_bit.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_clk_gen/bsg_rp_clk_gen_coarse_delay_tuner.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_async/bsg_async_credit_counter.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_3r1w_sync_macros.vh"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_dram_ctrl_rx.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_to_dram_ctrl.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_mem/bsg_mem_1r1w_sync_synth.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_arb_fixed.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_clkbuf.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_misc/bsg_priority_encode.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/hard/tsmc_180_250/bsg_clk_gen/bsg_clk_gen_osc.v"] \
 [file normalize "${origin_dir}/../../external/basejump_stl/bsg_cache/bsg_cache_non_blocking_tl_stage.v"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_fp_to_rec.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_rec_to_fp.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_aux.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_dcache/bp_be_dcache_decoder.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_ctl.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_fma.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_int.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_long.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_checker/bp_be_regfile.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_checker/bp_be_scoreboard.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_cacc_complex.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_cacc_tile_node.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_alu.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_arbitrate.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_branch.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_dir_lru_extract.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_dir_tag_checker.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_gad.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_inst_decode.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_inst_predecode.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_inst_stall.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_pending_bits.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_pma.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_spec_bits.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_core_complex.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/v/bp_fe_bht.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/v/bp_fe_btb.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/v/bp_fe_instr_scan.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_io_complex.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_io_tile_node.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_l2e_tile_node.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_addr_to_cce_id.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_cce_id_to_cord.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_cord_to_id.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_lce_id_to_cord.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_mem_complex.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_common/src/v/bp_mmu.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_multicore.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_nd_socket.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_common/src/v/bp_pma.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_sacc_complex.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_sacc_tile_node.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_tile_node.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_common/src/v/bp_tlb.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bsg_async_noc_link.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_common/src/v/bsg_bus_pack.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_common/src/v/bsg_fifo_1r1w_rolly.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_checker/bp_be_issue_queue.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_calculator_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_ptw.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_sys.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_checker/bp_be_scheduler.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_pipe_mem.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_checker/bp_be_director.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_dcache/bp_be_dcache.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_checker/bp_be_detector.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_checker/bp_be_instr_decoder.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_calculator/bp_be_csr.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/v/bp_be_dcache/bp_be_dcache_wbuf.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/v/bp_fe_pc_gen.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/v/bp_fe_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/v/bp_fe_icache.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cache/bp_me_cache_slice.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_loopback.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_msg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_mem_cmd.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_burst_to_lite.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cache/bp_me_cce_to_cache_dma.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_io_cce.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_cmd.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_lite_to_stream.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_src_sel.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/lce/bp_lce.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_lite_to_burst.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_mem_resp.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_uce.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/lce/bp_lce_cmd.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_inst_ram.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_req.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_master.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_wormhole_packet_encode_lce_resp.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cache/bp_me_cce_to_cache.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_dir.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_dir_segment.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_client.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_fsm.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/lce/bp_lce_req.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_me_cce_to_mem_link_bidir.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_fsm_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/wormhole/bp_stream_to_lite.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_wrapper.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce_reg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cache/bp_me_cache_dma_to_cce.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/v/cce/bp_cce.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_cfg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_core.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_clint_slice.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_cacc_tile.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_io_link_to_lce.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_cacc_vdp.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_io_tile.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_core_minimal.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_l2e_tile.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_tile.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_sacc_vdp.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_unicore.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_top/src/v/bp_sacc_tile.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/include/bp_fe_icache_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/include/bp_fe_icache_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/include/bp_fe_pkg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/include/bp_fe_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_fe/src/include/bp_fe_decompress.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_top/src/include/bp_top_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_top/src/include/bp_top_pkg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/include/bp_be_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_be/src/include/bp_be_dcache_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_be/src/include/bp_be_pkg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_be/src/include/bp_be_dcache_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_be/src/include/bp_be_ctl_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_bedrock_if.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_core_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_rv64_csr_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_cache_engine_if.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_aviary_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_pkg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_cache_engine_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_rv64_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_rv64_instr_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_cfg_bus_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_cfg_bus_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_core_if.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_log_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_aviary_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_bedrock_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_addr_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_common/src/include/bp_common_addr_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_me/src/include/bp_me_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_me/src/include/bp_me_cce_inst_pkgdef.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_me/src/include/bp_me_cce_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_me/src/include/bp_me_pkg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../bp_me/src/include/bp_me_cce_inst_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../bp_me/src/include/bp_me_wormhole_defines.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_comm_link/bsg_comm_link.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/1024Mb_mobile_ddr_parameters.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_fpu/bsg_fpu_defines.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/128Mb_mobile_ddr_parameters.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_test/bsg_dramsim3.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/256Mb_mobile_ddr_parameters.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_macros.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_noc/bsg_wormhole_router.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/2048Mb_mobile_ddr_parameters.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_macros.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_macros.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/512Mb_mobile_ddr_parameters.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_noc/bsg_noc_links.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_clk_gen/bsg_clk_gen.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_tag/bsg_tag.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/testing/bsg_dmc/lpddr_verilog_model/subtest.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_2r1w_sync_macros.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/bsg_test/bsg_nonsynth_dramsim3.svh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_1r1w_sync_macros.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/testing/bsg_fpu/common/fpu_common.h"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../external/basejump_stl/hard/gf_14/bsg_mem/bsg_mem_3r1w_sync_macros.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj


# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "bp_be_pipe_aux" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/arty_a7_100.xdc"]"
set file_added [add_files -norecurse -fileset $obj [list $file]]
set file "$origin_dir/arty_a7_100.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Empty (no sources present)

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "hbs.configure_design_for_hier_access" -value "1" -objects $obj
set_property -name "top" -value "bp_be_pipe_aux" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj

# Set 'utils_1' fileset object
set obj [get_filesets utils_1]
# Empty (no sources present)

# Set 'utils_1' fileset properties
set obj [get_filesets utils_1]

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7a100tcsg324-1 -flow {Vivado Synthesis 2020} -strategy "Vivado Synthesis Defaults" -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2020" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Synthesis Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'synth_1_synth_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] "" ] } {
  create_report_config -report_name synth_1_synth_report_utilization_0 -report_type report_utilization:1.0 -steps synth_design -runs synth_1
}
set obj [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0]
if { $obj != "" } {

}
set obj [get_runs synth_1]
set_property -name "strategy" -value "Vivado Synthesis Defaults" -objects $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7a100tcsg324-1 -flow {Vivado Implementation 2020} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2020" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Implementation Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'impl_1_init_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_opt_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_place_report_io_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] "" ] } {
  create_report_config -report_name impl_1_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] "" ] } {
  create_report_config -report_name impl_1_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_control_sets_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] "" ] } {
  create_report_config -report_name impl_1_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0]
if { $obj != "" } {
set_property -name "options.verbose" -value "1" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_1' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_post_place_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_route_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_methodology_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] "" ] } {
  create_report_config -report_name impl_1_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_power_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] "" ] } {
  create_report_config -report_name impl_1_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_route_status_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] "" ] } {
  create_report_config -report_name impl_1_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_route_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_clock_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] "" ] } {
  create_report_config -report_name impl_1_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_route_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
set obj [get_runs impl_1]
set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:${_xil_proj_name_}"
# Create 'drc_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "drc_1" ] ] ""]} {
create_dashboard_gadget -name {drc_1} -type drc
}
set obj [get_dashboard_gadgets [ list "drc_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_drc_0" -objects $obj

# Create 'methodology_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "methodology_1" ] ] ""]} {
create_dashboard_gadget -name {methodology_1} -type methodology
}
set obj [get_dashboard_gadgets [ list "methodology_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_methodology_0" -objects $obj

# Create 'power_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "power_1" ] ] ""]} {
create_dashboard_gadget -name {power_1} -type power
}
set obj [get_dashboard_gadgets [ list "power_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_power_0" -objects $obj

# Create 'timing_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "timing_1" ] ] ""]} {
create_dashboard_gadget -name {timing_1} -type timing
}
set obj [get_dashboard_gadgets [ list "timing_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_timing_summary_0" -objects $obj

# Create 'utilization_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_1" ] ] ""]} {
create_dashboard_gadget -name {utilization_1} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_1" ] ]
set_property -name "reports" -value "synth_1#synth_1_synth_report_utilization_0" -objects $obj
set_property -name "run.step" -value "synth_design" -objects $obj
set_property -name "run.type" -value "synthesis" -objects $obj

# Create 'utilization_2' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_2" ] ] ""]} {
create_dashboard_gadget -name {utilization_2} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_2" ] ]
set_property -name "reports" -value "impl_1#impl_1_place_report_utilization_0" -objects $obj

move_dashboard_gadget -name {utilization_1} -row 0 -col 0
move_dashboard_gadget -name {power_1} -row 1 -col 0
move_dashboard_gadget -name {drc_1} -row 2 -col 0
move_dashboard_gadget -name {timing_1} -row 0 -col 1
move_dashboard_gadget -name {utilization_2} -row 1 -col 1
move_dashboard_gadget -name {methodology_1} -row 2 -col 1
