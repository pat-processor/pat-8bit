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


set clock [define_clock -period 1000 -name clk [find / -port clk]]
dc::current_design $currentDesign
dc::set_time_unit -picoseconds
#dc::set_false_path -from [ find / -inst *dmem*] -to [ find / -inst *dmem*] -exception_name memToMem
set_attribute external_driver [find [find / -libcell DFX1_HV] -libpin Q] [find /des* -port ports_in/*]
set_attribute ungroup_ok false [find /designs/ -instance thePC ]
set_attribute optimize_merge_flops false /
dc::set_multicycle_path -setup 2 -from [find / -inst pc_out_reg*] -to [find / -inst iBuffer/i_buffer_reg*]
synthesize -to_mapped -effort high $currentDesign

write -mapped > $currentDesign-mapped.v
write_script > $currentDesign-mapped.script
write_sdc > $currentDesign-mapped.sdc
write_hdl -mapped > $currentDesign-mapped.enc

report area
report gates
report clocks
report datapath
report timing 
