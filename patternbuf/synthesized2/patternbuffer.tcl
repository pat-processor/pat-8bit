source utility.tcl

## BEGIN SCRIPT

puts "Set script into interactive mode? y/n"
set answer [gets stdin]
set interactive [string compare $answer "y"]

# load
set defHierChar /
set conf_gen_footprint 1
set fp_core_to_left 50.000000
set fp_core_to_right 50.000000
set init_oa_ref_lib {TECH_H18A6 CORELIB_HV IOLIB_HV_6AM }
set lsgOCPGainMult 1.000000
set conf_ioOri R0
set init_verilog patternbuffer-mapped.v
set fp_core_util 0.850000
set init_pwr_net {vdd! vdd5vl! vdd5vr! vdd5vo! trig1v8! trig5v! por5vr!}
set init_mmmc_file patternbuffer-mapped.view
set init_assign_buffer 0
set init_top_cell patternbuffer
set conf_in_tran_delay 0.1ps
set conf_qxconf_file NULL
set init_import_mode { -keepEmptyModule 1 -treatUndefinedCellAsBbox 0}
set conf_qxlib_file NULL
set fp_core_to_top 50.000000
set init_gnd_net {gnd! gnd5vl! gnd5vr! gnd5vo! subc5v! subc! }
set init_abstract_view abstract
set fp_core_to_bottom 50.000000
# Below if a view file has not been specified above
#create_rc_corner -name HV_TYP -cap_table {H18/cds/HK_H18/LEF/h18a6/h18a6.capTable} -T {25} -preRoute_res {1.0} -preRoute_cap {1.0} -preRoute_clkres {0.0} -preRoute_clkcap {0.0} -postRoute_res {1.0} -postRoute_cap {1.0} -postRoute_xcap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} -qx_tech_file {H18/cds/HK_H18/LEF/h18a6/h18a6.tch}
#create_op_cond -name HV_TYP -library_file {H18/liberty/h18_1.8V/h18_CORELIB_HV_TYP.lib} -P {10.0} -V {10.0} -T {10.0}
#create_library_set -name HV_TYP -timing {H18/liberty/h18_1.8V/h18_CORELIB_HV_TYP.lib H18/liberty/h18_1.8V/h18_IOLIB_HV_TYP.lib}
#create_constraint_mode -name HV_TYP-constraint -sdc_files {patternbuffer-mapped.sdc}
#create_delay_corner -name HV_TYP -library_set {HV_TYP} -rc_corner {HV_TYP}
#create_analysis_view -name HV_TYP -constraint_mode {HV_TYP-constraint} -delay_corner {HV_TYP}
init_design
set_analysis_view -setup {HV_TYP} -hold {HV_TYP}

setOaxMode -compressLevel 0

# end load

# floorplan
#floorPlan -site ams018hvSite -r 0.985468919242 0.50 100 100 100 100
floorPlan -site ams018hvSite -r 0.985468919242 0.50 50 70 50 70
selectObject Module theBuffers
setObjFPlanBox Module theBuffers 54.320 56.225 698.392 680.400

# ams scripts
amsUserGrid
# connect power (both if with I/O), "core" if not
#amsGlobalConnect both
amsGlobalConnect core
#amsHVringBlk corebox
#amsHVringBlk corebox 10 70
amsHVringBlk corebox 10 30

# create pin groups
createPinGroup tweak0 -cell patternbuffer -pin {tweak_enable_0 tweak_sense_0 tweak_delay_0[2] tweak_delay_0[1] tweak_delay_0[0] tweak_duration_0[1] tweak_duration_0[0]} -spacing 4

createPinGroup tweak1 -cell patternbuffer -pin {tweak_enable_1 tweak_sense_1 tweak_delay_1[2] tweak_delay_1[1] tweak_delay_1[0] tweak_duration_1[1] tweak_duration_1[0]} -spacing 4

createPinGroup tweak2 -cell patternbuffer -pin {tweak_enable_2 tweak_sense_2 tweak_delay_2[2] tweak_delay_2[1] tweak_delay_2[0] tweak_duration_2[1] tweak_duration_2[0]} -spacing 4

createPinGroup tweak3 -cell patternbuffer -pin {tweak_enable_3 tweak_sense_3 tweak_delay_3[2] tweak_delay_3[1] tweak_delay_3[0] tweak_duration_3[1] tweak_duration_3[0]} -spacing 4

createPinGroup tweak4 -cell patternbuffer -pin {tweak_enable_4 tweak_sense_4 tweak_delay_4[2] tweak_delay_4[1] tweak_delay_4[0] tweak_duration_4[1] tweak_duration_4[0]} -spacing 4

