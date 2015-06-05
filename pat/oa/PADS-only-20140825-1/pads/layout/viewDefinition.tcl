create_library_set -name HV_TYP\
   -timing\
    [list H18/liberty/h18_1.8V/h18_CORELIB_HV_TYP.lib\
    H18/liberty/h18_1.8V/h18_IOLIB_HV_TYP.lib\
    H18/liberty/h18_1.8V/h18_PHYSICAL.lib]
create_op_cond -name HV_TYP -library_file H18/liberty/h18_1.8V/h18_CORELIB_HV_TYP.lib -P 10 -V 1.8 -T 25
create_rc_corner -name HV_TYP\
   -cap_table H18/cds/HK_H18/LEF/h18a6/h18a6.capTable\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 25
create_delay_corner -name HV_TYP\
   -library_set HV_TYP\
   -rc_corner HV_TYP
create_constraint_mode -name HV_TYP\
   -sdc_files\
    [list pads-mapped.sdc]
create_analysis_view -name HV_TYP -constraint_mode HV_TYP -delay_corner HV_TYP
set_analysis_view -setup [list HV_TYP] -hold [list HV_TYP]
