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

Func dship()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;UPS Variables
	If StringInStr($array[12], "UPS - Ground") Then  ; array[12] is for shipping method type
		$oshipmethod = 300
	EndIf
	If StringInStr($array[12], "Ground") Then
		$oshipmethod = 300
	EndIf
	If StringInStr($array[12], "UPS - 2nd Day Air") Then
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

Func f9()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	Send("{F9}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send($array[1])  ; Invoice-Prefix
	Send($array[2])  ; Invoice Num
	Send("{NUMPADADD}")
	Send("{ENTER}")
		If $oshipmethod=300 Then
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send($array[11])  ; shipping cost
			Send("{NUMPADADD}")
			Send("{ENTER}")
			Send("{ENTER}")
		Else
			Send("{TAB}")
			Send("{TAB}")
			Send($oshipmethod)
			Send("{ENTER}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send($array[11])  ; shipping cost
			Send("{NUMPADADD}")
			Send("{ENTER}")
			Send("{ENTER}")
		EndIf
EndFunc
dship()
f9()
