WinActivate("Session A - [24 x 80]")

While 1
	$coor = PixelSearch( 1789, 984, 1791, 987, 15734808, 0, 1 )
	If Not @error Then
		MsgBox(0, "Detected", "Pixel Detected")
	EndIf
Wend


	MsgBox(0, "TEST", "If you see this then the red pixel is no longer present")