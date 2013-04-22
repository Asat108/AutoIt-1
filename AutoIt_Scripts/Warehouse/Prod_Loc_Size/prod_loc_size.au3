$file = FileOpen("LOC_CAP.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf


; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("LOCSIZE")
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
	Send("SIZED")
	Send("{ENTER}")
	Send($array[2])
	Send("{NUMPADADD}")
	Send("{ENTER}")
	Send("{ENTER}")
	Sleep(0500) ;1/2 second
Wend




FileClose($file)