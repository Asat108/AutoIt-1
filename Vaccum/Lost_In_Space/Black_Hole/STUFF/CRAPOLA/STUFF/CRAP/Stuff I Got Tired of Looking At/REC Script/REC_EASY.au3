$file = FileOpen("REC.CSV", 0)

;variables
#include <Array.au3>
Dim $array
Dim $line
Dim $file

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Read in lines of text until the EOF is reached
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	;$array = StringSplit($line, ",")
	$array = StringSplit(StringStripWS($line,8), ",")


	WinActivate("TEST_overStock_label : Database (Access 2000 file format)")
	;WinActivate("Untitled - Notepad")
	Send("^p")
	WinWaitActive("Print")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send(Round($array[6]))
	Send("{ENTER}")
	WinWait("Enter Parameter Value")


	;Send("{ENTER}")
	Send($array[1])
	Send("{ENTER}")
	Send($array[3])
	Send("{ENTER}")
	Send($array[2])
	Send("{ENTER}")
	Sleep(3000)
	;WinWait("Stock Unit")


	;WinActivate("Stock Unit")
	;WinClose("Stock Unit")
	;WinWaitClose("Stock Unit")




	;_ArrayDisplay($array)
WEnd

MsgBox(0, "Complete", "Finished Sending Print Job")