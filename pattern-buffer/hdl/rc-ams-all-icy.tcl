#puts -nonewline "Insert Scan Chain? (y/N): "
#flush stdout
#set insertScanChain [gets stdin insertScanChain]
#puts "Insert Scan Chain?"
#puts -nonewline $insertScanChain
puts "Scan chain disabled in script."
set insertScanChain n


set_attribute lib_search_path /home/research/software/asic/kits/ams/H18/liberty/h18_1.8V
set_attribute library {h18_CORELIB_HV_TYP.lib h18_IOLIB_HV_TYP.lib}

set_attribute information_level 2

#set_attribute preserve true DFSX3_HV

read_hdl -sv patternbuf.v
read_hdl -sv buffers.v
read_hdl -sv patternbuffer.v

# enable clock gating

#set_attribute lp_clock_gating_min_flops 3 [find /designs -design testbench]
#set_attribute lp_asserted_toggle_rate 0.01 /


#set_attribute lp_clock_gating_cell [find / -libcell LGNX6_HV] /designs/patternbuffer
#set_attribute lp_insert_clock_gating true /

elaborate patternbuffer

#set_attribute lp_clock_gating_test_signal *ssel* /
#report clock_gating -preview -gated_ff -clock_pin clk

dc::set_time_unit -picoseconds
dc::current_design patternbuffer
set clock [define_clock -period 1000 -name clk [find / -port clk]]

# setup delay for level-shifter inputs
external_delay -clock clk -input 250 -name level_shifter_delay [find /des* -port ports_in/*]
external_delay -clock clk -input 0 -name clk_nodelay [find /des* -port clk]
# set the driving strength of the inputs to be equivalent to std cell output
set_attribute external_driver [find [find / -libcell DFX1_HV] -libpin Q] [find /des* -port ports_in/*]

# Set output slack needed w.r.t. this module's clock
dc::set_output_delay 0 -clock clk [find /designs/ -port ports_out/*]
set_attribute max_transition 300 [find /designs/ -port ports_out/*]

# External interfaces are slower.
#dc::set_multicycle_path -setup 10 -from [ find / -port ssel ]
#dc::set_multicycle_path -setup 10 -from [ find / -port sin ]
#dc::set_multicycle_path -setup 10 -from [ find / -port sclk ]
# sout is allowed to take two cycles
#dc::set_multicycle_path -setup 2 -to [ find / -port sout ]
dc::set_output_delay -1000 -clock clk [find /designs/ -port sout]


# set_max_delay -from <node> -to <node> <delay>
#set_max_delay -from bufp -to current_buffer 1000
#dc::set_load_unit -femtofarads

# path_disable == dc::set_false_path
#dc::set_false_path -from [ find / -inst *bufp*] -to [ find / -inst *field_byte_out*] -exception_name bufpToFieldOut

#path_disable -from [ find / -pin *bufp* ]
#path_disable -from [ find / -pin *fieldp* ]

# path_delay == dc::set_max_delay
#dc::set_max_delay -delay 1200 -from [find / -pin *fieldp* ] -to [ find / -pin *pattern*] -exception_name fieldToPattern


#set_attribute external_driver [find [find / -libcell DFFX1] -libpin D] {/designs/adder/ports_in/*}
#set_attribute external_pin_cap 26.5488 {/designs/adder/ports_out/*}

set_attribute optimize_merge_flops false /
#synthesize -to_mapped patternbuffer


#synthesize -to_mapped -effort high patternbuffer


if {$insertScanChain == "y"} {
# SCAN CHAIN
#synthesize -to_generic

set_attribute dft_scan_style muxed_scan /
#set_attribute dft_dont_scan true {instance | subdesign | design}
define_dft test_clock -name scan_clock -period 1000 /designs/patternbuffer/ports_in/clk
define_dft shift_enable -active high /designs/patternbuffer/ports_in/ssel
# TODO: Redefine the scan enable pin! And scan in and out pins
#set_attribute dft_identify_top_level_test_clocks false / 
#set_attribute dft_identify_test_signals f

# choose what to scan and what not to
set_attribute dft_dont_scan true /designs/patternbuffer/instances_hier/theBuffers/

check_dft_rules
report dft_registers
# allow dft engine to determine if output scan is inverted or not
set_attribute dft_scan_output_preference auto patternbuffer
# map all flops that pass DFT rules to scannable
set_attr dft_scan_map_mode tdrc_pass patternbuffer
# set for synthesis drive
set_attr dft_connect_scan_data_pins_during_mapping loopback patternbuffer
set_attribute dft_prefix SCAN_ / 
report dft_setup


#synthesize -to_mapped  patternbuffer

# if already mapped, use "replace_scan" before running the next scan commands
connect_scan_chains -preview -auto_create_chains -pack

#define_dft scan_chain -name scanchain1 -sdi scan_in_pin -sdo scan_out_pin -shift_enable scan_enable

# TODO: enable below to make scan chains
#connect_scan_chains -auto_create_chains
report dft_chains > patternbuffer_scanchains
report dft_setup > patternbuffer_dftsetup


# improve timing now the scan chain is there
#synthesize -incremental -effort high

# END SCAN CHAIN
}

# request an extra 30ps slack on the register paths
set all_regs [find / -instance instances_seq/*] 
path_adjust -from $all_regs -to $all_regs -delay -20 -name slack-20_regs

synthesize -to_mapped -effort high patternbuffer


write -mapped > patternbuffer-mapped.v
#write_script > design_script.script
write_sdc > patternbuffer-mapped.sdc
write_hdl -mapped > patternbuffer-mapped.enc

report area
report gates
report clocks
report timing 

#report timing -from [find / -inst *bufp* ] -to [find / -inst *pattern*]
#report timing -from [find / -inst *fieldp* ] -to [find / -inst *pattern*]
#report timing -from [find / -inst *fieldp* ] -to [find / -inst *field_byte_out*]
