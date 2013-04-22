;Setup Debug Out
#include <Debug.au3>
_debugSetup ( "Debug!")
;End Debug Setup

$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)
;$line = FileReadLine($NewOrderFile)
;$clean = StringStripWS($line,"")
;$array = StringSplit($clean, ",")
;$continue = 0

Func cataxfix()


	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	If StringInStr($array[10], "CA") Then
		Do
		$continue = MsgBox(0, "CA TAX FIX", "CA Tax Detected, Verify Rounding and Click 'OK' To Continue.")
		Until $continue = 1
	EndIf
EndFunc

cataxfix()