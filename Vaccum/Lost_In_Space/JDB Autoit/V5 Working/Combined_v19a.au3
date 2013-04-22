#Include <File.au3>
#Include <Array.au3>
#include <Debug.au3>
#Include <RPDv2.au3>
#Include <Date.au3>

_debugSetup ( "Debug!")

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
;	Send("{ENTER}")
; End ASW Setup Section
EndFunc

Func splitnow()

If _FileReadToArray("NEW_ORDERS.TXT", $NewOrderFile) == 0 Then
    MsgBox(0,"error", "Error reading in file.")
    Exit
EndIf


For $curLine = 1 To $NewOrderfile[0]

    ;clean and split the current line
    $line = StringSplit(StringStripWS($NewOrderFile[$curLine],7), ",")

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
        _ArrayAdd($arrTemp,$NewOrderFile[$curLine])
    EndIf

Next

;send along the last order number after the FOR loop hits the last line in the file
If UBound($arrTemp) Then
    processOrders($arrTemp)
EndIf
EndFunc

Func processOrders($arrOrders)

    ;work with array $arrOrders here, all elements will be lines with the same order number
    ; ( $arrOrders is array of plain text lines, each element is an entire line from the file )
    ; _ArrayDisplay($arrOrders)
	;sleep(2000)
	sleep(1000)


    For $order In $arrOrders

            $order = StringSplit(StringStripWS($order,7), ",")

            WinActivate("Session A - [24 x 80]", "")

            ;WinActivate("Untitled - Notepad")
				Send("{ENTER}")
                Send($order[18])  ; item number
                Send("{NUMPADADD}")
                Send($order[20])  ; item qty
                Send("{NUMPADADD}")
                Send("{TAB}")
                Send("{TAB}")
                Send("{TAB}")
                Send("{TAB}")
                Send($order[21])  ; per item price
                Send("{NUMPADADD}")
   ;             Send("{ENTER}")
			Next
			;WinWait("Array: ListView Display")
			dship($order)
EndFunc

Func dship(ByRef $order)
;	$line = FileReadLine($NewOrders)
;    If @error = -1 Then Exit
;	$clean = StringStripWS($line,"")
;	$array = StringSplit($clean, ",")
	;UPS Variables

Send("{ENTER}")
;	If StringInStr($order[12], "UPS - Ground") Then  ; array[12] is for shipping method type
;		$oshipmethod = 300
;	EndIf
	If StringInStr($order[12], "Ground") Then
		$oshipmethod = 300
	EndIf
;	If StringInStr($order[12], "UPS - 2nd Day Air") Then
;		$oshipmethod = 210
;	EndIf
	If StringInStr($order[12], "2nd Day") Then
		$oshipmethod = 210
	EndIf
;	If StringInStr($order[12], "UPS - 3 Day Select®") Then
;		$oshipmethod = 220
;	EndIf
		If StringInStr($order[12], "3 Day") Then
		$oshipmethod = 220
	EndIf
		;USPS Variables
;	If StringInStr($order[12], "USPS - Priority Mail") Then
;		$oshipmethod = 910
;	EndIf
	If StringInStr($order[12], "Priority Mail") Then
		$oshipmethod = 910
	EndIf
	If StringInStr($order[12], "Free Shipping") Then
		$oshipmethod = 100
	EndIf
	f9($order)
EndFunc

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
	Send($order[1])  ; Invoice-Prefix
	Send($order[2])  ; Invoice Num
	Send("{NUMPADADD}")
;;;;;;;;;;;;;  NEW TOP SECTION ;;;;;;;;;;;;;;;
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
;	Send("{TAB}")
	If StringInStr($order[14], "5") Then   ; array[14] is paymethodtype
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("GG")
		Send("{NUMPADADD}")
		Send("{ENTER}")
	EndIf
	If StringInStr($order[14], "4") Then
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("{TAB}")
		Send("PP")
		Send("{NUMPADADD}")
		Send("{ENTER}")
		Send("{ENTER}")
	Else
		Send("{ENTER}")
	EndIf
