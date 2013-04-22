; this script will read and enter new JDB orders into ASW
;

;Setup Debug Out
#include <Debug.au3>
_debugSetup ( "Debug!")
;End Debug Setup

;$ship300 = 300 ;"UPS - Ground"
;$ship210 = 210 ;"UPS - 2 Day Air"
;$ship220 = 220 ;"UPS - 3 Day Select"
;$ship910 = 910 ;"USPS - Priority"
$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)
$line = FileReadLine($NewOrderFile)
$clean = StringStripWS($line,"")
$array = StringSplit($clean, ",")
$oshipmethod = 0


;End Variable Declaration


; Check if file opened for reading OK
If $NewOrderFile = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Activates the ASW window - In ASW be on a command line before running the script
WinActivate("Session A - [24 x 80]", "")
	Send("go asw")
	Send("{ENTER}")
	Send("go sales1")
	Send("{ENTER}")
	Send("1")
	Send("{ENTER}")
	Send("JDB")
	Send("{TAB}")
	Send("{TAB}")
	Send("JDB")
	Send("{TAB}")
	Send("{TAB}")
	Send("JB")
	Send("{ENTER}")
; End ASW Setup Section
;
;
;Func orderentry()
	While 1
		$line = FileReadLine($NewOrderFile)
		If @error = -1 Then ExitLoop
		$clean = StringStripWS($line,"")
		$array = StringSplit($clean, ",")
		;$ordernum = $array[2]
		WinActivate("Session A - [24 x 80]", "")
		;WinActivate("Untitled - Notepad")

			Send($array[13])
			Send("{NUMPADADD}")
			Send($array[15])
			Send("{NUMPADADD}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send($array[16])
			Send("{NUMPADADD}")
			Send("{ENTER}")
			_debugout("Order#:"&$array[2]&" Item#:"&$array[13]&" Qty:"&$array[15]&" Per Item Price:"&$array[16]&"")
	WEnd
;EndFunc
Func f9()
	Send("{F9}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send($array[1])
	Send($array[2])
	Send("{NUMPADADD}")
	Send("{ENTER}")
	Send("{TAB}")
	Send("{TAB}")
	Send($oshipmethod)
	Send("{ENTER}")
EndFunc

;orderentry()

;Determine Shipping Method = dship()
Func dship()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;UPS Variables
	If StringInStr($array[12], "UPS - Ground") Then
		$oshipmethod = 300
	EndIf
	If StringInStr($array[12], "Ground") Then
		$oshipmethod = 300
	EndIf
	If StringInStr($array[12], "UPS - 2nd Day Air®") Then
		$oshipmethod = 210
	EndIf
	If StringInStr($array[12], "UPS - 3 Day Select®") Then
		$oshipmethod = 220
	EndIf
		;USPS Variables
	If StringInStr($array[12], "USPS - Priority Mail") Then
		$oshipmethod = 910
	EndIf
	If StringInStr($array[12], "Priority Mail") Then
		$oshipmethod = 910
	EndIf
EndFunc
dship()
f9()



;	_debugout("Order#:"&$array[2]&" Item#:"&$array[13]&" Qty:"&$array[15]&" Per Item Price:"&$array[16]&"")
;Wend