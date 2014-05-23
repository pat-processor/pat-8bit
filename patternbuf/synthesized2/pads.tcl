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

# locate the components
floorPlan -site ams018hvSite -d 1500.0 3000.0 200 1100 200 200
setObjFPlanBox Module theCore 438.244 1224.107 1285.524 2569.78
setOaxMode -compressLevel 0
setMultiCpuUsage -localCpu 4 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true

# ams scripts
amsUserGrid
# connect power (both if with I/O), "core" if not
#amsGlobalConnect both
amsGlobalConnect both
#amsHVringBlk corebox
amsHVringBlk corebox 10 70


createPinGroup scanpins -cell pads -pin {scan_enable scan_in_1 scan_out_1} -spacing 4

createPinGroup field_pointers -cell pads -pin {buf_fieldp[7] buf_fieldp[6] buf_fieldp[5] buf_fieldp[4] buf_fieldp[3] buf_fieldp[2] buf_fieldp[1] buf_fieldp[0] buf_fieldwp[7] buf_fieldwp[6] buf_fieldwp[5] buf_fieldwp[4] buf_fieldwp[3] buf_fieldwp[2] buf_fieldwp[1] buf_fieldwp[0] field_write_en_low field_write_en_high} -spacing 4

createPinGroup field_in -cell pads -pin {field_toPAT_low[7] field_fromPAT[7] field_fromPAT[6] field_fromPAT[5] field_fromPAT[4] field_fromPAT[3] field_fromPAT[2] field_fromPAT[1] field_fromPAT[0]} -spacing 4

createPinGroup field_low -cell pads -pin {field_toPAT_low[7] field_toPAT_low[6] field_toPAT_low[5] field_toPAT_low[4] field_toPAT_low[3] field_toPAT_low[2] field_toPAT_low[1] field_toPAT_low[0]} -spacing 4

createPinGroup field_high -cell pads -pin {field_toPAT_high[7] field_toPAT_high[6] field_toPAT_high[5] field_toPAT_high[4] field_toPAT_high[3] field_toPAT_high[2] field_toPAT_high[1] field_toPAT_high[0]} -spacing 4

createPinGroup serial -cell pads -pin {sout sclk ssel saddr[2] saddr[1] saddr[0]} -spacing 4

createPinGroup analogueSelects -cell pads -pin {clock_select f5v_select vref_select} -spacing 4

createPinGroup clocks -cell pads -pin {clk_int} -spacing 4

createPinGuide -pingroup scanpins -cell pads -edge 2 -layer M3
createPinGuide -pingroup field_pointers -cell pads -edge 2 -layer M3
createPinGuide -pingroup field_in -cell pads -edge 2 -layer M3
createPinGuide -pingroup field_low -cell pads -edge 2 -layer M3
createPinGuide -pingroup field_high -cell pads -edge 2 -layer M3
createPinGuide -pingroup serial -cell pads -edge 2 -layer M3
createPinGuide -pingroup analogueSelects -cell pads -edge 2 -layer M3
createPinGuide -pingroup clocks -cell pads -edge 2 -layer M3



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
addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom MT top MT right AM left AM} -width 20 -spacing 10 -offset 4.9

addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 10 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 5 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -nets {gnd! vdd!} -stacked_via_bottom_layer M1


#addRing -stacked_via_top_layer AM -user_defined_region {450 2550 1250 2550 1250 1200 450 1200} -around user_defined -jog_distance 4.9 -threshold 4.9 -type block_rings -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom MT top MT right AM left AM} -width 20 -spacing 10 -offset 4.9


#addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 4 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 5 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -area {450 2600 1250 2600 1250 1140 450 1140} -nets {gnd! vdd!} -stacked_via_bottom_layer M1

# Place
setPlaceMode -congEffort auto -timingDriven 1 -modulePlan 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 1 -placeIOPins 1 -moduleAwareSpare 0 -checkPinLayerForAccess {  1 } -maxRouteLayer 5 -preserveRouting 0 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0

placeDesign -prePlaceOpt


# power routing
sroute -connect { blockPin padPin padRing corePin } -layerChangeRange { M1 AM } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer M1 -allowLayerChange 1 -targetViaTopLayer AM -crossoverViaTopLayer AM -targetViaBottomLayer M1 -nets { gnd! vdd! }
# Whatever the last sroute operation is, it breaks the via spacing, so undo it!
undo


# Fix some DRCs
editSelect -type Special -shapes STRIPE -status {ROUTED FIXED}
editTrim


# optimise for speed
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS
#optDesign -preCTS

# Fix placement DRCS
refinePlace -checkRoute 1 -preserveRouting 0 -rmAffectedRouting 0 -swapEEQ 0 -checkPinLayerForAccess 1

clockDesign -specFile Clock-pads.ctstch -outDir clock_report -fixedInstBeforeCTS
refinePlace -checkRoute 1 -preserveRouting 0 -rmAffectedRouting 0 -swapEEQ 0 -checkPinLayerForAccess 1

#report_timing

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS


# add core filler to prevent DRC violation
amsFillcore 

editPin -side Right -fixedPin 1 -unit TRACK -fixOverlap 1 -layer 3 -spreadType center -spacing 4.0 -pin {{buf_fieldp[0]} {buf_fieldp[1]} {buf_fieldp[2]} {buf_fieldp[3]} {buf_fieldp[4]} {buf_fieldp[5]} {buf_fieldp[6]} {buf_fieldp[7]} {buf_fieldwp[0]} {buf_fieldwp[1]} {buf_fieldwp[2]} {buf_fieldwp[3]} {buf_fieldwp[4]} {buf_fieldwp[5]} {buf_fieldwp[6]} {buf_fieldwp[7]} clk_int clock_select f5v_select {field_fromPAT[0]} {field_fromPAT[1]} {field_fromPAT[2]} {field_fromPAT[3]} {field_fromPAT[4]} {field_fromPAT[5]} {field_fromPAT[6]} {field_fromPAT[7]} {field_toPAT_high[0]} {field_toPAT_high[1]} {field_toPAT_high[2]} {field_toPAT_high[3]} {field_toPAT_high[4]} {field_toPAT_high[5]} {field_toPAT_high[6]} {field_toPAT_high[7]} {field_toPAT_low[0]} {field_toPAT_low[1]} {field_toPAT_low[2]} {field_toPAT_low[3]} {field_toPAT_low[4]} {field_toPAT_low[5]} {field_toPAT_low[6]} {field_toPAT_low[7]} field_write_en_high field_write_en_low {saddr[0]} {saddr[1]} {saddr[2]} scan_enable scan_in_1 scan_out_1 sclk sout ssel vref_select}

# main routing
#setNanoRouteMode -quiet -routeWithTimingDriven 1
#setNanoRouteMode -quiet -routeBottomRoutingLayer default
#setNanoRouteMode -quiet -drouteEndIteration default
#setNanoRouteMode -quiet -routeWithTimingDriven true
#setNanoRouteMode -quiet -routeWithSiDriven false
#routeDesign -globalDetail

# report and optimise timing
#timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix patternbuffer_postRoute -outDir timingReports
#setOptMode -fixCap true -fixTran true -fixFanoutLoad true

#optDesign -postRoute
#amsFillperi
