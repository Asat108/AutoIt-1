$file = FileOpen("QUERY2.CSV", 0)
;$file = FileOpen("TEST.TXT", 0)

#include <Array.au3>


; see if we can open the file
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; prepare ASW for data entry
;	WinActivate("Session A - [24 x 80]")
;	WinActivate("Untitled - Notepad")
;	Send("PROD")
;	Send("{ENTER}")
;	Send("{TAB}")
;	Send("BLANK")
;	SEND("{NUMPADADD}")
;	Send("{TAB}")

	; strip file into lines, add individual lines to array and send to process
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line,8)
	$array = StringSplit($clean, ",")
   WinActivate("Session A - [24 x 80]")
;  WinActivate("Untitled - Notepad")

Send($array[1])
Send("{ENTER}")
Send("{F9}")
Sleep(1000)
Send("{F8}")



WEnd

FileClose($file)