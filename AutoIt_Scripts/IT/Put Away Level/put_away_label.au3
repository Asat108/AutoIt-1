$file = FileOpen("put_away.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Variables

$date = 999999;

; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("81")
	Send("{ENTER}")
	Send("LOC")
	Send("{ENTER}")
	SEND("{TAB}")	
	SEND("{TAB}")	
	SEND("{TAB}")	
	SEND("{TAB}")	
	SEND("{TAB}")
	SEND("x")	
	Send("{ENTER}")
	

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")
    WinActivate("Session A - [24 x 80]", "")
	Send("100")
	SEND("{NUMPADADD}")
	Send("1")
	SEND("{NUMPADADD}")
	Send($array[1])
	Send("{ENTER}")
		
	$t=0
	While $t<=18
		Send("{TAB}")
		$t=$t+1
	WEnd
	
	Send("99.00")
	SEND("{NUMPADADD}")
	Send("{ENTER}")
Wend



FileClose($file)