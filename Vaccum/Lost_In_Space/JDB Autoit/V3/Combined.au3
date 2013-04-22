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
Dim $onum


;End Variable Declaration


; Activates the ASW window - In ASW be on a command line before running the script
Func setupasw()
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
EndFunc

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
	;WinActivate("Untitled - Notepad")


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
EndFunc

Func oentry()
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
			;_debugout("Order#:"&$array[1]&""&$array[2]&" Item#:"&$array[16]&" Qty:"&$array[18]&" Per Item Price:"&$array[19]&"")
WEnd
EndFunc

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

