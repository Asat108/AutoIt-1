$file = FileOpen("loc_range.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

WinActivate("Microsoft Access", "")

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")
	
	
Send("{enter}")

Send($array[1])

Send("{enter}")

Send("{ALTDOWN}")
Send("p")
Send("{ALTUP}")

WinWaitActive("Print", "")

Send ("{enter}")

sleep ("600")

Send ("{escape}")

Wend

FileClose($file)