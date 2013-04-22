#cs ----------------------------------------------------------------------------

AutoIt Version: 3.2.8.1
Author: WeaponX

Script Function:
Recursive file search (string based)

Notes:
-Fastest thus far

#ce ----------------------------------------------------------------------------

#include <array.au3>
$timestamp = TimerInit()
$Array = RecursiveFileSearch ("y:\Revision\", "thumbs.db")
MsgBox(0, "", (TimerDiff($timestamp) / 1000) & " seconds");0.0902s / 2090 files
_ArrayDisplay($Array)

Func RecursiveFileSearch ($startDir, $depth = 0)

If $depth = 0 Then Global $RFSstring = ""

$search = FileFindFirstFile($startDir & "\*.*")
If @error Then Return

;Search through all files and folders in directory
While 1
$next = FileFindNextFile($search)
If @error Then ExitLoop

;If folder, recurse
If StringInStr(FileGetAttrib($startDir & "\" & $next), "D") Then
RecursiveFileSearch ($startDir & "\" & $next, $depth + 1)
Else
;Append filename to master string
$RFSstring &= $startDir & "\" & $next & "*"
EndIf
WEnd
FileClose($search)

If $depth = 0 Then Return StringSplit(StringTrimRight($RFSstring, 1), "*")
EndFunc;==>RecursiveFileSearch