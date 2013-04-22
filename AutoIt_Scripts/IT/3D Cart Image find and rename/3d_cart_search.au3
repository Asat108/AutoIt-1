#include <Debug.au3>
; #FUNCTION# ====================================================================================================================
; Name...........: _RecFileFinder
; Description ...: Finds files in a specified path with optional recursion.
; Syntax.........: _RecFileFinder($sPath[, $sInclude_List = "*"[, $sExclude_List = ""[, $fRecur = 0]]])
; Parameters ....: $sPath   - Initial path
;                  $sInclude_List - Optional: the filter for included results (default is "*"). Multiple filters must be separated by ";"
;                  $sExclude_List - Optional: the filter for excluded results (default is ""). Multiple filters must be separated by ";"
;                  $fRecur  - Optional: specifies whether to search in subfolders
;                  |$fRecur=0 (Default) Do not search in subfolders
;                  |$fRecur=1 Search in subfolders
; Requirement(s).: v3.3.1.1 or higher
; Return values .: Success:  1
;                  Failure: 0 and @error = 1 with @extended set as follows:
;                  |1 = Path not found or invalid
;                  |2 = Invalid $sInclude_List
;                  |3 = Invalid $sExclude_List
;                  |4 = Invalid $fRecur
; Author ........: Melba23 using SRE code from forums
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _RecFileFinder($sPath, $sInclude_List = "*", $sExclude_List = "", $fRecur = 0)

    Local $asFolderList[3] = [1], $sInclude_List_Mask, $sExclude_List_Mask
    Local $sCurrentPath, $hSearch, $sReturnPath = "", $sName, $fFolder

    ; Check valid path
    If Not FileExists($sPath) Then Return SetError(1, 1, "")
    ; Ensure trailing \
    If StringRight($sPath, 1) <> "\" Then $sPath = $sPath & "\"
    ; Add path to folder list
    $asFolderList[1] = $sPath

    ; Determine Filter mask for SRE check
    If StringRegExp($sInclude_List, "\\|/|:|\<|\>|\|") Then Return SetError(1, 2, "") ; Check for invalid characters
    $sInclude_List = StringReplace(StringStripWS(StringRegExpReplace($sInclude_List, "\s*;\s*", ";"), 3), ";", "|") ; Strip WS and swap :/|
    $sInclude_List_Mask = "(?i)^" & StringReplace(StringReplace(StringReplace($sInclude_List, ".", "\."), "*", ".*"), "?", ".") & "\z" ; Convert to SRE pattern

    ; Determine Exclude mask for SRE check
    If $sExclude_List = "" Then
        $sExclude_List_Mask = ":" ; Set unmatchable mask
    Else
        If StringRegExp($sExclude_List, "\\|/|:|\<|\>|\|") Then Return SetError(1, 3, "") ; Check for invalid characters
        $sExclude_List = StringReplace(StringStripWS(StringRegExpReplace($sExclude_List, "\s*;\s*", ";"), 3), ";", "|") ; Strip WS and swap ;/|
        $sExclude_List_Mask = "(?i)^" & StringReplace(StringReplace(StringReplace($sInclude_List, ".", "\."), "*", ".*"), "?", ".") & "\z" ; Convert to SRE pattern
    EndIf

    ; Verify other parameter values
    If Not ($fRecur = 0 Or $fRecur = 1) Then Return SetError(1, 4, "")

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
            If Not $fFolder And StringRegExp($sName, $sInclude_List_Mask) And Not StringRegExp($sName, $sExclude_List_Mask) Then
                
                ;This is where you can do what you want with the found files
                MsgBox(0, "Result", "Found " & $sCurrentPath & $sName)
                
            EndIf
        WEnd

        ; Close current search
        FileClose($hSearch)

    WEnd

EndFunc   ;==>_RecFileFinder


$debugging = True
_debugSetup ( "Debug!")

$test = _RecFileFinder("y:\", "Thumbs.db", "", 1)

_debugout($test)

Func _print_path($path)

_debugout( "Success "&$path)

EndFunc