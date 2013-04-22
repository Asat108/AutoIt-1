#include <array.au3>; Only used for _ArrayDisplay
#include <filelisttoarray.au3> ; Used for searching for files
#include <debug.au3>

_DebugSetup("Errors")


;Variables

$path = "C:\Documents and Settings\michael\Desktop\3D Cart Resources\"


$file = FileOpen("ITEMI.CSV", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf


;Return all file matches
$hFilesFolders1 = _FileListToArrayEx("x:/", '*.jpg')
$hFilesFolders2 = _FileListToArrayEx("y:/", '*.jpg')
; Display's list of Array information



While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)
	$lowerc = StringLower($clean)
	$array = StringSplit($lowerc, ",")

	;_debugout($array[1])

	for $i = 0 to Ubound($hFilesFolders1,1) - 1

	if StringRegExp($hFilesFolders1[$i], "(.*?)"&$array[1]&"(.*?)") Then

		if StringRegExp($hFilesFolders1[$i], "(.*?)"&$array[1]&"b.jpg") Then

		;_debugout($hFilesFolders1[$i]&" Matches "&$array[1])

		FileCopy ($hFilesFolders1[$i], $path&"images\large\"&$array[2]&".jpg",1) ; This copies the current found file b image

		Elseif StringRegExp($hFilesFolders1[$i], "(.*?)"&$array[1]&".jpg") Then

		FileCopy ($hFilesFolders1[$i], $path&"images\small\"&$array[2]&"t.jpg",1) ; This copies the current found file smaller image

		EndIf

	;else

	;_DebugOut("Could not find an image for "&$array[1])

	EndIf

	Next

Wend


FileClose($file)

;_ArrayDisplay($hFilesFolders1, 'Exe and Txt')
