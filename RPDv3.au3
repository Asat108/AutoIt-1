WinSetState("Session A - [24 x 80]","",@SW_MAXIMIZE)

AdlibRegister("detectpix", 10)


Func detectpix()
;While 1
	$coor = PixelSearch( 1789, 984, 1791, 987, 15734808, 0, 1 )
	If Not @error Then
		MsgBox(0, "Detected", "Pixel Detected")
	EndIf
;Wend
EndFunc