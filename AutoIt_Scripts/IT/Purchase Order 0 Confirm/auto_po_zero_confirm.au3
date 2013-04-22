$file = FileOpen("PO_ZERO.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf


; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("GO PURCHAS1")
	Send("{ENTER}")
	Send("8")
	Send("{ENTER}")
		
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")
    WinActivate("Session A - [24 x 80]", "")
	Send($array[1])
	Send("{ENTER}")
	
	Send("{F9}")
	
	Send("{F8}")
	
		
Wend




FileClose($file)