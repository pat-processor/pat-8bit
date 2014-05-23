# Sign the design!
setEdit -layer_polygon AM
# S
editAddPoly 0 50
editAddPoly 30 50
editAddPoly 30 40
editAddPoly 10 40
editAddPoly 10 30
editAddPoly 30 30
editAddPoly 30 0
editAddPoly 0 0
editAddPoly 0 10
editAddPoly 20 10
editAddPoly 20 20
editCommitPoly 0 20

deselectAll
selectWire 0.0000 0.0000 30.0000 50.0000 6 gnd!
editMove 35 75

# J
editAddPoly 0 0
editAddPoly 0 15
editAddPoly 15 15
editAddPoly 15 35
editAddPoly 0 35
editAddPoly 0 50
editAddPoly 35 50
editAddPoly 30 35
editAddPoly 25 35
editCommitPoly 25 0

deselectAll
selectWire 0.0000 0.0000 35.0000 50.0000 6 gnd!
editMove 85 75


# H
editAddPoly 0 0
editAddPoly 0 50
editAddPoly 10 50
editAddPoly 10 30
editAddPoly 20 30
editAddPoly 20 50
editAddPoly 30 50
editAddPoly 30 0
editAddPoly 20 0
editAddPoly 20 20
editAddPoly 10 20
editCommitPoly 10 0

deselectAll
selectWire 0.0000 0.0000 30.0000 50.0000 6 gnd!
editMove 135 75
