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

; Check if file opened for reading OK
If $NewOrderFile = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

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
	;WinActivate("Untitled - Notepad")

	If Not $onum == $array[2] Then
		neworder()
	Else
	oentry()
	EndIf

EndFunc

Func neworder()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")
EndFunc

Func oentry()
While 1
		$line = FileReadLine($NewOrderFile)
		If @error = -1 Then ExitLoop
		$clean = StringStripWS($line,"")
		$array = StringSplit($clean, ",")
		;$ordernum = $array[2]
		;WinActivate("Session A - [24 x 80]", "")
		WinActivate("Untitled - Notepad")

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
			;_debugout("Order#:"&$array[1]&""&$array[2]&" Item#:"&$array[16]&" Qty:"&$array[18]&" Per Item Price:"&$array[19]&"")
WEnd
EndFunc

setmemory()
checkmemory()
;oentry()