$file = FileOpen("3.TXT", 0)

#include <Array.au3>

; conversion variables
Dim $pcs = 1
Dim $6pcs = 6
Dim $10pcs = 10
Dim $30pcs = 30
Dim $48pcs = 48
Dim $50pcs = 50
Dim $100pcs = 100
Dim $250pcs = 250
Dim $500pcs = 500
Dim $1000pcs = 1000
Dim $5000pcs = 5000
Dim $dz = 12
Dim $set = 0
Dim $6set = 0
Dim $1000set = 0
Dim $sheet = 0
Dim $book = 0
Dim $gross = 0
Dim $roll = 0
; other variables
Dim $total
Dim $temp = 0
Dim $array

; conversion math
Func math()
	If StringInStr($array[3], "pcs") Then
		$temp = $pcs
	EndIf
	If StringInStr($array[3], "6pcs") Then
		$temp = $6pcs
	EndIf
	If StringInStr($array[3], "10pcs") Then
		$temp = $10pcs
	EndIf
	If StringInStr($array[3], "30pcs") Then
		$temp = $30pcs
	EndIf
	If StringInStr($array[3], "48pcs") Then
		$temp = $48pcs
	EndIf
	If StringInStr($array[3], "50pcs") Then
		$temp = $50pcs
	EndIf
	If StringInStr($array[3], "100pcs") Then
		$temp = $100pcs
	EndIf
	If StringInStr($array[3], "250pcs") Then
		$temp = $250pcs
	EndIf
	If StringInStr($array[3], "500pcs") Then
		$temp = $500pcs
	EndIf
	If StringInStr($array[3], "1000pcs") Then
		$temp = $1000pcs
	EndIf
	If StringInStr($array[3], "5000pcs") Then
		$temp = $5000pcs
	EndIf
	If StringInStr($array[3], "dz") Then
		$temp = $dz
	EndIf
	If StringInStr($array[3], "set") Then
		$temp = $set
	EndIf
	If StringInStr($array[3], "6set") Then
		$temp = $6set
	EndIf
	If StringInStr($array[3], "1000set") Then
		$temp = $1000set
	EndIf
	If StringInStr($array[3], "sheet") Then
		$temp = $sheet
	EndIf
	If StringInStr($array[3], "book") Then
		$temp = $book
	EndIf
	If StringInStr($array[3], "gross") Then
		$temp = $gross
	EndIf
	If StringInStr($array[3], "roll") Then
		$temp = $roll
	EndIf

$total = $temp * $array[4]

EndFunc





; see if we can open the file
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; prepare ASW for data entry
;	WinActivate("Session A - [24 x 80]")
	WinActivate("Untitled - Notepad")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("PP")
	SEND("{NUMPADADD}")
	Send("{TAB}")

; strip file into lines, add individual lines to array and send to process
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$array = StringSplit($line, ",")
;    WinActivate("Session A - [24 x 80]")
	WinActivate("Untitled - Notepad")

	;_ArrayDisplay($array)
	;_ArrayDisplay($total)

; process data through ASW by sending keystrokes from array
	Send($array[1])
	Send("{ENTER}")
	Send("+{TAB}")
	Send("X")
	Send("{ENTER}")
	math()
	;Send($array[4])
	Send($total)
	Send("{NUMPADADD}")
	Send("{F8}")

WEnd

