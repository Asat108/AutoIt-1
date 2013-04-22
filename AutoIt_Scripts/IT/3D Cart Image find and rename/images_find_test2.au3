#include<array.au3>
#include<file.au3>
;$Path = @SystemDir
;$Path = "C:\Program Files\Autoit3"
$Path = "Y:\"
$SkipFolderList = ""
;$SkipFolderList = "System32;$*"
$IncludeList = "*"
;$IncludeList = "A*;S.*;*.*.*;*.ico"
;$ExcludeList = ""
$ExcludeList = "*.exe;*.dll*"
$ReturnType = 1; 0 = files+folders, 1 = files only, 2 = folders only
$ReturnFormat = 2; 2 = file/folder name only , 1 = relative path, 2 = full path
$Recursive = 1

$repeat = 10

$timer = TimerInit()
For $j = 1 to $repeat
    $x1= _FileListToArrayZ($Path, $SkipFolderList, $IncludeList, $ExcludeList, $ReturnType, $ReturnFormat, $Recursive)
Next
$t1 = TimerDiff ($timer)
_ArrayDisplay($x1,"ver1")

$ReturnFormat = 2; 0 = Initial path not included, 1 =  Initial path included, 2 =  File/folder name only
$timer = TimerInit()
For $j = 1 to $repeat
   $x2 = _RecFileListToArray($Path, $IncludeList, $ReturnType, $Recursive, $ExcludeList, $ReturnFormat)
Next
$t2 = TimerDiff ($timer)
_ArrayDisplay($x2,"ver2")

MsgBox (0, "", "$iReturnType = " & $ReturnType & @CRLF &"Ver1:  " & Int($t1/10)/100 & @CRLF & "Ver2:  " & Int($t2/10)/100)

