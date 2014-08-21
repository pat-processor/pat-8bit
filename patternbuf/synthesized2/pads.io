######################################################
#                                                    #
#  Owner: Simon Hollis 	                             #
#  HIT-Kit: Digital                                  #
#                                                    #
#  Encounter Pad placement file                      #
#      Version: 20-May-2014                          #
######################################################


(globals
	version = 3
	io_order = counterclockwise
)

(iopad
  (topleft
	(inst
		name = CORNER_TL
		orientation = r270
		cell = CORNER_HV
	)
		
  )

  (bottomleft
	(inst
		name = CORNER_BL
		orientation = r0
		cell = CORNER_HV
	)
		
  )


 (left
	(inst
		name = iopad_b5
		offset = 230
		place_status = fixed
	)
	(inst
		name = iopad_b4
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_b3
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_b2
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_b1
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_b0
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = porGen  # power on reset generator
		cell = PORGEN_1V8_HV
	)
	(inst
		name = iopad_a7
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_a6
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_a5
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_a4
		offset = 2680
		place_status = fixed
	)

  )

  (top
	(inst
		name = iopad_a3
		offset = 230
		place_status = fixed
	)
	(inst
		name = iopad_a2
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_a1
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_a0
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = iopad_pwm_low
		place_status = fixed
	)
	(inst
		name = iopad_pwm_high
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = vddCore_0
	#	offset = 200
		place_status = fixed
		cell = VDDPAD1V8_CORE_HV
	)
	(inst
		name = vddAll
	#	offset = 200
		place_status = fixed
		cell = VDDPAD1V8ALL_HV
	)
	(inst
		name = iopad_clock_select
		place_status = fixed
	)
	(inst
		name = iopad_vref_select
		place_status = fixed
	)
	(inst
		name = iopad_f5v_select
		offset = 2062
		place_status = fixed
	)

#	(inst
#		name = top_powercut_1
#		place_status = fixed
#		cell = PWRCUT_DXS_HV
#	)
#	(inst
#		name = hs+_1.8
#		place_status = fixed
#		cell = PP_20
#	)
#	(inst
#		name = top_powercut_2
#		place_status = fixed
#		cell = PWRCUT_DXS_HV
#	)
#	(inst
#		name = dc_link
#		place_status = fixed
#		cell = PP_20
#	)
	
  )
  (bottom
	(inst
		name = iopad_b6
		offset = 230
		place_status = fixed
	)
	(inst
		name = iopad_b7
#		offset = 400
		place_status = fixed
	)
	(inst
		name = iopad_modesel_0
#		offset = 400
		place_status = fixed
	)
	(inst
		name = iopad_modesel_1
	#	offset = 200
		place_status = fixed
	)
#	(inst
#		name = gndCore_0
#	#	offset = 200
#		place_status = fixed
#		cell = GNDPAD1V8_CORE_HV
#	)
	(inst
		name = iopad_clock_out
	#	offset = 200
		place_status = fixed
	)
	(inst
		name = gndCore_1
	#	offset = 200
		place_status = fixed
		cell = GNDPAD1V8_CORE_HV
	)
	(inst
		name = iopad_clock_in
	#	offset = 200
		place_status = fixed
		cell = APRIO1V8_50_HV
	)
	(inst
		name = gndAll
	#	offset = 200
		place_status = fixed
		cell = GNDPAD1V8ALL_HV
	)
	(inst
		name = avss
		place_status = fixed
		cell = VSUB1V8_HV
	)
	(inst
		name = vref_ext
		place_status = fixed
		cell = APRIO1V8_1k4_HV
	)
	(inst
		name = vco_control
		place_status = fixed
		cell = APRIO1V8_1k4_HV
	)
	(inst
		name = btm_powercut_0
		place_status = fixed
		cell = PWRCUT_DXS_HV
	)
	(inst
		name = avdd
		offset = 2362
		place_status = fixed
		cell = VDDPAD5V_CORE_HV
	)
 )	
)
