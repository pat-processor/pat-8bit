source utility.tcl

puts "Set script into interactive mode? y/n"
set answer [gets stdin]
set interactive [string compare $answer "y"]

# load
set defHierChar /
set locv_inter_clock_use_worst_derate false
set conf_gen_footprint 1
set fp_core_to_left 50.000000
set fp_core_to_right 50.000000
set init_io_file pads.io
set init_oa_ref_lib {TECH_H18A6 CORELIB_HV IOLIB_HV_6AM}
set init_oa_search_lib {}
set lsgOCPGainMult 1.000000
set conf_ioOri R0
set init_verilog pads-mapped.v
set fp_core_util 0.850000
set init_pwr_net {vdd! vdd1v8l! vdd1v8r! vdd1v8o! por1v8r! trig1v8! vdd5vl! vdd5vr! vdd5vo! trig5v! por5vr!}
set init_mmmc_file pads.view
set delaycal_input_transition_delay 0.1ps
set init_assign_buffer 0
set init_top_cell pads
set conf_in_tran_delay 0.1ps
set init_import_mode { -keepEmptyModule 1 -treatUndefinedCellAsBbox 0}
set fpIsMaxIoHeight 0
set fp_core_to_top 50.000000
set init_gnd_net {gnd! gnd1v8l! gnd1v8r! gnd1v8o! subc1v8! gnd5vl! gnd5vr! gnd5vo! subc5v! subc!}
set init_abstract_view abstract
set timing_case_analysis_for_icg_propagation false
set fp_core_to_bottom 50.000000


init_design
set_analysis_view -setup {HV_TYP} -hold {HV_TYP}

# Add I/O filler to complete pad rings. Do before floorplan since tool
# won't consider those outside floorplan
#amsFillperi
# locate the components
#                                             left btm right top
# -200um
# below will have some I/O pads out of routing range.
floorPlan -site ams018hvSite -d 1270.0 3000.0 100 1100 100 100

# below is big enough to encompass the I/O pads.
#floorPlan -site ams018hvSite -d 3000.0 3000.0 100.43 1100.03 1830.0 100.0


# 50% util
#setObjFPlanBox Module theCore 435.680 1331.680 1395.155 2571.520
# -100um
#setObjFPlanBox Module theCore 328.720 1326.955 1288.000 2672.320
# -200um
setObjFPlanBox Module theCore 328.720 1326.640 1199.442 2672.320
# -230um
#setObjFPlanBox Module theCore 297.16 1326.64 1167.96 2672.32
# 60% util
#setObjFPlanBox Module theCore 428.400 1335.939 1183.280 2566.480
# 70% util
#setObjFPlanBox Module theCore 428.400 1336.720 1093.470 2566.480
# blockage width 750 height 750 X 635 Y 340 Layers All
createRouteBlk -layer {M1 M2 M3 M4 MT AM} -box {300 430 1050 1180}
#createRouteBlk -layer {M1 M2 M3 M4 MT AM} -box {1300 400 2100 1210}

# move corner pads closer to corners.
#setObjFPlanBox Instance iopad_a4 0.262 2680.395 226.872 2768.895
#setObjFPlanBox Instance iopad_a3 230.162 2774.571 318.662 3001.181
#setObjFPlanBox Instance iopad_b5 1.634 232.024 228.244 320.524
#setObjFPlanBox Instance iopad_b6 232.612 0.0 321.112 226.61


#setObjFPlanPolygon Cell {pads} 0.0000 0.0000 0.0000 3000.0000 3000.0000 3000.0000 3000.0000 2753.4400 1242.7300 2753.4400 1242.7300 284.7700 3000.0000 284.7700 3000.0000 0.0000 0.0000 0.0000

# too small setObjFPlanPolygon Cell {pads} 0.0000 0.0000 0.0000 2998.1300 2700.0000 2998.1300 2700.0000 2636.4100 1224.8500 2636.4100 1224.8500 387.4800 2700.0000 387.4800 2700.0000 0.0000 0.0000 0.0000



setOaxMode -compressLevel 0
setMultiCpuUsage -localCpu 4 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true