createPinGroup tweak5 -cell patternbuffer -pin {tweak_enable_5 tweak_sense_5 tweak_delay_5[2] tweak_delay_5[1] tweak_delay_5[0] tweak_duration_5[1] tweak_duration_5[0]} -spacing 4

createPinGroup tweakdelay -cell patternbuffer -pin {{tweak_global_delay[0]} {tweak_global_delay[1]} {tweak_global_delay[2]} {tweak_global_delay[3]} {tweak_global_delay[4]} {tweak_global_delay[5]} {tweak_global_delay[6]} {tweak_global_delay[7]}} -spacing 4

createPinGroup ndrive -cell patternbuffer -pin {{n_drive[0]} {n_drive[1]} {n_drive[2]} {n_drive[3]} {n_drive[4]} {n_drive[5]} {n_drive[6]} {n_drive[7]}} -spacing 4

createPinGroup pdrive -cell patternbuffer -pin {{p_drive[0]} {p_drive[1]} {p_drive[2]} {p_drive[3]} {p_drive[4]} {p_drive[5]} {p_drive[6]} {p_drive[7]}} -spacing 4


createPinGuide -pingroup tweak0 -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup tweak1 -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup tweak2 -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup tweak3 -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup tweak4 -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup tweak5 -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup tweakdelay -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup ndrive -cell patternbuffer -edge 2 -layer M3
createPinGuide -pingroup pdrive -cell patternbuffer -edge 2 -layer M3


# PAT connections
createPinGroup patpins -cell patternbuffer -pin {{field_byte_out[0]} {field_byte_out[1]} {field_byte_out[2]} {field_byte_out[3]} {field_byte_out[4]} {field_byte_out[5]} {field_byte_out[6]} {field_byte_out[7]} {field_in_in[0]} {field_in_in[1]} {field_in_in[2]} {field_in_in[3]} {field_in_in[4]} {field_in_in[5]} {field_in_in[6]} {field_in_in[7]} field_write_in {fieldp_in[0]} {fieldp_in[1]} {fieldp_in[2]} {fieldp_in[3]} {fieldp_in[4]} {fieldwp_in[0]} {fieldwp_in[1]} {fieldwp_in[2]} {fieldwp_in[3]} {fieldwp_in[4]} {bufp_in[0]} {bufp_in[1]} {bufp_in[2]}} -spacing 4

createPinGuide -pingroup patpins -cell patternbuffer -edge 0 -layer M3


# Do the work!
#addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom MT top MT right AM left AM} -width 20 -spacing 10 -offset 10
addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom M1 top M1 right AM left AM} -width {left 10 bottom 20 top 20 right 10} -spacing 10 -offset 4.9

addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 4 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 5 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -nets {gnd! vdd!} -stacked_via_bottom_layer M1

# Fix some DRCs
editSelect -type Special -shapes STRIPE -status {ROUTED FIXED}
editTrim

setMultiCpuUsage -localCpu 4 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true


setPlaceMode -congEffort auto -timingDriven 1 -modulePlan 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 1 -placeIOPins 1 -moduleAwareSpare 0 -checkPinLayerForAccess {  1 } -maxRouteLayer 5 -preserveRouting 0 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0

placeDesign -prePlaceOpt


# Fix digital pins in aligned location for pat component
# Call the script with exact pin placements
source patternbuffer-pin-edit.tcl

# after 2000 # pause for 2s
next "Design placed. Continue y/n"

# power routing
sroute -connect { blockPin padPin padRing corePin } -layerChangeRange { M1 AM } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer M1 -allowLayerChange 1 -targetViaTopLayer AM -crossoverViaTopLayer AM -targetViaBottomLayer M1 -nets { gnd! vdd! }
# Whatever the last sroute operation is, it breaks the via spacing, so undo it!
undo
#redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
#amsPowerRoute

# optimise for speed
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS
optDesign -preCTS

clockDesign -specFile Clock.ctstch -outDir clock_report -fixedInstBeforeCTS

report_timing

next "Clock tree synthesized. Optimize? y/n"

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS


# main routing
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail

# report and optimise timing
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix patternbuffer_postRoute -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad true

next "Design routed. Optimise? y/n"

# from AMS FAQ
optDesign -postRoute

# add core filler to prevent DRC violation

next "Design optimsed. Add filler? y/n"
amsFillcore 


# wroute -wdbName final.wdb
# optDesign -postRoute -noECORoute
# wroute -wdbName final.wdb -mode incrPostRouteRepair

#optDesign -postRoute

# save result
#saveDesign -cellview {patternbuffer patternbuffer layout}

# open GUI
win
