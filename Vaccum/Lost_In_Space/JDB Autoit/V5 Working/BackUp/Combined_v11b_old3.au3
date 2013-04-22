#include <File.au3>
#include <Array.au3>
#include <Debug.au3>
#include <RPDv2.au3>

_DebugSetup("Debug!")

Global $NewOrderFile, $onum = "", $line = "", $arrTemp = 0
$oshipmethod = 0
$NewOrders = FileOpen("NEW_ORDERS.TXT", 0)
$cctype = 0
$visaNum = "4111111111111111"
$amexNum = "378282246310005"
$discNum = "6011111111111117"
$masterNum = "5555555555554444"

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
EndFunc   ;==>setupasw

Func splitnow()

	If _FileReadToArray("NEW_ORDERS.TXT", $NewOrderFile) == 0 Then
		MsgBox(0, "error", "Error reading in file.")
		Exit
	EndIf


	For $curLine = 1 To $NewOrderFile[0]

		;clean and split the current line
		$line = StringSplit(StringStripWS($NewOrderFile[$curLine], 7), ",")

		If $onum <> $line[2] Then
			;the order number is different
			$onum = $line[2]

			;send the array for the last order number on for processing
			;added isArray check to prevent sending on the first loop
			If IsArray($arrTemp) Then
				processOrders($arrTemp)
			EndIf

			;start a new temp array for the new order number
			Dim $arrTemp[1] = [$NewOrderFile[$curLine]]
		Else
			;the order number is the same, add the line to the temp array for the current order number
			_ArrayAdd($arrTemp, $NewOrderFile[$curLine])
		EndIf

	Next

	;send along the last order number after the FOR loop hits the last line in the file
	If UBound($arrTemp) Then
		processOrders($arrTemp)
	EndIf
EndFunc   ;==>splitnow