createPinGroup patternbuffer_high -cell pads -pin {pwm_high reset_patternbuf_high sout_high field_toPAT_high[7] field_toPAT_high[6] field_toPAT_high[5] field_toPAT_high[4] field_toPAT_high[3] field_toPAT_high[2] field_toPAT_high[1] field_toPAT_high[0] sclk_high sin_high ssel_high saddr_high[2] saddr_high[1] saddr_high[0] bufp_high[2] bufp_high[1] bufp_high[0] fieldp_high[4] fieldp_high[3] fieldp_high[2] fieldp_high[1] fieldp_high[0] fieldwp_high[4] fieldwp_high[3] fieldwp_high[2] fieldwp_high[1] fieldwp_high[0] field_write_en_high field_fromPAT_high[7] field_fromPAT_high[6] field_fromPAT_high[5] field_fromPAT_high[4] field_fromPAT_high[3] field_fromPAT_


# ams scripts
amsUserGrid
# connect power (both if with I/O), "core" if not
#amsGlobalConnect both
amsGlobalConnect both
#amsHVringBlk corebox
#amsHVringBlk corebox 10 70
#amsHVringBlk corebox 10 30

globalNetConnect vdd1v8l! -type pgpin -pin vdd1v8l! -inst * -module {}
globalNetConnect vdd1v8r! -type pgpin -pin vdd1v8r! -inst * -module {}
globalNetConnect vdd1v8o! -type pgpin -pin vdd1v8o! -inst * -module {}
globalNetConnect por1v8r! -type pgpin -pin por1v8r! -inst * -module {}
globalNetConnect trig1v8! -type pgpin -pin trig1v8! -inst * -module {}

globalNetConnect gnd1v8l! -type pgpin -pin gnd1v8l! -inst * -module {}
globalNetConnect gnd1v8r! -type pgpin -pin gnd1v8r! -inst * -module {}
globalNetConnect gnd1v8o! -type pgpin -pin gnd1v8o! -inst * -module {}
globalNetConnect subc1v8! -type pgpin -pin subc1v8! -inst * -module {}

globalNetConnect vdd! -type pgpin -pin vdd! -inst * -module {}
globalNetConnect gnd! -type pgpin -pin gnd! -inst * -module {}


selectObject Module theCore
#addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom M1 top M1 right AM left AM} -width 20 -spacing 10 -offset 4.9
addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom M1 top M1 right AM left AM} -width {left 10 bottom 20 top 20 right 10} -spacing 10 -offset 4.9

addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 5 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -nets {gnd! vdd!} -stacked_via_bottom_layer M1

high[2] field_fromPAT_high[1] field_fromPAT_high[0]} -spacing 4

createPinGroup patternbuffer_low -cell pads -pin {pwm_low reset_patternbuf_low field_toPAT_low[7] field_toPAT_low[6] field_toPAT_low[5] field_toPAT_low[4] field_toPAT_low[3] field_toPAT_low[2] field_toPAT_low[1] field_toPAT_low[0] sout_low sin_low sclk_low ssel_low saddr_low[2] saddr_low[1] saddr_low[0] bufp_low[2] bufp_low[0] bufp_low[1] fieldp_low[4] fieldp_low[3] fieldp_low[2] fieldp_low[1] fieldp_low[0] fieldwp_low[4] fieldwp_low[3] fieldwp_low[2] fieldwp_low[1] fieldwp_low[0] field_write_en_low field_fromPAT_low[7] field_fromPAT_low[6] field_fromPAT_low[5] field_fromPAT_low[4] field_fromPAT_low[3] field_fromPAT_low[2] field_fromPAT_low[1] field_fromPAT_low[0]} -spacing 4


createPinGroup selects -cell pads -pin {clock_external} -spacing 4


createPinGroup clocks -cell pads -pin {clk_int} -spacing 4

createPinGuide -pingroup patternbuffer_high -cell pads -edge 2 -layer M3
createPinGuide -pingroup patternbuffer_low -cell pads -edge 2 -layer M3
createPinGuide -pingroup selects -cell pads -edge 2 -layer M3
createPinGuide -pingroup clocks -cell pads -edge 2 -layer M3


