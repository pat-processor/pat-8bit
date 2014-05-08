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

# end load

# floorplan
floorPlan -site ams018hvSite -r 0.999130170932 0.50 50.4 50.4 50.0 50.0
selectObject Module theBuffers
setObjFPlanBox Module theBuffers 60.925 70.976 681.829 684.908

amsUserGrid
# connect power (both if with I/O), "core" if not
#amsGlobalConnect both
amsGlobalConnect core
amsHVringBlk corebox

# Do the work!
addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom MT top MT right AM left AM} -width 10 -spacing 2.8 -offset 4.9

addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 4 -padcore_ring_bottom_layer_limit MT -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 2.8 -merge_stripes_value 4.9 -layer AM -block_ring_bottom_layer_limit MT -width 10 -nets {gnd! vdd!} -stacked_via_bottom_layer M1

setMultiCpuUsage -localCpu 4 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true

setPlaceMode -congEffort auto -timingDriven 1 -modulePlan 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 1 -placeIOPins 1 -moduleAwareSpare 0 -checkPinLayerForAccess {  1 } -maxRouteLayer 5 -preserveRouting 0 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0

placeDesign -prePlaceOpt


# power routing
sroute -connect { blockPin padPin padRing corePin } -layerChangeRange { M1 AM } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer M1 -allowLayerChange 1 -targetViaTopLayer AM -crossoverViaTopLayer AM -targetViaBottomLayer M1 -nets { gnd! vdd! }
# Whatever the last sroute operation is, it breaks the via spacing, so undo it!
undo
#redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
#amsPowerRoute

# optimise for speed
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -preCTS

clockDesign -specFile Clock.ctstch -outDir clock_report -fixedInstBeforeCTS

report_timing

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

# from AMS FAQ
optDesign -postRoute -setup -noECORoute
# TODO: Now need to invoke wroute with options Continue Final Route after Buffer Insertion and Gate Resizing


# wroute -wdbName final.wdb
# optDesign -postRoute -noECORoute
# wroute -wdbName final.wdb -mode incrPostRouteRepair

#optDesign -postRoute

# save result
saveDesign -cellview {patternbuffer patternbuffer layout}

# open GUI
win
