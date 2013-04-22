$file = FileOpen("pendants.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Variables


; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("BLANK")
	Send("{TAB}")
	Send("{TAB}")
	
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")
    WinActivate("Session A - [24 x 80]", "")
	Send($array[1])
	Send("{ENTER}")
	
	$I= 0
	While($I<=12)
	Send("{TAB}")
	$I = $I + 1
	WEnd
	
	Send($array[2])
	Send("{NUMPADADD}")
	Send($array[3])
	Send("{NUMPADADD}")
	
	Send("{ENTER}")
	
	$I= 0
	While($I<=4)
	Send("{TAB}")
	$I = $I + 1
	WEnd
	
	Send($array[4])
	Send("{NUMPADADD}")
	Send($array[5])
	Send("{NUMPADADD}")
	Send($array[6])
	Send("{NUMPADADD}")

	Send("{ENTER}")
	Send("{F8}")
Wend




FileClose($file)