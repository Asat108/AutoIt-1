$file = FileOpen("skus.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf



; Read in lines of text until the EOF is reached
		
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	Send($file)
	Send("{TAB}")
	Send("{TAB}")
	Sleep(1000)
		
Wend




FileClose($file)