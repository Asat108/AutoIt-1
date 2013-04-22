$file = FileOpen("PRICE_CHANGE_UPDATE.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf


; Variables
$startdate = "42610"
$enddate = "50310"

; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("SALE")
	Send("{NUMPADADD}")
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
	
	Send($array[2])
	SEND("{NUMPADADD}")
	
	SEND("{NUMPADADD}")
    SEND("{NUMPADADD}")
	SEND("{NUMPADADD}")
	SEND("{NUMPADADD}")
	SEND("{NUMPADADD}")	
	SEND("{NUMPADADD}")
	SEND("{NUMPADADD}")
	
	
	SEND("{ENTER}")
	
	SEND($startdate)
	SEND("{NUMPADADD}")
	
	SEND($enddate)
	SEND("{NUMPADADD}")
		
	SEND("1")
	SEND("{TAB}")	
	SEND($array[3])
	SEND("{NUMPADADD}")
	Send("{ENTER}")
	Send("{ENTER}")
		
		
Wend




FileClose($file)