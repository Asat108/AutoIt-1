#include <RPDv2.AU3>
#include <FILE.AU3>
#include <ARRAY.AU3>
#include <DEBUG.AU3>

$file = FileOpen("prod.txt", 0)

_DebugSetup("DEBUG")

;;;;;;;;; --- CHANGEABLE VARIABLES --- ;;;;;;;;;

$packsize = 2

;;;;;;;;; --- END CHANGEABLE VARIABLES --- ;;;;;;;;;

If $file = -1 Then
	MsgBox(0, "~ERROR~", "Couldn't Open File For Reading")
	Exit
EndIf

	WinActivate("Session A - [24 x 80]")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("{F12}")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("PACKSIZE")
	Send("{NUMPADADD}")
	Send("{TAB}")

While 1
	$line = FileReadLine($file)
	If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 7)
	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]")

	Send($array[1])
	Send("{ENTER}")
	Send($array[2])
	Send("{ENTER}")
	Send("+{TAB}")
	Send("X")
	Send("{ENTER}")
	Send($packsize)
	Send("{NUMPADADD}")
	Send("{F8}")
	_DebugOut($array[1] & "updated to " & $packsize & " pack size")

WEnd