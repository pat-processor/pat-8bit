#set_attribute preserve true MUX4X1_HV
#set_attribute preserve true MUX2X1_HV
#set_attribute preserve true MUX4X3_HV
#set_attribute preserve true MUX2X3_HV
#set_attribute preserve true MUX4X6_HV
#set_attribute preserve true MUX2X6_HV
#set_attribute preserve true DFSX1_HV
#set_attribute preserve true DFSX3_HV

# perhaps lef is overridden by the PHYSICAL.lib?
#set_attribute lef_library /home/research/software/asic/kits/ams/H18/cds/HK_H18/LEF/h18a6/CORELIB_HV.lef

read_hdl -sv patternbuf.v
read_hdl -sv buffers.v
read_hdl -sv testbench2.v

# set toggle probabilities
#set_attribute lp_asserted_toggle_rate 0.01 *pattern*

# enable clock gating
set_attribute lp_insert_clock_gating true /
#set_attribute lp_clock_gating_min_flops 3 [find /designs -design testbench]

elaborate testbench

report clock_gating -preview -gated_ff -clock_pin clk

# May need to explicitly connect the test signals using e.g.
#set_att lp_clock_gating_test_signal test_signal_path /de*/design

set clock [define_clock -period 1000 -name clk [find / -port clk]]
set clock [define_clock -period 100000 -name sclk [find / -port sclk]]
# set_max_delay -from <node> -to <node> <delay>
#set_max_delay -from bufp -to current_buffer 1000
#external_delay -output 2000 [find / -port ports_out/*]
dc::current_design testbench
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
set_attribute lp_clock_gating_cell [find / -libcell LGPX1_HV] /designs/testbench
clock_gating insert_in_netlist
synthesize -to_mapped testbench
#synthesize -to_mapped -effort high


write -mapped > testbench_mapped.v
write_script > testbench_script.script
write_sdc > testbench_timing.sdc
write_hdl -mapped > testbench.enc

report area
report gates
report clocks
report timing 

report timing -from [find / -inst *buffer_select* ] -to [find / -inst *pattern*]
report timing -from [find / -inst *fieldp* ] -to [find / -inst *field_byte_out*]
