set_attribute lib_search_path /home/research/software/asic/kits/ams/H18/liberty/h18_1.8V
set_attribute library {h18_CORELIB_HV_TYP.lib h18_IOLIB_HV_TYP.lib}

set_attribute information_level 2

#set_attribute preserve true MUX4X1_HV
#set_attribute preserve true MUX2X1_HV
#set_attribute preserve true MUX4X1_HV
#set_attribute preserve true MUX2X1_HV
#set_attribute preserve true DFSX1_HV
#set_attribute preserve true DFSX3_HV

read_hdl -sv patternbuf.v
read_hdl -sv buffers.v
read_hdl -sv patternbuffer.v

# Scan chain commands
#set_attribute dft_scan_type muxed_scan /
#set_attribute dft_dont_scan true testbench
#define_dft test_clock -period 10000

# enable clock gating

#set_attribute lp_clock_gating_min_flops 3 [find /designs -design testbench]
#set_attribute lp_asserted_toggle_rate 0.01 /


#set_attribute lp_clock_gating_cell [find / -libcell LGNX6_HV] /designs/patternbuffer
#set_attribute lp_insert_clock_gating true /

elaborate patternbuffer

#set_attribute lp_clock_gating_test_signal *ssel* /
#report clock_gating -preview -gated_ff -clock_pin clk


set clock [define_clock -period 1000 -name clk [find / -port clk]]
set clock [define_clock -period 100000 -name sclk [find / -port sclk]]
# set_max_delay -from <node> -to <node> <delay>
#set_max_delay -from bufp -to current_buffer 1000
#external_delay -output 2000 [find / -port ports_out/*]
dc::current_design patternbuffer
dc::set_time_unit -picoseconds
#dc::set_load_unit -femtofarads
#dc::set_output_delay 2000 -clock sclk [all_outputs]

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
