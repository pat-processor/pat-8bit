set currentDesign pads

set_attribute lib_search_path /home/research/software/asic/kits/ams/H18/liberty/h18_1.8V
set_attribute library {h18_CORELIB_HV_TYP.lib h18_IOLIB_HV_TYP.lib}

set_attribute information_level 2
set_attribute hdl_track_filename_row_col true

# trade size for speed in optimisation
set_attribute dp_postmap_upsize true 

# turn off data path sharing (e.g. mux to a single adder)
#set_attribute dp_sharing none [find /designs* -subdesign name ]

read_hdl -sv pat.sv
read_hdl -sv digital.sv
read_hdl -v2001 pads.v

# enable clock gating
#set_attribute lp_insert_clock_gating true /
#set_attribute lp_clock_gating_min_flops 3 [find /designs -design testbench]
#set_attribute lp_clock_gating_cell [find / -libcell LGN*] /designs/testbench

elaborate $currentDesign

#set_attribute lp_clock_gating_test_signal *ssel* /
#report clock_gating -preview -gated_ff -clock_pin clk


set clock [define_clock -period 1000 -name clk [find / -port clk_int]]
dc::current_design $currentDesign
dc::set_time_unit -picoseconds
# external output capacitance in fF. 1.5 is approx INVX1 
set_attribute external_driver [find [find / -libcell INVX2_HV] -libpin Q] /designs/$currentDesign/ports_in/*
set_attribute external_pin_cap 1.5 /designs/$currentDesign/ports_out/*
# set pad input slew in ps, rise/fall and 4 cycle path to logic
#set_attribute external_driver_input_slew {100 100} [find /des* -port ports_in/*]



dc::set_multicycle_path -setup 4 -from [find /des* -port ports_in/*]

set_attribute ungroup_ok false [find /designs/ -instance thePC ]
set_attribute optimize_merge_flops true /
#set_attribute optimize_merge_seq false [find / -inst field_out_reg*]
# new below
set_attribute auto_partition true /
set_attribute ungroup_ok false [find /designs/ -instance thePAT]

dc::set_multicycle_path -setup 2 -from [find / -inst pc_out_reg*] -to [find / -inst iBuffer/i_buffer_reg*]

dc::set_false_path -from [find / -port pad_modesel_0] -exception_name mode0
dc::set_false_path -from [find / -port pad_modesel_1] -exception_name mode1

dc::set_false_path -from /designs/pads/instances_hier/theCore/pins_in/reset -exception_name reset_pat
dc::set_false_path -from [find / -port reset_patternbuf_high] -exception_name reset_buf_h
dc::set_false_path -from [find / -port reset_patternbuf_low] -exception_name reset_buf_l
dc::set_false_path -from [find / -port pad_io_b* ] -exception_name pad_resets
# I/O pad latency, as seen by encounter (why so high - I think it's a loop out->in)
dc::set_multicycle_path -setup 13 -from [ find / -port pad_io_a* ] -exception_name io_a_pads
#dc::set_false_path -from [ find / -port pad_io_a* ] -exception_name io_a_pads
dc::set_false_path -from [ find / -port pad_pwm_low ] -exception_name io_pwm_low
dc::set_false_path -from [ find / -port pad_pwm_high ] -exception_name io_pwm_high


if {$insertScanChain == "y"} {
# SCAN CHAIN
set_attribute dft_scan_style muxed_scan /
define_dft test_clock -name scan_clock -period 1000 /designs/pads/ports_in/clk_int

define_dft shift_enable -active high pad_modesel_0 -hookup_pin iopad_modesel_0/Y
define_dft scan_chain -shared_out -sdo iopad_b5/A -hookup_pin_sdo iopad_b5/A -sdi iopad_a7/Y -domain scan_clock -name scan_chain_1
#  Choose between this and shared system 
#define_dft scan_chain -sdi scan_in_2 -sdo scan_out_2 -create_ports -domain scan_clock -name scan_chain_2
set_attribute optimize_merge_seq false [find / -inst field_out_reg*]
set_attribute dft_dont_scan false [find / -inst field_out_reg*]
set_attribute dft_dont_scan true [find / -inst data_out_reg*]

# choose what to scan and what not to
#set_attribute dft_dont_scan true /designs/patternbuffer/instances_hier/theBuffers/

check_dft_rules
report dft_registers
# allow dft engine to determine if output scan is inverted or not
set_attribute dft_scan_output_preference auto $currentDesign
# map all flops that pass DFT rules to scannable
set_attr dft_scan_map_mode tdrc_pass $currentDesign
# set for synthesis drive
set_attr dft_connect_scan_data_pins_during_mapping loopback $currentDesign
set_attribute dft_prefix SCAN_ / 

report dft_setup


synthesize -to_mapped $currentDesign

replace_scan



# if already mapped, use "replace_scan" before running the next scan commands
connect_scan_chains -preview -auto_create_chains -pack

#define_dft scan_chain -name scanchain1 -sdi scan_in_pin -sdo scan_out_pin -shift_enable scan_enable

# TODO: enable below to make scan chains
connect_scan_chains 
report dft_chains > $currentDesign-scanchains
report dft_setup > $currentDesign-dftsetup


# improve timing now the scan chain is there
#synthesize -incremental -effort high

# END SCAN CHAIN
}

# request an extra 30ps slack on the register paths
#set all_regs [find / -instance instances_seq/*] 
#path_adjust -from $all_regs -to $all_regs -delay -30 -name slack-30_regs









synthesize -to_mapped -effort high $currentDesign

write -mapped > $currentDesign-mapped.v
write_script > $currentDesign-mapped.script
write_sdc > $currentDesign-mapped.sdc
write_hdl -mapped > $currentDesign-mapped.enc
report dft_chains > $currentDesign-scanchains
report dft_setup > $currentDesign-dftsetup

report area
report gates
report clocks
report datapath
report timing 
