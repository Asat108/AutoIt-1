#include <FILE.au3>
#include <RPDv2.au3>

$file = FileOpen("Amazon_X.txt", 0)

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
	Send("X")
	Send("{NUMPADADD}")
	Send("{TAB}")

While 1

	$line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)
	$array = StringSplit($clean, ",")
    WinActivate("Session A - [24 x 80]", "")

	Send($array[2])
	Send("{ENTER}")
	Send("{TAB}")
	Send("X")
	Send("{ENTER}")
	Sleep(10)
	Send("AMAZON")
	Send("{NUMPADADD}")
	Send("{TAB}")
	Send($array[1])
	Send("{NUMPADADD}")
	Send("{ENTER}")
	Sleep(10)
	Send("{F8}")
WEnd



