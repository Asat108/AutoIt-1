;This script forces ASW to update the sales items
#include <Debug.au3>
_debugSetup ( "Debug!")
$file = FileOpen("SALE_PRICE.TXT", 0)
$file2 = FileOpen("SALE_PRICE.TXT", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf


Func prep()

; Activates the ASW window - In ASW be on a command line before running the script
	WinActivate("Session A - [24 x 80]", "")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("BLANK")
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
	Send("1")
	Send("{ENTER}")
	Send("{F8}")

WEnd

FileClose($file)

EndFunc

Func fupdate()

	; Activates the ASW window - In ASW be on a command line before running the script
	WinActivate("Session A - [24 x 80]", "")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("BLANK")
	SEND("{NUMPADADD}")
	Send("{TAB}")


While 1
    $line2 = FileReadLine($file2)
    If @error = -1 Then ExitLoop
	$clean2 = StringStripWS($line2, 8)
	$array2 = StringSplit($clean2, ",")
    WinActivate("Session A - [24 x 80]", "")

	Send($array2[1])
	Send("{ENTER}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{NUMPADADD}")
	Send("{ENTER}")
	Send("{F8}")

WEnd

FileClose($file2)

EndFunc

Func ready()
	;MsgBox(0, "Force Update", "This script will forceupdate sales items")
	$run1 = MsgBox(0, "Prep", "Prep Items for Update?")
	If $run1 = 1 Then
		prep()
	EndIf
	$run2 = MsgBox(0, "Force Update", "Force Update Items?")
	If $run2 = 1 Then
		fupdate()
	EndIf
EndFunc

ready()
