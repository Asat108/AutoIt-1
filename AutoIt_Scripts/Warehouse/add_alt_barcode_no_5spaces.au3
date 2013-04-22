$file = FileOpen("no_space_barcode.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Read in lines of text until the EOF is reached
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
    WinActivate("Zen Cart - Mozilla Firefox", "")
	MouseMove(113,871)
	MouseClick("left")
	WinWaitActive("Zen Cart - Mozilla Firefox","")
	Send($line)
	Send("{ENTER}")
	WinWaitClose("Printing", "", 5)
	Sleep(2000) ;5 seconds
		Wend

FileClose($file)