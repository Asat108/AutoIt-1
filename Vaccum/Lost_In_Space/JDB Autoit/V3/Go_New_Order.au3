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

Func setmemory()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	WinActivate("Untitled - Notepad")


	;$onum = 0
	 $onum = $array[2]
	Send($onum)
EndFunc

Func checkmemory()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	WinActivate("Untitled - Notepad")

	If Not $onum == $array[2] Then
		setmemory()
		neworder()
		Send("1")
	Else
	oentry()
	Send("2")
	EndIf

EndFunc

Func neworder()
	Send("3")

EndFunc

Func oentry()
	Send("4")
EndFunc

setmemory()
While 1
checkmemory()
WEnd