;	If StringInStr($order[14], "4") Then
;		Send("PP")
;		Send("{NUMPADADD}")
;		Send("{ENTER}")
;	EndIf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Send("{ENTER}")
		If $oshipmethod=300 Then
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send("{TAB}")
			Send($order[11])  ; shipping cost
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
			Send($order[11])  ; shipping cost
			Send("{NUMPADADD}")
			Send("{ENTER}")
			Send("{ENTER}")
		EndIf
;	f8($order)
	resellercheck($order)
EndFunc

; NEW SECTION : RESELLER_CHECK BEGIN

Func resellercheck(ByRef $order)
	If StringInStr($order[10], "CA") And $order[16] = 0 Then
			f8reseller($order)
		Else
			f8($order)
		EndIf
EndFunc

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
	Send($order[3])  ; first name
	Send("{SPACE}")
	Send($order[4])  ; last name
	Send("{NUMPADADD}")
	Send($order[6])  ; shipping address Line 1
	Send("{NUMPADADD}")
	Send($order[7])  ; shipping address Line 2
	Send("{NUMPADADD}")
	Send($order[5])  ; Company name
	Send("{NUMPADADD}")
	Send($order[8])  ; City
	Send("{NUMPADADD}")
	Send($order[10])  ; State
	Send("{NUMPADADD}")
	Send($order[9])  ; Zip
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
EndFunc

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
	Send($order[3])  ; first name
	Send("{SPACE}")
	Send($order[4])  ; last name
	Send("{NUMPADADD}")
	Send($order[6])  ; shipping address Line 1
	Send("{NUMPADADD}")
	Send($order[7])  ; shipping address Line 2
	Send("{NUMPADADD}")
	Send($order[5])  ; Company name
	Send("{NUMPADADD}")
	Send($order[8])  ; City
	Send("{NUMPADADD}")
	Send($order[10])  ; State
	Send("{NUMPADADD}")
	Send($order[9])  ; Zip
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
EndFunc

Func dpay(ByRef $order)
;	$line = FileReadLine($NewOrders)
;    If @error = -1 Then Exit
;	$clean = StringStripWS($line,"")
;	$array = StringSplit($clean, ",")
	;WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")


	If StringInStr($order[14], "5") Then   ; array[14] is paymethodtype
		gcheckout($order)
	EndIf

	If StringInStr($order[13], "Visa") and StringInStr($order[14], "2") Then  ; array[13] is cardtype if present
		$cctype = $visaNum
		ccheckout($order)
	EndIf
	If StringInStr($order[13], "American Express") and StringInStr($order[14], "2") Then
		$cctype = $amexNum
		ccheckout($order)
	EndIf
	If StringInStr($order[13], "Discover") and StringInStr($order[14], "2") Then
		$cctype = $discNum
		ccheckout($order)
	EndIf
	If StringInStr($order[13], "Mastercard") and StringInStr($order[14], "2") Then
		$cctype = $masterNum
		ccheckout($order)
	EndIf

	If StringInStr($order[14], "4") Then ;and StringInStr($array[14], "") Then
		pcheckout($order)
	EndIf
EndFunc

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
EndFunc

Func gcheckout(ByRef $order)
;	$line = FileReadLine($NewOrders)
;    If @error = -1 Then Exit
;	$clean = StringStripWS($line,"")
;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send($order[15])  ; array[15] is order total $ amount
	Send("{NUMPADADD}")
	Send($order[2])  ; order[2] is order number stripped of prefix
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

	If $order[15] > 199 Then
		Send(".")
		Send("{ENTER}")
		Send("*** HIGH VALUE ORDER ***")
		Send("{ENTER}")
