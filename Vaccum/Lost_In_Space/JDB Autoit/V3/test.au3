;Setup Debug Out
#include <Debug.au3>
_debugSetup ( "Debug!")
;End Debug Setup
Dim $onum
$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)
;$line = FileReadLine($NewOrderFile)
;$clean = StringStripWS($line,"")
;$array = StringSplit($clean, ",")
;$oshipmethod = 0


;End Variable Declaration
While 1
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	WinActivate("Untitled - Notepad")

	Send($array[2])
	Send("{ENTER}")
WEnd