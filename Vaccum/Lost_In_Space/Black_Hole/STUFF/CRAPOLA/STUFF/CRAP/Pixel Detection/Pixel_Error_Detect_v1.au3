MsgBox(0, "Pixel Detection V1", "Make ASW Green Screen Fullscreen on Right Screen and Click OK")
WinActivate("Session A - [24 x 80]")
$coor = PixelSearch( 1789, 984, 1791, 987, 15734808, 0, 1 )
;While @error = 0
;(Movement/attack Code)
;$coor = PixelSearch( 1789, 984, 1791, 987, 15734808, 0, 1 )
;Wend

MsgBox(0, "Detection", "Did We Correctly Detect the Red Pixel?  Color Coordinates = X "&$coor[0]&" , Y "&$coor[1]&" ")