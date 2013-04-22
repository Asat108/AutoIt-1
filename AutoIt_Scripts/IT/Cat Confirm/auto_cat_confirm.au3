$file = FileOpen("catalog.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf


; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("GO SALES1")
	Send("{ENTER}")
	Send("5")
	Send("{ENTER}")

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
    WinActivate("Session A - [24 x 80]", "")
	Send($line)
	Send("{ENTER}")
	Send("{F8}")
	Send("{F8}")
	Send("{F8}")
	Sleep(0500) ;1/2 second
Wend




FileClose($file)