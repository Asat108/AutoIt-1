$file = FileOpen("2004.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Read in lines of text until the EOF is reached
;	WinActivate("Session A - [24 x 80]", "")
;	Send("NAME")
;	Send("{ENTER}")
;	Send("{TAB}")
;	Send("BLANK")
;	Send("{TAB}")
	
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")
    WinActivate("Session A - [24 x 80]", "")
	Send($array[1])
	Send("{ENTER}")
	Sleep(0150) ;2 second	
	Send("{F11}")
	Send("{F11}")
	Sleep(0150) ;2 second	
Wend




FileClose($file)