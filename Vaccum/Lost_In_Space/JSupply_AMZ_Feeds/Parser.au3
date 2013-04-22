#include <Debug.au3>
#include <RPDv2.au3>
#include <File.au3>
#include <Array.au3>
#Include <Date.au3>

_debugSetup ( "Debug!")

PurgeOld()

$file = FileOpen("orig.txt", 0)

$newfile = FileOpen("split.txt", 1)
$copyfile = "split.txt"

$forget2 = 0
$forget2 = 1

Dim $text1, $text2, $text3, $text4, $text5, $text6, $timestamp

;Purge old data from split.txt

Func PurgeOld()
$purge = FileOpen("split.txt", 2)
EndFunc

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
;	$clean = StringStripWS($line, 8)
	$compare = StringSplit($line, ",")
	ReDim $compare[7]
;_ArrayDisplay($compare)
	$text1 = $compare[1]

	If $compare[2] = $compare[1] Then
		$text2 = ""
	Else
		$text2 = $compare[2]
	EndIf
	If $compare[3] = $compare[2] Or $compare[3] = $compare[1] Then
		$text3 = ""
	Else
		$text3 = $compare[3]
	EndIf
	If $compare[4] = $compare[3] Or $compare[4] = $compare[2] Or $compare[4] = $compare[1] Then
		$text4 = ""
	Else
		$text4 = $compare[4]
	EndIf
	If $compare[5] = $compare[4] Or $compare[5] = $compare[3] Or $compare[5] = $compare[2] Or $compare[5] = $compare[1] Then
		$text5 = ""
	Else
		$text5 = $compare[5]
	EndIf
	If $compare[6] = $compare[5] Or $compare[6] = $compare[4] Or $compare[6] = $compare[3] Or $compare[6] = $compare[2] Or $compare[6] = $compare[1] Then
		$text6 = ""
	Else
		$text6 = $compare[6]
	EndIf

	$writeNewFile = FileWriteLine($newfile, $text1&","&$text2&","&$text3&","&$text4&","&$text5&","&$text6)

WEnd
timestamp()
Func timestamp()
$gettime =_DateTimeFormat(_NowCalc(), 0)
$cleantime = StringReplace($gettime, "/", "")
$cleandate = StringReplace($cleantime, ":", "")
$timestamp = StringReplace($cleandate, " ", "")
;MsgBox(0, "test", $timestamp)

EndFunc
FileCopy($copyfile, ".\"&$timestamp&"_final.csv", 0)                                ;     &Random(1, 10000, 1)&".csv", 1) ;Random(1, 10000, 1)&"_final.csv", 0)