# ams scripts
amsUserGrid
# connect power (both if with I/O), "core" if not
#amsGlobalConnect both
amsGlobalConnect both
#amsHVringBlk corebox
#amsHVringBlk corebox 10 75

globalNetConnect vdd1v8l! -type pgpin -pin vdd1v8l! -inst * -module {}
globalNetConnect vdd1v8r! -type pgpin -pin vdd1v8r! -inst * -module {}
globalNetConnect vdd1v8o! -type pgpin -pin vdd1v8o! -inst * -module {}
globalNetConnect por1v8r! -type pgpin -pin por1v8r! -inst * -module {}
globalNetConnect trig1v8! -type pgpin -pin trig1v8! -inst * -module {}

globalNetConnect gnd1v8l! -type pgpin -pin gnd1v8l! -inst * -module {}
globalNetConnect gnd1v8r! -type pgpin -pin gnd1v8r! -inst * -module {}
globalNetConnect gnd1v8o! -type pgpin -pin gnd1v8o! -inst * -module {}
globalNetConnect subc1v8! -type pgpin -pin subc1v8! -inst * -module {}

globalNetConnect vdd! -type pgpin -pin vdd! -inst * -module {}
globalNetConnect gnd! -type pgpin -pin gnd! -inst * -module {}


selectObject Module theCore
addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom M1 top M1 right AM left AM} -width {left 15 bottom 30 top 30 right 15} -spacing 10 -offset 4.9


addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 5 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -nets {gnd! vdd!} -stacked_via_bottom_layer M1

# Allow cut-outs!!!
setPreference EnableRectilinearDesign 1
puts "--> Adding cut-out"
#setObjFPlanPolygon Cell {pads} 0.0000 0.0000 0.0000 3000.0000 3000.0000 3000.0000 3000.0000 2700 1271.0000 2700 1271.0000 1291.5600 3000.0000 1291.5600 3000.0000 0.0000 0.0000 0.0000


puts "--> Adjusting pins"
# Edit pin positions
source pads-pin-edit.tcl

#addRing -stacked_via_top_layer AM -user_defined_region {450 2550 1250 2550 1250 1200 450 1200} -around user_defined -jog_distance 4.9 -threshold 4.9 -type block_rings -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom MT top MT right AM left AM} -width 20 -spacing 10 -offset 4.9


#addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 4 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 5 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -area {450 2600 1250 2600 1250 1140 450 1140} -nets {gnd! vdd!} -stacked_via_bottom_layer M1


sjhHVringBlk 10 45 75

next "Begin placement? y/n"

# Place
puts "--> Setting place mode"
setPlaceMode -congEffort auto -timingDriven 1 -modulePlan 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 1 -placeIOPins 1 -moduleAwareSpare 0 -checkPinLayerForAccess {  1 } -maxRouteLayer 5 -preserveRouting 0 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0
puts "--> placingDesign"
placeDesign -prePlaceOpt

puts "--> Adjusting pins"
# Edit pin positions
source pads-pin-edit.tcl


puts "--> Performing power routing"
# power routing
sroute -connect { blockPin padPin padRing corePin } -layerChangeRange { M1 AM } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer M1 -allowLayerChange 1 -targetViaTopLayer AM -crossoverViaTopLayer AM -targetViaBottomLayer M1 -nets { gnd! vdd! }
# Whatever the last sroute operation is, it breaks the via spacing, so undo it!
undo


# Fix some DRCs
editSelect -type Special -shapes STRIPE -status {ROUTED FIXED}
editTrim
#editPowerVia -via_columns 3 -bottom_layer M1 -modify_vias 1 -via_rows 1 -top_layer AM

next "Begin post-power optimisation? y/n"

# optimise for speed
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS
#optDesign -preCTS

next "Clock design? y/n"

clockDesign -specFile Clock-pads.ctstch -outDir clock_report -fixedInstBeforeCTS

#report_timing

next "Post-clock opt? y/n"

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS


next "Begin routing? y/n"

# main routing
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail

next "Post-route optimisation? y/n"

# report and optimise timing
#timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix patternbuffer_postRoute -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute

next "Add filler? y/n"

# add core filler to prevent DRC violation
amsFillcore
amsFillperi

set_interactive_constraint_modes [all_constraint_modes -active]
