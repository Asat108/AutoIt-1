;Setup Debug Out
#include <Debug.au3>
_debugSetup ( "Debug!")
;End Debug Setup

$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)
;$line = FileReadLine($NewOrderFile)
;$clean = StringStripWS($line,"")
;$array = StringSplit($clean, ",")
$oshipmethod = 0


;End Variable Declaration

Func f8()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")
	Send("{F8}")
	Send("{TAB}")
	Send("1")
	Send("{ENTER}")
	Send("{TAB}")
	Send("999")
	Send("{NUMPADADD}")
	Send($array[3])  ; first name
	Send("{SPACE}")
	Send($array[4])  ; last name
	Send("{NUMPADADD}")
	Send($array[6])  ; shipping address Line 1
	Send("{NUMPADADD}")
	Send($array[7])  ; shipping address Line 2
	Send("{NUMPADADD}")
	Send($array[5])  ; Company name
	Send("{NUMPADADD}")
	Send($array[8])  ; City
	Send("{NUMPADADD}")
	Send($array[10])  ; State
	Send("{NUMPADADD}")
	Send($array[9])  ; Zip
	Send("{NUMPADADD}")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{F6}")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{F12}")

EndFunc

f8()