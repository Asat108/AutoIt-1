$file = FileOpen("Postcard_Customers.txt")

#include <Array.au3>
#include <Debug.au3>

Dim $count = 0

If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

		WinActivate("Session A - [24 x 80]", "")

		Send("go asw")
		Send("{ENTER}")
		Send("name")
		Send("{ENTER}")


While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	;$array = StringSplit($line, ",")
	$array = StringSplit(StringStripWS($line,8), ",")
	_debugSetup ( "COUNT")

	WinActivate("Session A - [24 x 80]", "")

	;_ArrayDisplay($array)

	Send($array[1])
	Send("{TAB}")
	Send("BLANK")
	Send("{ENTER}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("PC")
	Send("{NUMPADADD}")
	Send("{ENTER}")
	Send("{ENTER}")
	Send("{ENTER}")
	Send("{ENTER}")
	Send("{ENTER}")
	Send("{ENTER}")
	Send("{ENTER}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{NUMPADADD}")
	Send("{ENTER}")
	Send("{F8}")

	$count = $count + 1

	_debugout("Customer#:"&$array[1]&" COUNT:"&$count&"")

WEnd
