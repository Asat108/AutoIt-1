WinSetState("Session A - [24 x 80]","",@SW_MAXIMIZE)

AdlibRegister("detectpix")


Func detectpix()
;While 1
	$coor = PixelSearch( 101, 704, 191, 707, 15734808, 0, 1 )
	If Not @error Then
		MsgBox(0, "Detected", "Pixel Detected")
	EndIf
;Wend
EndFunc