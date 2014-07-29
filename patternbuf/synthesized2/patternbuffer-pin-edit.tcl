############# DRIVER PIN CONNECTIONS ###########

# n_drive
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 50.00 -pin {{n_drive[7]} {n_drive[6]} {n_drive[5]} {n_drive[4]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 63.39 -pin {{n_drive[3]} {n_drive[2]} {n_drive[1]} {n_drive[0]}}

# tweak 0
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 77.22 -pin {tweak_enable_0 tweak_sense_0}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4.5 -start 783.52 84.15 -pin {{tweak_duration_0[0]} {tweak_duration_0[1]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4 -start 783.52 104.31 -pin {{tweak_delay_0[0]} {tweak_delay_0[1]} {tweak_delay_0[2]}}

# tweak 1
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 119.38 -pin {tweak_enable_1 tweak_sense_1}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4.5 -start 783.52 126.31 -pin {{tweak_duration_1[0]} {tweak_duration_1[1]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4 -start 783.52 146.47 -pin {{tweak_delay_1[0]} {tweak_delay_1[1]} {tweak_delay_1[2]}}

# tweak 2
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 161.54 -pin {tweak_enable_2 tweak_sense_2}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4.5 -start 783.52 168.47 -pin {{tweak_duration_2[0]} {tweak_duration_2[1]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4 -start 783.52 188.63 -pin {{tweak_delay_2[0]} {tweak_delay_2[1]} {tweak_delay_2[2]}}


# clock
editPin -side Right -unit TRACK -fixOverlap 1 -layer 2 -spreadType start -start 749.468 202.6 -pin clk

# global delay
editPin -side Right -fixedPin 1 -unit TRACK -fixOverlap 1 -layer 2 -spreadType start -spacing 1 -start 783.52 203.39 -pin {{tweak_global_delay[0]} {tweak_global_delay[1]} {tweak_global_delay[2]} {tweak_global_delay[3]} {tweak_global_delay[4]} {tweak_global_delay[5]} {tweak_global_delay[6]} {tweak_global_delay[7]}}

# tweak 3
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 221.73 -pin {tweak_enable_3 tweak_sense_3}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4.5 -start 783.52 228.66 -pin {{tweak_duration_3[0]} {tweak_duration_3[1]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4 -start 783.52 248.82 -pin {{tweak_delay_3[0]} {tweak_delay_3[1]} {tweak_delay_3[2]}}

# tweak 4
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 263.89 -pin {tweak_enable_4 tweak_sense_4}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4.5 -start 783.52 270.82 -pin {{tweak_duration_4[0]} {tweak_duration_4[1]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4 -start 783.52 290.98 -pin {{tweak_delay_4[0]} {tweak_delay_4[1]} {tweak_delay_4[2]}}

# tweak 5
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 1.4 -start 783.52 306.05 -pin {tweak_enable_5 tweak_sense_5}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4.5 -start 783.52  312.98 -pin {{tweak_duration_5[0]} {tweak_duration_5[1]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4 -start 783.52 333.14 -pin {{tweak_delay_5[0]} {tweak_delay_5[1]} {tweak_delay_5[2]}}

# p drive
editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing -1.4 -start 783.52 350.06 -pin {{p_drive[3]} {p_drive[2]} {p_drive[1]} {p_drive[0]}}

editPin -side Right -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing -1.4 -start 783.52 363.64 -pin {{p_drive[7]} {p_drive[6]} {p_drive[5]} {p_drive[4]}}

########### PAT CONNECTIONS #############

# Pat Right <- Patternbuffer Left pins. Ideal spacing 41.04um
# insufficient space on left of Patternbuffer, so move to bottom.

editPin -side Bottom -fixedPin 1 -fixOverlap 1 -layer 2 -spreadType start -spacing 4.48 -start 7.037 105.558 -pin {sout {field_byte_out[0]} {field_byte_out[1]} {field_byte_out[2]} {field_byte_out[3]} {field_byte_out[4]} {field_byte_out[5]} {field_byte_out[6]} {field_byte_out[7]}}

# Pat Right -> Patternbuffer Left pins
#
# ideally 28.7um pitch, but only space for about 25um along the side.
# Either:
#editPin -side Left -fixOverlap 1 -layer 3 -spreadType side -pin {{bufp_in[0]} {bufp_in[1]} {bufp_in[2]} clk {field_in_in[0]} {field_in_in[1]} {field_in_in[2]} {field_in_in[3]} {field_in_in[4]} {field_in_in[5]} {field_in_in[6]} {field_in_in[7]} field_write_in {fieldp_in[0]} {fieldp_in[1]} {fieldp_in[2]} {fieldp_in[3]} {fieldp_in[4]} {fieldwp_in[0]} {fieldwp_in[1]} {fieldwp_in[2]} {fieldwp_in[3]} {fieldwp_in[4]} pwm reset {saddr[0]} {saddr[1]} {saddr[2]} sclk sin ssel}

# or
editPin -side Left -pinWidth 0.28 -pinDepth 1.12 -fixOverlap 1 -layer 2 -spreadType start -spacing 25 -start 0.0 0.28 -pin {{bufp_in[0]} {bufp_in[1]} {bufp_in[2]} {field_in_in[0]} {field_in_in[1]} {field_in_in[2]} {field_in_in[3]} {field_in_in[4]} {field_in_in[5]} {field_in_in[6]} {field_in_in[7]} field_write_in {fieldp_in[0]} {fieldp_in[1]} {fieldp_in[2]} {fieldp_in[3]} {fieldp_in[4]} {fieldwp_in[0]} {fieldwp_in[1]} {fieldwp_in[2]} {fieldwp_in[3]} {fieldwp_in[4]} pwm reset {saddr[0]} {saddr[1]} {saddr[2]} sclk sin ssel}


