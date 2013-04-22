#include <array.au3>; Only used for _ArrayDisplay

;Return all .exe and .txt files
$hFilesFolders = _FileListToArrayEx("x:/", '*.jpg; *.gif')
; Display's list of Array information
;_ArrayDisplay($hFilesFolders, 'Exe and Txt')

;===============================================================================
;
; Description:    lists all or preferred files and or folders in a specified path (Similar to using Dir with the /B Switch)
; Syntax:          _FileListToArrayEx($sPath, $sFilter = '*.*', $iFlag = 0, $sExclude = '')
; Parameter(s):     $sPath = Path to generate filelist for
;                   $sFilter = The filter to use. Search the Autoit3 manual for the word "WildCards" For details, support now for multiple searches 
;                           Example *.exe; *.txt will find all .exe and .txt files
;                  $iFlag = determines weather to return file or folders or both.
;                   $sExclude = exclude a file from the list by all or part of its name 
;                           Example: Unins* will remove all files/folders that start with Unins
;                       $iFlag=0(Default) Return both files and folders
;                      $iFlag=1 Return files Only
;                       $iFlag=2 Return Folders Only
;
; Requirement(s):   None
; Return Value(s):  On Success - Returns an array containing the list of files and folders in the specified path
;                       On Failure - Returns the an empty string "" if no files are found and sets @Error on errors
;                       @Error or @extended = 1 Path not found or invalid
;                       @Error or @extended = 2 Invalid $sFilter or Invalid $sExclude
;                      @Error or @extended = 3 Invalid $iFlag
;                       @Error or @extended = 4 No File(s) Found
;
; Author(s):        SmOke_N
; Note(s):          The array returned is one-dimensional and is made up as follows:
;                   $array[0] = Number of Files\Folders returned
;                   $array[1] = 1st File\Folder
;                   $array[2] = 2nd File\Folder
;                   $array[3] = 3rd File\Folder
;                   $array[n] = nth File\Folder
;
;                   All files are written to a "reserved" .tmp file (Thanks to gafrost) for the example
;                   The Reserved file is then read into an array, then deleted
;===============================================================================

Func _FileListToArrayEx($s_path, $s_mask = "*.*", $i_flag = 0, $s_exclude = -1, $f_recurse = True, $f_full_path = True)

    If FileExists($s_path) = 0 Then Return SetError(1, 1, 0)

    ; Strip trailing backslash, and add one after to make sure there's only one
    $s_path = StringRegExpReplace($s_path, "[\\/]+\z", "") & "\"

    ; Set all defaults
    If $s_mask = -1 Or $s_mask = Default Then $s_mask = "*.*"
    If $i_flag = -1 Or $i_flag = Default Then $i_flag = 0
    If $s_exclude = -1 Or $s_exclude = Default Then $s_exclude = ""

    ; Look for bad chars
    If StringRegExp($s_mask, "[/:><\|]") Or StringRegExp($s_exclude, "[/:><\|]") Then
        Return SetError(2, 2, 0)
    EndIf

    ; Strip leading spaces between semi colon delimiter
    $s_mask = StringRegExpReplace($s_mask, "\s*;\s*", ";")
    If $s_exclude Then $s_exclude = StringRegExpReplace($s_exclude, "\s*;\s*", ";")

    ; Confirm mask has something in it
    If StringStripWS($s_mask, 8) = "" Then Return SetError(2, 2, 0)
    If $i_flag < 0 Or $i_flag > 2 Then Return SetError(3, 3, 0)

    ; Validate and create path + mask params
    Local $a_split = StringSplit($s_mask, ";"), $s_hold_split = ""
    For $i = 1 To $a_split[0]
        If StringStripWS($a_split[$i], 8) = "" Then ContinueLoop
        If StringRegExp($a_split[$i], "^\..*?\..*?\z") Then
            $a_split[$i] &= "*" & $a_split[$i]
        EndIf
        $s_hold_split &= '"' & $s_path & $a_split[$i] & '" '
    Next
    $s_hold_split = StringTrimRight($s_hold_split, 1)
    If $s_hold_split = "" Then $s_hold_split = '"' & $s_path & '*.*"'

    Local $i_pid, $s_stdout, $s_hold_out, $s_dir_file_only = "", $s_recurse = "/s "
    If $i_flag = 1 Then $s_dir_file_only = ":-d"
    If $i_flag = 2 Then $s_dir_file_only = ":D"
    If Not $f_recurse Then $s_recurse = ""

    $i_pid = Run(@ComSpec & " /c dir /b " & $s_recurse & "/a" & $s_dir_file_only & " " & $s_hold_split, "", @SW_HIDE, 4 + 2)

    While 1
        $s_stdout = StdoutRead($i_pid)
        If @error Then ExitLoop
        $s_hold_out &= $s_stdout
    WEnd

    $s_hold_out = StringRegExpReplace($s_hold_out, "\v+\z", "")
    If Not $s_hold_out Then Return SetError(4, 4, 0)

    ; Parse data and find matches based on flags
    Local $a_fsplit = StringSplit(StringStripCR($s_hold_out), @LF), $s_hold_ret
    $s_hold_out = ""

    If $s_exclude Then $s_exclude = StringReplace(StringReplace($s_exclude, "*", ".*?"), ";", "|")

    For $i = 1 To $a_fsplit[0]
        If $s_exclude And StringRegExp(StringRegExpReplace( _
            $a_fsplit[$i], "(.*?[\\/]+)*(.*?\z)", "\2"), "(?i)\Q" & $s_exclude & "\E") Then ContinueLoop
        If StringRegExp($a_fsplit[$i], "^\w:[\\/]+") = 0 Then $a_fsplit[$i] = $s_path & $a_fsplit[$i]
        If $f_full_path Then
            $s_hold_ret &= $a_fsplit[$i] & Chr(1)
        Else
            $s_hold_ret &= StringRegExpReplace($a_fsplit[$i], "((?:.*?[\\/]+)*)(.*?\z)", "$2") & Chr(1)
        EndIf
    Next

    $s_hold_ret = StringTrimRight($s_hold_ret, 1)
    If $s_hold_ret = "" Then Return SetError(5, 5, 0)

    Return StringSplit($s_hold_ret, Chr(1))
EndFunc