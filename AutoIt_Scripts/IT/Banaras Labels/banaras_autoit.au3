$file = FileOpen("labels.TXT", 0)

Opt("MouseCoordMode", 0)

; Check if opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

	if (WinExists("Adobe Readert","")) then
		WinClose("Adobe Reader","")
	EndIf
; Read in lines of text until the EOF is reached
	WinActivate("Enter Parameter Value", "")
		
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")
    Send($array[1])
	Send("{ENTER}")
	Sleep(50)
	Send("^p")
	Sleep(50)	
	Send("{ENTER}")
	WinWaitActive("Save PDF File As", "")
	WinActivate("Save PDF File As", "")
	Send($array[1])
	Send("{ENTER}")
	sleep (600)
	if (WinExists("Save PDF File As","")) then
		Send("{Y}")
	EndIf
	sleep (600)
	
	WinActivate("Microsoft Access", "")
	Send("^w")
	sleep(30)
	Send("{ENTER}")		
	WinActivate("Enter Parameter Value")
	sleep(300)
Wend

FileClose($file)