#include <Debug.au3>
#include <RPDv2.au3>
#include <File.au3>
#include <Array.au3>
#Include <Date.au3>

_debugSetup ( "Debug!")

PurgeOld()

$file = FileOpen("title_unit.txt", 0)

$newfile = FileOpen("titleunitcombined.txt", 1)
$copyfile = "titleunitcombined.txt"

Dim $timestamp

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
;	$clean = StringStripWS($line, 8)
	$array = StringSplit($line, ",")
	$writenewfile = FileWriteLine($newfile, $array[1]&" ("&$array[2]&")")
WEnd


timestamp()

FileCopy($copyfile, ".\"&$timestamp&"_titleunitcombined.csv", 0)

Func timestamp()

$gettime =_DateTimeFormat(_NowCalc(), 0)
$cleantime = StringReplace($gettime, "/", "")
$cleandate = StringReplace($cleantime, ":", "")
$timestamp = StringReplace($cleandate, " ", "")
;MsgBox(0, "test", $timestamp)

EndFunc

Func PurgeOld()
$purge = FileOpen("split.txt", 2)
EndFunc