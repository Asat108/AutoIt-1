; This script is v3 of the Pixel Error Detection Script.
; This script uses the Weekly_Salesv4 script as a platform for testing.

;This script updates the Sales Prices for our weekly sales.
#include <Debug.au3>
#include <RPD.au3>
;#include <red_pixel_detect.au3>

_debugSetup ( "Debug!")
$file = FileOpen("SALE_PRICE.TXT", 0)

; ---------------------------------------------------------------------------------------- Begin Pixel Detection Section
;AdlibRegister("detectpix")
;
;
;Func detectpix()
;While 1
;	$coor = PixelSearch( 1789, 984, 1791, 987, 15734808, 0, 1 )
;	If Not @error Then
;		MsgBox(0, "Detected", "Pixel Detected")
;	EndIf
;Wend
;EndFunc
; ----------------------------------------------------------------------------------------  End Pixel Detection Section

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Variables- Current Monday to next Monday

$startdate = "072511"
$enddate = "080111"

; Activates the ASW window - In ASW be on a command line before running the script
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("WSU")
	SEND("{NUMPADADD}")
	Send("{TAB}")


While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)
	$array = StringSplit($clean, ",")
    WinActivate("Session A - [24 x 80]", "")
	Send($array[1])
	Send("{ENTER}")
	Send("1")
	Send("{ENTER}")
	Send("{ENTER}")

	Send("{TAB}")
	Send("{TAB}")
	Send("{TAB}")
	SEND("X")
	Send("{ENTER}")
	Send("{ENTER}")

	SEND($startdate)
	SEND("{NUMPADADD}")

	SEND($enddate)
	SEND("{NUMPADADD}")

	SEND("1")
	SEND("{TAB}")
	SEND($array[2])
	SEND("{NUMPADADD}")
	Send("{ENTER}")
	Send("{ENTER}")
;	_debugout("Item :"&$array[1]&" and Price:"&$array[2]&"")
;	Send("{F8}")
;Sleep(2000)
	Send($array[1])
	Send("{ENTER}")
	Send("{NUMPADADD}")
	Send("{ENTER}")
	Send("{F8}")
Wend




FileClose($file)