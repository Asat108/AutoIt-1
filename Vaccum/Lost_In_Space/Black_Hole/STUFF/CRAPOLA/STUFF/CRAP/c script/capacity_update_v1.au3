$file = FileOpen("999999.TXT", 0)
;$file = FileOpen("TEST.TXT", 0)

#include <Array.au3>
#include <Debug.au3>
_debugSetup ( "Debug!")

; see if we can open the file
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; prepare ASW for data entry
	WinActivate("Session A - [24 x 80]")
;	WinActivate("Untitled - Notepad")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("C")
	SEND("{NUMPADADD}")
	Send("{TAB}")

	; strip file into lines, add individual lines to array and send to process
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line,8)
	$array = StringSplit($clean, ",")
    WinActivate("Session A - [24 x 80]")
;	WinActivate("Untitled - Notepad")

Send($array[1])
Send("{ENTER}")
Send("{TAB}")
Send("IN")
Send("{ENTER}")
Send("+{TAB}")
Send("X")
Send("{ENTER}")
Send("999999")
Send("{NUMPADADD}")
Send("{ENTER}")
Send("{ENTER}")

_debugout("Item :"&$array[1]&"")

WEnd

FileClose($file)