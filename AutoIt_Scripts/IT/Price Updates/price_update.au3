$file = FileOpen("PRICE_update.TXT", 0)

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
	Send("SALE")
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
	
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Sleep(1000)
	Send("X")
	Send("{ENTER}")
	
	SEND($array[2])
	SEND("{NUMPADADD}")
		
	SEND($array[3])
	SEND("{NUMPADADD}")
	
	Send("{NUMPADADD}")
	
	SEND($array[4])
	SEND("{NUMPADADD}")
	
	SEND($array[5])
	SEND("{NUMPADADD}")
	
	Send("{NUMPADADD}")
	
	SEND($array[6])
	SEND("{NUMPADADD}")

	Send("Y")
	
	SEND("{ENTER}")
	SEND("{ENTER}")
	SEND("{ENTER}")
	SEND("{ENTER}")
		
	
Wend




FileClose($file)