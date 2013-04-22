$ship300 = 300 ;"UPS - Ground"
$ship210 = 210 ;"UPS - 2 Day Air"
$ship220 = 220 ;"UPS - 3 Day Select"
$ship910 = 910 ;"USPS - Priority"
$oshipmethod = 0
$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)

;End Variable Declaration

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

;While 1
;	$line = FileReadLine($NewOrderFile)
;    If @error = -1 Then ExitLoop
;	$clean = StringStripWS($line,"")
;	$array = StringSplit($clean, ",")
;	$ordernum = $array[2]
    WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")
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