;===============================================================================
Func _FileListToArrayZ($sPath, $sExcludeFolderList = "", $sIncludeList = "*", $sExcludeList = "", $iReturnType = 0, $iReturnFormat = 0, $bRecursive = False)
    Local $sRet = "", $sReturnFormat = ""

    ; Edit include path (strip trailing slashes, and append single slash)
    $sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\"
    If Not FileExists($sPath) Then Return SetError(1, 1, "")

    ; Edit exclude folders list
    If $sExcludeFolderList Then
        ; Strip leading/trailing spaces and semi-colons, any adjacent semi-colons, and spaces surrounding semi-colons
        $sExcludeFolderList = StringRegExpReplace(StringRegExpReplace($sExcludeFolderList, "(\s*;\s*)+", ";"), "\A;|;\z", "")
        ; Convert to Regular Expression, step 1: Wrap brackets around . and $ (what other characters needed?)
        $sExcludeFolderList = StringRegExpReplace($sExcludeFolderList, '[.$]', '\[\0\]')
        ; Convert to Regular Expression, step 2: Convert '?' to '.', and '*' to '.*?'
        $sExcludeFolderList = StringReplace(StringReplace($sExcludeFolderList, "?", "."), "*", ".*?")
        ; Convert to Regular Expression, step 3; case-insensitive, convert ';' to '|', match from first char, terminate strings
        $sExcludeFolderList = "(?i)\A(?!" & StringReplace($sExcludeFolderList, ";", "$|")  & "$)"
    EndIf

    ; Edit include files list
    If $sIncludeList ="*" Then
        $sIncludeList = ""
    Else
        If StringRegExp($sIncludeList, "[\\/ :> <\|]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
        ; Strip leading/trailing spaces and semi-colons, any adjacent semi-colons, and spaces surrounding semi-colons
        $sIncludeList = StringRegExpReplace(StringRegExpReplace($sIncludeList, "(\s*;\s*)+", ";"), "\A;|;\z", "")
        ; Convert to Regular Expression, step 1: Wrap brackets around . and $ (what other characters needed?)
        $sIncludeList = StringRegExpReplace($sIncludeList, '[.$]', '\[\0\]')
        ; Convert to Regular Expression, step 2: Convert '?' to '.', and '*' to '.*?'
        $sIncludeList = StringReplace(StringReplace($sIncludeList, "?", "."), "*", ".*?")
        ; Convert to Regular Expression, step 3; case-insensitive, convert ';' to '|', match from first char, terminate strings
        $sIncludeList = "(?i)\A(" & StringReplace($sIncludeList, ";", "$|")  & "$)"
    EndIf

    ; Edit exclude files list
    If $sExcludeList Then
        ; Strip leading/trailing spaces and semi-colons, any adjacent semi-colons, and spaces surrounding semi-colons
        $sExcludeList = StringRegExpReplace(StringRegExpReplace($sExcludeList, "(\s*;\s*)+", ";"), "\A;|;\z", "")
        ; Convert to Regular Expression, step 1: Wrap brackets around . and $ (what other characters needed?)
        $sExcludeList = StringRegExpReplace($sExcludeList, '[.$]', '\[\0\]')
        ; Convert to Regular Expression, step 2: Convert '?' to '.', and '*' to '.*?'
        $sExcludeList = StringReplace(StringReplace($sExcludeList, "?", "."), "*", ".*?")
        ; Convert to Regular Expression, step 3; case-insensitive, convert ';' to '|', match from first char, terminate strings
        $sExcludeList = "(?i)\A(?!" & StringReplace($sExcludeList, ";", "$|")  & "$)"
    EndIf

;   MsgBox(1,"Masks","File include: " & $sIncludeList & @CRLF & "File exclude: " & $ExcludeList & @CRLF _
;           & "Dir include : " & $FolderInclude & @CRLF & "Dir exclude : " & $ExcludeFolderList)

    If Not ($iReturnType = 0 Or $iReturnType = 1 Or $iReturnType = 2) Then Return SetError(3, 3, "")

    Local $sOrigPathLen = StringLen($sPath), $aQueue[64] = [1,$sPath], $iQMax = 63
    While $aQueue[0]
        $WorkFolder = $aQueue[$aQueue[0]]
        $aQueue[0] -= 1
        $search = FileFindFirstFile($WorkFolder & "*")
        If @error Then ContinueLoop
        Switch $iReturnFormat
            Case 1 ; relative path
                $sReturnFormat = StringTrimLeft($WorkFolder, $sOrigPathLen)
            Case 2 ; full path
                $sReturnFormat = $WorkFolder
        EndSwitch
        While 1
            $file = FileFindNextFile($search)
            If @error Then ExitLoop
            If @extended Then ; Folder
                If $sExcludeFolderList And Not StringRegExp($file, $sExcludeFolderList) Then ContinueLoop
                If $bRecursive Then
                    If $aQueue[0] = $iQMax Then
                        $iQMax += 128
                        ReDim $aQueue[$iQMax + 1]
                    EndIf
                    $aQueue[0] += 1
                    $aQueue[$aQueue[0]] = $WorkFolder & $file & "\"
                EndIf
                If $iReturnType = 1 Then ContinueLoop
            Else ; File
                If $iReturnType = 2 Then ContinueLoop
            EndIf
            If $sIncludeList And Not StringRegExp($file, $sIncludeList) Then ContinueLoop
            If $sExcludeList And Not StringRegExp($file, $sExcludeList) Then ContinueLoop
            $sRet &= $sReturnFormat & $file & "|"
        WEnd
        FileClose($search)
    WEnd
    If Not $sRet Then Return SetError(4, 4, "")
    Return StringSplit(StringTrimRight($sRet, 1), "|")
EndFunc


;===============================================================================
; #FUNCTION# ====================================================================================================================
; Name...........: _RecFileListToArray
; Description ...: Lists files and\or folders in a specified path with optional recursion.  Compatible with existing _FileListToArray syntax
; Syntax.........: _RecFileListToArray($sPath[, $sInclude_List = "*"[, $iReturn = 0[, $fRecur = 0[, $sExclude_List = ""[, $iFullPath = 0]]]]])
; Parameters ....: $sPath   - Initial path used to generate filelist
;                  $sInclude_List - Optional: the filter for included results (default is "*"). Multiple filters must be separated by ";"
;                  $iReturn   - Optional: specifies whether to return files, folders or both
;                  |$iReturn=0 (Default) Return both files and folders
;                  |$iReturn=1 Return files only
;                  |$iReturn=2 Return folders only
;                  $fRecur  - Optional: specifies whether to search in subfolders
;                  |$fRecur=0 (Default) Do not search in subfolders
;                  |$fRecur=1 Search in subfolders
;                  $sExclude_List - Optional: the filter for excluded results (default is ""). Multiple filters must be separated by ";"
;                  $iFullPath  - Optional: specifies path of result string
;                  |$iFullPath=0 (Default) Initial path not included
;                  |$iFullPath=1 Initial path included
;                  |$iFullPath=2 File/folder name only
; Requirement(s).: v3.3.1.1 or higher
; Return values .: Success:  One-dimensional array made up as follows:
;                  |$array[0] = Number of Files\Folders returned
;                  |$array[1] = 1st File\Folder
;                  |$array[2] = 2nd File\Folder
;                  |...
;                  |$array[n] = nth File\Folder
;                  Failure: Null string and @error = 1 with @extended set as follows:
;                  |1 = Path not found or invalid
;                  |2 = Invalid $sInclude_List
;                  |3 = Invalid $iReturn
;                  |4 = Invalid $fRecur
;                  |5 = Invalid $sExclude_List
;                  |6 = Invalid $iFullPath
;                  |7 = No files/folders found
; Author ........: Melba23 using SRE code from forums
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _RecFileListToArray($sInitialPath, $sInclude_List = "*", $iReturn = 0, $fRecur = 0, $sExclude_List = "", $iFullPath = 0)

    Local $asReturnList[1] = [0], $asFolderList[3] = [1], $sInclude_List_Mask, $sExclude_List_Mask
    Local $sCurrentPath, $hSearch, $sReturnPath = "", $sName, $fFolder

    ; Check valid path
    If Not FileExists($sInitialPath) Then Return SetError(1, 1, "")
    ; Ensure trailing \
    If StringRight($sInitialPath, 1) <> "\" Then $sInitialPath = $sInitialPath & "\"
    ; Add path to folder list
    $asFolderList[1] = $sInitialPath

    ; Determine Filter mask for SRE check
    If StringRegExp($sInclude_List, "\\|/|:|\<|\>|\|") Then Return SetError(1, 2, "") ; Check for invalid characters
    $sInclude_List = StringReplace(StringStripWS(StringRegExpReplace($sInclude_List, "\s*;\s*", ";"), 3), ";", "|") ; Strip WS and swap :/|
    $sInclude_List_Mask = "(?i)^" & StringReplace(StringReplace(StringReplace($sInclude_List, ".", "\."), "*", ".*"), "?", ".") & "\z" ; Convert to SRE pattern

    ; Determine Exclude mask for SRE check
    If $sExclude_List = "" Then
        $sExclude_List_Mask = ":" ; Set unmatchable mask
    Else
        If StringRegExp($sExclude_List, "\\|/|:|\<|\>|\|") Then Return SetError(1, 5, "") ; Check for invalid characters
        $sExclude_List = StringReplace(StringStripWS(StringRegExpReplace($sExclude_List, "\s*;\s*", ";"), 3), ";", "|") ; Strip WS and swap ;/|
        $sExclude_List_Mask = "(?i)^" & StringReplace(StringReplace(StringReplace($sExclude_List, ".", "\."), "*", ".*"), "?", ".") & "\z" ; Convert to SRE pattern
    EndIf


    ; Verify other parameter values
    If Not ($iReturn = 0 Or $iReturn = 1 Or $iReturn = 2) Then Return SetError(1, 3, "")
    If Not ($fRecur = 0 Or $fRecur = 1) Then Return SetError(1, 4, "")
    If Not ($iFullPath = 0 Or $iFullPath = 1 Or $iFullPath = 2) Then Return SetError(1, 6, "")

    ; Search in listed folders
    While $asFolderList[0] > 0

        ; Set path to search
        $sCurrentPath = $asFolderList[$asFolderList[0]]
        ; Reduce folder array count
        $asFolderList[0] -= 1
        ; Get search handle
        $hSearch = FileFindFirstFile($sCurrentPath & "*")
        ; If folder empty move to next in list
        If $hSearch = -1 Then ContinueLoop

        ; Determine path to add to file/folder name
        Switch $iFullPath
            Case 0 ; Initial path not included
                $sReturnPath = StringReplace($sCurrentPath, $sInitialPath, "")
            Case 1 ; Initial path included
                $sReturnPath = $sCurrentPath
            ; Case 2 ; Name only so leave as ""
        EndSwitch

        ; Search folder
        While 1
            $sName = FileFindNextFile($hSearch)
            ; Check for end of folder
            If @error Then ExitLoop
            ; Check for subfolder - @extended set in 3.3.1.1 +
            $fFolder = @extended

            ; If recursive search, add subfolder to folder list
            If $fRecur And $fFolder Then
                ; Increase folder array count
                $asFolderList[0] += 1
                ; Double folder array size if too small (fewer ReDim needed)
                If UBound($asFolderList) <= $asFolderList[0] + 1 Then ReDim $asFolderList[UBound($asFolderList) * 2]
                ; Add subfolder to list
                $asFolderList[$asFolderList[0]] = $sCurrentPath & $sName & "\"
            EndIf

            ; Check file/folder type against required return value and file/folder name against Include/Exclude masks
            If $fFolder + $iReturn <> 2 And StringRegExp($sName, $sInclude_List_Mask) And Not StringRegExp($sName, $sExclude_List_Mask) Then
                ; Increase return array count
                $asReturnList[0] += 1
                ; Double return array size if too small (fewer ReDim needed)
                If UBound($asReturnList) <= $asReturnList[0] Then ReDim $asReturnList[UBound($asReturnList) * 2]
                ; Add required path to file/folder name and add to array
                $asReturnList[$asReturnList[0]] = $sReturnPath & $sName
            EndIf
        WEnd

        ; Close current search
        FileClose($hSearch)

    WEnd

    ; Check if any file/folders to return
    If $asReturnList[0] = 0 Then Return SetError(1, 7, "")
    ; Remove unused return array elements from last ReDim
    ReDim $asReturnList[$asReturnList[0] + 1]

    Return $asReturnList

EndFunc   ;==>_RecFileListToArray
 