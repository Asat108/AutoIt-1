$file = FileOpen("lead_times.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Variables

$lead_times = 35;

; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("SUP")
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
	Sleep(1000)
	Send("X")
	Send("{ENTER}")
	
	SEND("{TAB}")	
	SEND("{TAB}")	
	SEND("{TAB}")	
	SEND("{TAB}")	
	SEND("{TAB}")	
	SEND("{TAB}")	

	SEND($array[2])
	SEND("{NUMPADADD}")
	SEND("{ENTER}")
	SEND("{ENTER}")
	SEND("{F8}")	
	
Wend




FileClose($file)