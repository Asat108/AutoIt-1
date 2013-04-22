#include <RPDv2.au3>
#include <FILE.au3>
#include <DEBUG.au3>
#include <ARRAY.au3>

_DebugSetup("Products and Count")

$file = FileOpen("backorder-no.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Variables

$BOSetting = "Y"

; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("BOSTAT")
	Send("{TAB}")
	Send("{TAB}")

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)
	$array = StringSplit($clean, ",")
	$array = StringSplit($line, ",")
    WinActivate("Session A - [24 x 80]", "")

	Send($array[1])
	Send("{ENTER}")
	Send($BOSetting)
	Send("{NUMPADADD}")
	Send("{ENTER}")
	SEND("{F8}")

	_DebugOut("Updated: " & $array[1])

WEnd

FileClose($file)