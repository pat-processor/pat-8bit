set_attribute lib_search_path /home/simon/cadence/kits/H18/liberty/h18_1.8V

set_attribute library {h18_CORELIB_HV_TYP.lib h18_IOLIB_HV_TYP.lib}

set_attribute information_level 2
#set_attribute auto_super_thread false
set_attribute hdl_track_filename_row_col true

# trade size for speed in optimisation
set_attribute dp_postmap_upsize true 

# turn off data path sharing (e.g. mux to a single adder)
#set_attribute dp_sharing none [find /designs* -subdesign name ]

#set_attribute super_thread_servers {localhost localhost}

#set_attribute preserve true MUX4X1_HV
#set_attribute preserve true MUX2X1_HV
#set_attribute preserve true MUX4X1_HV
#set_attribute preserve true MUX2X1_HV
#set_attribute preserve true DFSX1_HV
#set_attribute preserve true DFSX3_HV

# perhaps lef is overridden by the PHYSICAL.lib?
#set_attribute lef_library /home/research/software/asic/kits/ams/H18/cds/HK_H18/LEF/h18a6/CORELIB_HV.lef

#read_hdl -sv patternbuf.v
#read_hdl -sv buffers.v
#read_hdl -sv testbench2.v
read_hdl -sv pat.v
read_hdl -sv digital.v

# Scan chain commands
#set_attribute dft_scan_type muxed_scan /
#set_attribute dft_dont_scan true testbench
#define_dft test_clock -period 10000

# enable clock gating
#set_attribute lp_insert_clock_gating true /
#set_attribute lp_clock_gating_min_flops 3 [find /designs -design testbench]

elaborate digital
#set_attribute lp_clock_gating_cell [find / -libcell LGN*] /designs/testbench

#set_attribute lp_clock_gating_test_signal *ssel* /
#report clock_gating -preview -gated_ff -clock_pin clk


set clock [define_clock -period 1000 -name clk [find / -port clk]]
# set_max_delay -from <node> -to <node> <delay>
#set_max_delay -from bufp -to current_buffer 1000
#external_delay -output 2000 [find / -port ports_out/*]
dc::current_design digital
dc::set_time_unit -picoseconds
#dc::set_load_unit -femtofarads
#dc::set_output_delay 2000 -clock sclk [all_outputs]

# path_disable == dc::set_false_path
#dc::set_false_path -from [ find / -inst *dmem*] -to [ find / -inst *dmem*] -exception_name memToMem

#path_disable -from [ find / -pin *bufp* ]
#path_disable -from [ find / -pin *fieldp* ]

# path_delay == dc::set_max_delay
#dc::set_max_delay -delay 1200 -from [find / -pin *fieldp* ] -to [ find / -pin *pattern*] -exception_name fieldToPattern


#set_attribute external_driver [find [find / -libcell DFFX1] -libpin D] {/designs/adder/ports_in/*}
#set_attribute external_pin_cap 26.5488 {/designs/adder/ports_out/*}
#set_attribute ungroup_ok false [find /designs/pat/ -instance accALU ]
#set_attribute ungroup_ok false [find /designs/pat/ -instance fieldALU ]
set_attribute ungroup_ok false [find /designs/digital/ -instance thePC ]
#set_attribute ungroup_ok false [find /designs/pat/ -instance theAdder ]
#set_attribute ungroup_ok false [find /designs/pat/ -instance theSub ]
#set_attribute ungroup_ok false [find /designs/pat/ -instance theOR ]
#set_attribute ungroup_ok false [find /designs/pat/ -instance theAND ]
##set_attribute ungroup_ok false [find /designs/pat/ -instance theNeg ]
#set_attribute preserve [find / -instance imem_in*]
#synthesize -to_mapped pat
set_attribute optimize_merge_flops false /
#dc::set_multicycle_path -setup 2 -from thePC/pc -to instructions_reg
dc::set_multicycle_path -setup 2 -from [find / -inst iBuffer/imem_read_adr_reg*] -to [find / -inst iBuffer/i_buffer_reg*]
synthesize -to_mapped -effort high digital

#write -mapped > design_mapped.v
#write_script > design_script.script
#write_sdc > design_timing.sdc
#write_hdl -mapped > patternbuf.enc

report area
report gates
report clocks
report datapath
report timing 

#report timing -from [find / -inst *bufp* ] -to [find / -inst *pattern*]
#report timing -from [find / -inst *fieldp* ] -to [find / -inst *pattern*]
#report timing -from [find / -inst *fieldp* ] -to [find / -inst *field_byte_out*]
