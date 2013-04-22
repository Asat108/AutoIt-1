;This script updates the Sales Prices for our weekly sales.
#include <Debug.au3>
_debugSetup ( "Debug!")
$file = FileOpen("SALE_PRICE.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Variables- Current Monday to next Monday

$startdate = "053111"
$enddate = "060611"

; Activates the ASW window - In ASW be on a command line before running the script
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("SALE")
	SEND("{NUMPADADD}")
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
	SEND("X")
	Send("{ENTER}")
	Send("{ENTER}")

	SEND($startdate)
	SEND("{NUMPADADD}")

	SEND($enddate)
	SEND("{NUMPADADD}")

	SEND("1")
	SEND("{TAB}")
	SEND($array[2])
	SEND("{NUMPADADD}")
	Send("{ENTER}")
	Send("{ENTER}")
	_debugout("Item :"&$array[1]&" and Price:"&$array[2]&"")
Wend




FileClose($file)