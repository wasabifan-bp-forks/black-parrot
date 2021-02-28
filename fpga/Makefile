VIVADO_TCL_PROJECT_SCRIPTS := arty_a7_100t/bp_fpga_arty_a7_100t.tcl

sanitize_vivado:
	gawk -v RS='\r?\n' -i inplace -f sanitize_vivado_script.awk -- $(VIVADO_TCL_PROJECT_SCRIPTS)
