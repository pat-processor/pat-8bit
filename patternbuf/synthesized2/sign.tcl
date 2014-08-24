# Sign the design!
set scalefactor 5
set xoffset 100
set yoffset 20


proc scaledpoly {{inx 0} {iny 0}} {
	global scalefactor
	global xoffset
	global yoffset

	set newx [expr $inx * $scalefactor]
	set newx [expr $newx + [expr $xoffset * $scalefactor] ]
	set newy [expr $iny * $scalefactor]
	set newy [expr $newy + [expr $yoffset * $scalefactor] ]

	editAddPoly $newx $newy
}

proc scaledpolycommit {{inx 0} {iny 0}} {
	global scalefactor
	global xoffset
	global yoffset

	set newx [expr $inx * $scalefactor]
	set newx [expr $newx + [expr $xoffset * $scalefactor] ]
	set newy [expr $iny * $scalefactor]
	set newy [expr $newy + [expr $yoffset * $scalefactor] ]

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
set xoffset [expr $xoffset + 50]
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
set xoffset [expr $xoffset + 50]
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


