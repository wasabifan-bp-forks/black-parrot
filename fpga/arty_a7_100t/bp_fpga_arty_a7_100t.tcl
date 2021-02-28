
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
