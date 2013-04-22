;Setup Debug Out
#include <Debug.au3>
_debugSetup ( "Debug!")
;End Debug Setup

$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)
;$line = FileReadLine($NewOrderFile)
;$clean = StringStripWS($line,"")
;$array = StringSplit($clean, ",")
;$oshipmethod = 0


;End Variable Declaration

While 1
		$line = FileReadLine($NewOrderFile)
		If @error = -1 Then ExitLoop
		$clean = StringStripWS($line,"")
		$array = StringSplit($clean, ",")
		;$ordernum = $array[2]
		WinActivate("Session A - [24 x 80]", "")
		;WinActivate("Untitled - Notepad")

			Send($array[16])  ; item number
			Send("{NUMPADADD}")
			Send($array[18])  ; item qty
			Send("{NUMPADADD}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send($array[19])  ; per item price
			Send("{NUMPADADD}")
			Send("{ENTER}")
			;_debugout("Order#:"&$array[1]&""&$array[2]&" Item#:"&$array[15]&" Qty:"&$array[17]&" Per Item Price:"&$array[18]&"")
	WEnd