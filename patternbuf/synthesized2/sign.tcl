# Sign the design!
set scalefactorx 2
set scalefactory 2
set xoffset 560
set yoffset 2100
set spacing 50

set spacing [expr $spacing * $scalefactorx]


proc scaledpoly {{inx 0} {iny 0}} {
	global scalefactorx
	global scalefactory
	global xoffset
	global yoffset

	set newx [expr $inx * $scalefactorx]
	set newx [expr $newx + $xoffset ]
	set newy [expr $iny * $scalefactory]
	set newy [expr $newy + $yoffset]

	editAddPoly $newx $newy
}

proc scaledpolycommit {{inx 0} {iny 0}} {
	global scalefactorx
	global scalefactory
	global xoffset
	global yoffset

	set newx [expr $inx * $scalefactorx]
	set newx [expr $newx + $xoffset ]
	set newy [expr $iny * $scalefactory]
	set newy [expr $newy + $yoffset ]

	editCommitPoly $newx $newy
}


setEdit -layer_polygon AM
# S


scaledpoly 0 50
scaledpoly 30 50
scaledpoly 30 40
scaledpoly 10 40
scaledpoly 10 30
scaledpoly 30 30
scaledpoly 30 0
scaledpoly 0 0
scaledpoly 0 10
scaledpoly 20 10
scaledpoly 20 20
scaledpolycommit 0 20


# J
set scalefactorx 1.8
set xoffset [expr $xoffset + $spacing]
scaledpoly 0 0
scaledpoly 0 15
scaledpoly 15 15
scaledpoly 15 35
scaledpoly 0 35
scaledpoly 0 50
scaledpoly 35 50
scaledpoly 30 35
scaledpoly 25 35
scaledpolycommit 25 0



# H
set scalefactorx 2
set xoffset [expr $xoffset + $spacing]
scaledpoly 0 0
scaledpoly 0 50
scaledpoly 10 50
scaledpoly 10 30
scaledpoly 20 30
scaledpoly 20 50
scaledpoly 30 50
scaledpoly 30 0
scaledpoly 20 0
scaledpoly 20 20
scaledpoly 10 20
scaledpolycommit 10 0


