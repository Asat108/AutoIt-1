$file = FileOpen("catalogtest.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf
	
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
    WinActivate("Galaxy Ship by Endicia (Account 562360)", "")
	Send($line)
	Send("{ENTER}")
	If WinExists("Galaxy Ship", "") Then
	$errorFile = FileOpen("addressMatch.txt", 0)
	FileWriteLine($errorFile, $line & @CRLF)
	FileClose($errorFile)
	Send("{ENTER}")
	EndIf
	
	Sleep(0500) ;1/2 second
	
Wend




FileClose($file)