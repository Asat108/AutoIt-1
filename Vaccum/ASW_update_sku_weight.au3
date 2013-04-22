#include <RPDvBlaster.au3>
#include <File.au3>
#include <Debug.au3>

_DebugSetup("DEBUG ASW Update Weight")

$file = FileOpen("prodweight.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Activates the ASW window - In ASW be on a command line before running the script
	WinActivate("Session A - [24 x 80]", "")
	Send("prod")
	Send("{ENTER}")
	Send("{TAB}")
	Send("WEIGHT")
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
	Send($array[3])
	Send("{ENTER}")
	Send($array[2])
	Send("{NUMPADADD}")
	Send($array[2])
	Send("{NUMPADADD}")
	Send("{F8}")

	_DebugOut("Updated: " & $array[1])

WEnd
