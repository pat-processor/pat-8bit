set defHierChar /
set conf_gen_footprint 1
set fp_core_to_left 50.000000
set fp_core_to_right 50.000000
set init_io_file corners.io
set init_oa_ref_lib {TECH_H18A6 CORELIB_HV IOLIB_HV_6AM }
set lsgOCPGainMult 1.000000
set conf_ioOri R0
set init_verilog pads-mapped.v
set fp_core_util 0.850000
set init_pwr_net {vdd! vdd5vl! vdd5vr! vdd5vo! trig1v8! trig5v! por5vr!}
set init_assign_buffer 0
set init_top_cell pads
set conf_in_tran_delay 0.1ps
set conf_qxconf_file NULL
set init_import_mode { -keepEmptyModule 1 -treatUndefinedCellAsBbox 0}
set conf_qxlib_file NULL/home/staff/simon/linux/pat/patternbuf/synthesized/H18/cds/HK_H18/LEF
set fp_core_to_top 50.000000
set init_gnd_net {gnd! gnd5vl! gnd5vr! gnd5vo! subc5v! subc! }
set init_abstract_view abstract
set fp_core_to_bottom 50.000000
init_design
floorPlan -site ams018hvSite -r 0.992100174299 0.75 50.4 50.4 50.0 50.0
setObjFPlanBox Module theCore 282.769 272.539 1512.87 1484.395
amsUserGrid
amsGlobalConnect both
amsHVringBlk corebox

addRing -stacked_via_top_layer AM -around core -jog_distance 4.9 -threshold 4.9 -nets {gnd! vdd!} -stacked_via_bottom_layer M1 -layer {bottom MT top MT right AM left AM} -width 10 -spacing 2.8 -offset 4.9

addStripe -block_ring_top_layer_limit AM -max_same_layer_jog_length 4 -padcore_ring_bottom_layer_limit M4 -set_to_set_distance 100 -stacked_via_top_layer AM -padcore_ring_top_layer_limit AM -spacing 2.8 -merge_stripes_value 4.9 -direction horizontal -layer MT -block_ring_bottom_layer_limit M4 -width 10 -nets {gnd! vdd!} -stacked_via_bottom_layer M1

setMultiCpuUsage -localCpu 2 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true

setPlaceMode -congEffort auto -timingDriven 1 -modulePlan 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 1 -placeIOPins 1 -moduleAwareSpare 0 -checkPinLayerForAccess {  1 } -maxRouteLayer 5 -preserveRouting 0 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0

placeDesign -prePlaceOpt
# Below fails due to "Timing Library is not loaded yet"
#setOptMode -fixCap true -fixTran true -fixFanoutLoad false
#optDesign -preCTS
