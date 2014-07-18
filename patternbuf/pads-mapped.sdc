# ####################################################################

#  Created by Encounter(R) RTL Compiler v11.20-s017_1 on Fri Jul 18 12:57:08 +0100 2014

# ####################################################################

set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1000.0ps

# Set the current design
current_design pads

create_clock -name "clk" -add -period 1.0 -waveform {0.0 0.5} [get_ports clk_int]
set_multicycle_path -from [list \
  [get_ports clk_int]  \
  [get_ports sout_low]  \
  [get_ports sout_high]  \
  [get_ports {field_toPAT_low[7]}]  \
  [get_ports {field_toPAT_low[6]}]  \
  [get_ports {field_toPAT_low[5]}]  \
  [get_ports {field_toPAT_low[4]}]  \
  [get_ports {field_toPAT_low[3]}]  \
  [get_ports {field_toPAT_low[2]}]  \
  [get_ports {field_toPAT_low[1]}]  \
  [get_ports {field_toPAT_low[0]}]  \
  [get_ports {field_toPAT_high[7]}]  \
  [get_ports {field_toPAT_high[6]}]  \
  [get_ports {field_toPAT_high[5]}]  \
  [get_ports {field_toPAT_high[4]}]  \
  [get_ports {field_toPAT_high[3]}]  \
  [get_ports {field_toPAT_high[2]}]  \
  [get_ports {field_toPAT_high[1]}]  \
  [get_ports {field_toPAT_high[0]}]  \
  [get_ports pad_vdd_core]  \
  [get_ports pad_gnd_core]  \
  [get_ports pad_vdd_1v8_all]  \
  [get_ports pad_gnd_all]  \
  [get_ports pad_clock_out]  \
  [get_ports pad_clock_in]  \
  [get_ports pad_pwm_high]  \
  [get_ports pad_pwm_low]  \
  [get_ports pad_modesel_0]  \
  [get_ports pad_modesel_1]  \
  [get_ports pad_io_a0]  \
  [get_ports pad_io_a1]  \
  [get_ports pad_io_a2]  \
  [get_ports pad_io_a3]  \
  [get_ports pad_io_a4]  \
  [get_ports pad_io_a5]  \
  [get_ports pad_io_a6]  \
  [get_ports pad_io_a7]  \
  [get_ports pad_io_b0]  \
  [get_ports pad_io_b1]  \
  [get_ports pad_io_b2]  \
  [get_ports pad_io_b3]  \
  [get_ports pad_io_b4]  \
  [get_ports pad_io_b5]  \
  [get_ports pad_io_b6]  \
  [get_ports pad_io_b7]  \
  [get_ports pad_clock_select]  \
  [get_ports pad_vref_select]  \
  [get_ports pad_f5v_select] ] -setup -end 4
set_multicycle_path -from [list \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[0]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[1]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[2]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[3]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[4]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[5]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[6]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[7]}]  \
  [get_cells {theCore/thePAT/thePC/pc_out_reg[8]}] ] -to [list \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][0]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][10]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][11]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][12]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][13]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][14]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][15]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][16]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][17]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][18]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][19]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][1]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][2]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][3]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][4]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][5]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][6]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][7]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][8]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[0][9]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][0]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][10]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][11]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][12]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][13]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][14]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][15]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][16]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][17]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][18]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][19]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][1]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][2]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][3]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][4]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][5]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][6]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][7]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][8]}]  \
  [get_cells {theCore/iBuffer_i_buffer_reg[1][9]}] ] -setup -end 2
set_clock_gating_check -setup 0.0 
set_ideal_network [get_ports pad_modesel_0]
set_ideal_network [get_pins iopad_modesel_0/Y]
set_wire_load_mode "enclosed"
set_wire_load_selection_group "sub_micron" -library "h18_CORELIB_HV_TYP"
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/BUSHDX1_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/FILLCELLX1_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/FILLCELLX2_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/FILLCELLX4_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/FILLCELLX8_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/FILLCELLX16_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/FILLCELLX32_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/TIE0_HV]
set_dont_use [get_lib_cells h18_CORELIB_HV_TYP/TIE1_HV]
set_dont_use [get_lib_cells h18_IOLIB_HV_TYP/IOPAD5V_20_HV]
set_dont_use [get_lib_cells h18_IOLIB_HV_TYP/IOPAD5V_3_HV]
set_dont_use [get_lib_cells h18_IOLIB_HV_TYP/IOPAD5V_8_HV]
set_dont_use [get_lib_cells h18_IOLIB_HV_TYP/IOPAD1V8_20_HV]
set_dont_use [get_lib_cells h18_IOLIB_HV_TYP/IOPAD1V8_3_HV]
set_dont_use [get_lib_cells h18_IOLIB_HV_TYP/IOPAD1V8_8_HV]
