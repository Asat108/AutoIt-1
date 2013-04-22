;Setup Debug Out
#include <Debug.au3>
_debugSetup ( "Debug!")
;End Debug Setup

$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)
;$line = FileReadLine($NewOrderFile)
;$clean = StringStripWS($line,"")
;$array = StringSplit($clean, ",")
$oshipmethod = 0
$cctype = 0
$visaNum = "4111111111111111"
$amexNum = "378282246310005"
$discNum = "6011111111111117"
$masterNum = "5555555555554444"

;Mastercard =
;Visa =
;American Express =
;Discover =


;End Variable Declaration


Func dpay()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")


	If StringInStr($array[14], "5") Then   ; array[14] is paymethodtype
		gcheckout()
	EndIf

	If StringInStr($array[13], "Visa") and StringInStr($array[14], "2") Then  ; array[13] is cardtype if present
		$cctype = $visaNum
		ccheckout()
	EndIf
	If StringInStr($array[13], "American Express") and StringInStr($array[14], "2") Then
		$cctype = $amexNum
		ccheckout()
	EndIf
	If StringInStr($array[13], "Discover") and StringInStr($array[14], "2") Then
		$cctype = $discNum
		ccheckout()
	EndIf
	If StringInStr($array[13], "Mastercard") and StringInStr($array[14], "2") Then
		$cctype = $masterNum
		ccheckout()
	EndIf

	If StringInStr($array[14], "4") Then ;and StringInStr($array[14], "") Then
		pcheckout()
	EndIf
EndFunc

Func cataxfix()


	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	If StringInStr($array[10], "CA") Then
		Do
		$continue = MsgBox(0, "CA TAX FIX", "CA Tax Detected, Verify Rounding and Click 'OK'.")
		Until $continue = 1
	EndIf
EndFunc

Func gcheckout()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send($array[15])  ; array[15] is order total $ amount
	Send("{NUMPADADD}")
	Send("{TAB}")
	Send("2")
	cataxfix()
	Send("{ENTER}")
	Send("{F12}")
	Send("+{TAB}")
	Send("+{TAB}")
	Send("22")
	Send("{ENTER}")
	Send(".")
	Send("{ENTER}")
	Send("Google Checkout")
	Send("{ENTER}")
	Send("{F12}")
EndFunc

Func ccheckout()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send($array[15])  ; array[15] is order total $ amount
	Send("{NUMPADADD}")
	Send($cctype)
	Send("{NUMPADADD}")
	Send("1213")
	Send("{NUMPADADD}")
	Send("{TAB}")
	Send("1")
	cataxfix()
	Send("{ENTER}")
	Send("{F12}")
EndFunc

Func pcheckout()
	$line = FileReadLine($NewOrderFile)
    If @error = -1 Then Exit
	$clean = StringStripWS($line,"")
	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send($array[15])  ; array[15] is order total $ amount
	Send("{NUMPADADD}")
	Send("{TAB}")
	Send("2")
	cataxfix()
	Send("{ENTER}")
	Send("{F12}")
	Send("+{TAB}")
	Send("+{TAB}")
	Send("22")
	Send("{ENTER}")
	Send(".")
	Send("{ENTER}")
	Send("PayPal")
	Send("{ENTER}")
	Send("{F12}")
EndFunc


dpay()