Func processOrders($arrOrders)

	;work with array $arrOrders here, all elements will be lines with the same order number
	; ( $arrOrders is array of plain text lines, each element is an entire line from the file )
	_ArrayDisplay($arrOrders)


	For $order In $arrOrders

		$order = StringSplit(StringStripWS($order, 7), ",")

		WinActivate("Session A - [24 x 80]", "")

		;WinActivate("Untitled - Notepad")

		Send($order[17]) ; item number
		Send("{NUMPADADD}")
		Send($order[19]) ; item qty
		Send("{NUMPADADD}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send($order[20]) ; per item price
		Send("{NUMPADADD}")
		Send("{ENTER}")
	Next
	;WinWait("Array: ListView Display")
	dship($order)
EndFunc   ;==>processOrders

Func dship(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	;UPS Variables


	If StringInStr($order[12], "UPS - Ground") Then ; array[12] is for shipping method type
		$oshipmethod = 300
	EndIf
	If StringInStr($order[12], "Ground") Then
		$oshipmethod = 300
	EndIf
	If StringInStr($order[12], "UPS - 2nd Day Air") Then
		$oshipmethod = 210
	EndIf
	If StringInStr($order[12], "UPS - 3 Day Select�") Then
		$oshipmethod = 220
	EndIf
	;USPS Variables
	If StringInStr($order[12], "USPS - Priority Mail") Then
		$oshipmethod = 910
	EndIf
	If StringInStr($order[12], "Priority Mail") Then
		$oshipmethod = 910
	EndIf
	If StringInStr($order[12], "Free Shipping") Then
		$oshipmethod = 100
	EndIf
	f9($order)
EndFunc   ;==>dship

Func f9(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	Send("{F9}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send($order[1]) ; Invoice-Prefix
	Send($order[2]) ; Invoice Num
	Send("{NUMPADADD}")
	Send("{ENTER}")
	If $oshipmethod = 300 Then
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send($order[11]) ; shipping cost
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
		Send($order[11]) ; shipping cost
		Send("{NUMPADADD}")
		Send("{ENTER}")
		Send("{ENTER}")
	EndIf
	;	f8($order)
	resellercheck($order)
EndFunc   ;==>f9

; NEW SECTION : RESELLER_CHECK BEGIN

Func resellercheck($order)
	If StringInStr($order[10], "CA") And StringInStr($order[16], "0") Then
		f8reseller($order)
	Else
		f8($order)
	EndIf
EndFunc   ;==>resellercheck

; NEW SECTION : RESELLER_CHECK END

Func f8(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")
	Send("{F8}")
	Send("{TAB}")
	Send("1")
	Send("{ENTER}")
	Send("{TAB}")
	Send("999")
	Send("{NUMPADADD}")
	Send($order[3]) ; first name
	Send("{SPACE}")
	Send($order[4]) ; last name
	Send("{NUMPADADD}")
	Send($order[6]) ; shipping address Line 1
	Send("{NUMPADADD}")
	Send($order[7]) ; shipping address Line 2
	Send("{NUMPADADD}")
	Send($order[5]) ; Company name
	Send("{NUMPADADD}")
	Send($order[8]) ; City
	Send("{NUMPADADD}")
	Send($order[10]) ; State
	Send("{NUMPADADD}")
	Send($order[9]) ; Zip
	Send("{NUMPADADD}")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{F6}")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{F12}")
	dpay($order)
EndFunc   ;==>f8

Func f8reseller(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")
	Send("{F8}")
	Send("{TAB}")
	Send("1")
	Send("{ENTER}")
	Send("{TAB}")
	Send("999")
	Send("{NUMPADADD}")
	Send($order[3]) ; first name
	Send("{SPACE}")
	Send($order[4]) ; last name
	Send("{NUMPADADD}")
	Send($order[6]) ; shipping address Line 1
	Send("{NUMPADADD}")
	Send($order[7]) ; shipping address Line 2
	Send("{NUMPADADD}")
	Send($order[5]) ; Company name
	Send("{NUMPADADD}")
	Send($order[8]) ; City
	Send("{NUMPADADD}")
	Send($order[10]) ; State
	Send("{NUMPADADD}")
	Send($order[9]) ; Zip
	Send("{NUMPADADD}")
	Send("NOTAX")
	Send("{NUMPADADD}")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{F6}")
	Send("{ENTER}")
	WinWait("Session A - [24 x 80]", "")
	Send("{F12}")
	dpay($order)
EndFunc   ;==>f8reseller

Func dpay(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")


	If StringInStr($order[14], "5") Then ; array[14] is paymethodtype
		gcheckout($order)
	EndIf

	If StringInStr($order[13], "Visa") And StringInStr($order[14], "2") Then ; array[13] is cardtype if present
		$cctype = $visaNum
		ccheckout($order)
	EndIf
	If StringInStr($order[13], "American Express") And StringInStr($order[14], "2") Then
		$cctype = $amexNum
		ccheckout($order)
	EndIf
	If StringInStr($order[13], "Discover") And StringInStr($order[14], "2") Then
		$cctype = $discNum
		ccheckout($order)
	EndIf
	If StringInStr($order[13], "Mastercard") And StringInStr($order[14], "2") Then
		$cctype = $masterNum
		ccheckout($order)
	EndIf

	If StringInStr($order[14], "4") Then ;and StringInStr($array[14], "") Then
		pcheckout($order)
	EndIf
EndFunc   ;==>dpay

Func cataxfix($order)


	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	If StringInStr($order[10], "CA") Then
		Do
			$continue = MsgBox(0, "CA TAX FIX", "CA Tax Detected, Verify Rounding and Click 'OK'.")
		Until $continue = 1
	EndIf
EndFunc   ;==>cataxfix

Func gcheckout(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send($order[15]) ; array[15] is order total $ amount
	Send("{NUMPADADD}")
	Send($order[2]) ; order[2] is order number stripped of prefix
	Send("{NUMPADADD}")
	Send("2")
	cataxfix($order)
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
	Send("{F12}")
	Send("{ENTER}")
EndFunc   ;==>gcheckout

Func ccheckout(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	Send($order[15]) ; array[15] is order total $ amount
	Send("{NUMPADADD}")
	Send($cctype)
	Send("{NUMPADADD}")
	Send("1213")
	Send("{NUMPADADD}")
	Send("{TAB}")
	Send("1")
	cataxfix($order)
	Send("{ENTER}")
	Send("{F12}")
	Send("{F12}")
	Send("{ENTER}")
EndFunc   ;==>ccheckout

Func pcheckout(ByRef $order)
	;	$line = FileReadLine($NewOrders)
	;    If @error = -1 Then Exit
	;	$clean = StringStripWS($line,"")
	;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send($order[15]) ; array[15] is order total $ amount
	Send("{NUMPADADD}")
	Send($order[2])
	Send("{NUMPADADD}")
	Send("2")
	cataxfix($order)
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
	Send("{F12}")
	Send("{ENTER}")
	;"Array: ListView Display"
EndFunc   ;==>pcheckout


setupasw()
splitnow()