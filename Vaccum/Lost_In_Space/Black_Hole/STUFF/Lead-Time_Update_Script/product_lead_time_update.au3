#include <RPDv2.au3>
#include <FILE.au3>
#include <DEBUG.au3>
#include <ARRAY.au3>
#include <DATE.au3>

_DebugSetup("Products and Count")

$file = FileOpen("update.TXT", 0)
$log = FileOpen("log.txt", 1)

$curcount = 0

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Variables

$lead_times = 15

; Read in lines of text until the EOF is reached
	WinActivate("Session A - [24 x 80]", "")
	Send("PROD")
	Send("{ENTER}")
	Send("{TAB}")
	Send("SUPLEADT")
	Send("{TAB}")
	Send("{TAB}")

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	;$clean = StringStripWS($line, 8)
	;$array = StringSplit($clean, ",")
	$array = StringSplit($line, ",")
    WinActivate("Session A - [24 x 80]", "")
	Send($array[1])
	Send("{ENTER}")

	Send($array[2])
	Send("{ENTER}")

	Send($lead_times)

	SEND("{NUMPADADD}")
	SEND("{ENTER}")
	SEND("{F8}")

$curcount = $curcount + 1

_DebugOut("Product: "&$array[1]&" Supplier: "&$array[2]&" Count: "&$curcount&"")

FileWriteLine($log, "Product: "&$array[1]&" Supplier: "&$array[2]&" Old Lead Time: "&$array[3]&" Timestamp: "&_DateTimeFormat(_NowCalc(),0)&" Count: "&$curcount&"")

Wend

FileClose($file)