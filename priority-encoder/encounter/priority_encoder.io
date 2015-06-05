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



 (left
	(inst
		name = iopad_a
	#	offset = 200
		cell = APRIO1V8_50_HV
		place_status = fixed
	)
	(inst
		name = iopad_b
		cell = APRIO1V8_50_HV
		place_status = fixed
	)
	(inst
		name = iopad_c
		cell = APRIO1V8_50_HV
		place_status = fixed
	)
	(inst
		name = iopad_d
		cell = APRIO1V8_50_HV
		place_status = fixed
	)
  )
  (bottom
	(inst
		name = vdd_pad
		cell = VDDPAD1V8ALL_HV
		place_status = fixed	
	)

  	(inst
		name = gnd_pad
		cell = GNDPAD1V8ALL_HV
		place_status = fixed
	)
	(inst
		name = gnd_sub
		place_status = fixed
		cell = VSUB1V8_HV
	)
  )
   (top

  )
  (right
	(inst
		name = iopad_y1
		cell = APRIO1V8_50_HV
		place_status = fixed	
	)
	(inst
		name = iopad_y0
		cell = APRIO1V8_50_HV
		place_status = fixed	
	)
	(inst
		name = iopad_v
		cell = APRIO1V8_50_HV
		place_status = fixed	
	)
	(inst
		name = iopad_nand_out
		cell = APRIO1V8_50_HV
		place_status = fixed	
	)
  )

  (bottomleft
	(inst
		name = CORNER_BL
		orientation = r0
		cell = CORNER_HV
	)
		
  )

    (bottomright
	(inst
		name = CORNER_BR
		orientation = r90
		cell = CORNER_HV
	)
		
  )


)
