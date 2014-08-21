# PAT Pin positions

set highside_offset 2100
set lowside_offset 1500
set clock_offset 1350
set test_offset 1270

# High side patternbuffer connections
editPin -side Right -fixedPin 1 -unit TRACK -fixOverlap 1 -layer 3 -spreadType start -spacing 15 -start 1399.865 $highside_offset -pin { {field_toPAT_high[0]} {field_toPAT_high[1]} {field_toPAT_high[2]} {field_toPAT_high[3]} {field_toPAT_high[4]} {field_toPAT_high[5]} {field_toPAT_high[6]} {field_toPAT_high[7]} sout_high {bufp_high[0]} {bufp_high[1]} {bufp_high[2]} {field_fromPAT_high[0]} {field_fromPAT_high[1]} {field_fromPAT_high[2]} {field_fromPAT_high[3]} {field_fromPAT_high[4]} {field_fromPAT_high[5]} {field_fromPAT_high[6]} {field_fromPAT_high[7]} field_write_en_high {fieldp_high[0]} {fieldp_high[1]} {fieldp_high[2]} {fieldp_high[3]} {fieldp_high[4]} {fieldwp_high[0]} {fieldwp_high[1]} {fieldwp_high[2]} {fieldwp_high[3]} {fieldwp_high[4]} pwm_high reset_patternbuf_high {saddr_high[0]} {saddr_high[1]} {saddr_high[2]}  sclk_high sin_high ssel_high }


# Low side patternbuffer connections
editPin -side Right -fixedPin 1 -unit TRACK -fixOverlap 1 -layer 3 -spreadType start -spacing 15 -start 1390.163 $lowside_offset -pin  {field_fromPAT_low[0]} { field_fromPAT_low[1]} {field_fromPAT_low[2]} {field_fromPAT_low[3]} {field_fromPAT_low[4]} {field_fromPAT_low[5]} {field_fromPAT_low[6]} {field_fromPAT_low[7]} sout_low {bufp_low[0]} {bufp_low[1]} {bufp_low[2]} {field_toPAT_low[0]} {field_toPAT_low[1]} {field_toPAT_low[2]} {field_toPAT_low[3]} {field_toPAT_low[4]} {field_toPAT_low[5]} {field_toPAT_low[6]} {field_toPAT_low[7]} field_write_en_low {fieldp_low[0]} {fieldp_low[1]} {fieldp_low[2]} {fieldp_low[3]} {fieldp_low[4]} {fieldwp_low[0]} {fieldwp_low[1]} {fieldwp_low[2]} {fieldwp_low[3]} {fieldwp_low[4]} pwm_low reset_patternbuf_low {saddr_low[0]} {saddr_low[1]} {saddr_low[2]} sclk_low sin_low ssel_low }

# Clock input and select
editPin -side Right -fixedPin 1 -unit TRACK -fixOverlap 1 -layer 3 -spreadType start -spacing 15 -start 1495.065 $clock_offset -pin {clk_int pat_clock_division}

# David's test circuit connections
editPin -side Right -fixedPin 1 -unit TRACK -fixOverlap 1 -layer 3 -spreadType start -spacing 15 -start 1300 $test_offset -pin {ring_osc_start_1 ring_osc_in_1 ring_osc_start_2 ring_osc_in_2}