;		Send("*** HIGH VALUE ORDER ***")
;		Send("{ENTER}")
;		Send("*** HIGH VALUE ORDER ***")
;		Send("{ENTER}")
	EndIf

	If $order[17] = "" Then
		Send("{F12}")
		Send("{F12}")
	Else
		Send(".")
		Send("{ENTER}")
		Send("*** CUSTOMER COMMENT ***")
		Send("{ENTER}")
;		Send("*** CUSTOMER COMMENT ***")
;		Send("{ENTER}")
;		Send("*** CUSTOMER COMMENT ***")
;		Send("{ENTER}")
		Send("{F12}")
		Send("{F12}")
	EndIf

;	Send("{ENTER}")
	orderlog($order)
EndFunc

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
	Send($order[15])  ; array[15] is order total $ amount
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
	Send("+{TAB}")
	Send("+{TAB}")
	Send("22")
	Send("{ENTER}")

	If $order[15] > 199 Then
		Send(".")
		Send("{ENTER}")
		Send("*** HIGH VALUE ORDER ***")
		Send("{ENTER}")
;		Send("*** HIGH VALUE ORDER ***")
;		Send("{ENTER}")
;		Send("*** HIGH VALUE ORDER ***")
;		Send("{ENTER}")
	EndIf

	If $order[17] = "" Then
		Send("{F12}")
		Send("{F12}")
	Else
		Send(".")
		Send("{ENTER}")
		Send("*** CUSTOMER COMMENT ***")
		Send("{ENTER}")
;		Send("*** CUSTOMER COMMENT ***")
;		Send("{ENTER}")
;		Send("*** CUSTOMER COMMENT ***")
;		Send("{ENTER}")
		Send("{F12}")
		Send("{F12}")
	EndIf

;	Send("{ENTER}")
	orderlog($order)
EndFunc

Func pcheckout(ByRef $order)
;	$line = FileReadLine($NewOrders)
;    If @error = -1 Then Exit
;	$clean = StringStripWS($line,"")
;	$array = StringSplit($clean, ",")
	WinActivate("Session A - [24 x 80]", "")
	;WinActivate("Untitled - Notepad")

	Send("{F7}")
	Send($order[15])  ; array[15] is order total $ amount
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

	If $order[15] > 199 Then
		Send(".")
		Send("{ENTER}")
		Send("*** HIGH VALUE ORDER ***")
		Send("{ENTER}")
;		Send("*** HIGH VALUE ORDER ***")
;		Send("{ENTER}")
;		Send("*** HIGH VALUE ORDER ***")
;		Send("{ENTER}")
	EndIf

	If $order[17] = "" Then
		Send("{F12}")
		Send("{F12}")
	Else
		Send(".")
		Send("{ENTER}")
		Send("*** CUSTOMER COMMENT ***")
		Send("{ENTER}")
;		Send("*** CUSTOMER COMMENT ***")
;		Send("{ENTER}")
;		Send("*** CUSTOMER COMMENT ***")
;		Send("{ENTER}")
		Send("{F12}")
		Send("{F12}")
	EndIf


;	Send("{ENTER}")
	orderlog($order)
	;"Array: ListView Display"
EndFunc

Func orderlog(ByRef $order)
	$logfile = FileOpen("orderlog.txt", 1)
		FileWriteLine($logfile, $order[1]&$order[2] & " " & _DateTimeFormat(_NowCalc(),0))
		FileClose($logfile)
	EndFunc

Func beginbatch()
	$logfile = FileOpen("orderlog.txt", 1)
		FileWriteLine($logfile, "~~~~~~~ START BATCH ~~~~~~~ " & _DateTimeFormat(_NowCalc(),0))
		FileClose($logfile)
	EndFunc

Func endbatch()
	$logfile = FileOpen("orderlog.txt", 1)
		FileWriteLine($logfile, "~~~~~~~ FINISH BATCH ~~~~~~~ " & _DateTimeFormat(_NowCalc(),0))
		FileClose($logfile)
	EndFunc
beginbatch()
setupasw()
splitnow()
endbatch()
