#Include <Array.au3>


;$line = FileReadLine($file)
;    If @error = -1 Then ExitLoop
;	$clean = StringStripWS($line, 8)
;	$array = StringSplit($clean, ",")

Func formatdata()
	Global $file, $array, $final, $i, $split, $start, $final


While 1
	$line = FileReadLine('test.csv');, FileGetSize('test.csv'))
	If Not @error Then
    $clean = StringReplace($line, '""', '||')
    $array = StringSplit($clean, '"')
    If Not @error Then
        $line = ''
    ; See if 1st element is quoted
        If StringLeft($array[1], 1) = '"' Then
            $start = 1
        Else
            $start = 2
        EndIf
    ; Replace the quotes in the elements with pipes
        For $i = $start To $array[0] Step 2
            $array[$i] = StringReplace($array[$i], ',', '|')
        Next
    ; Return the array elements back into a single variable
        For $i = 1 To $array[0]
            $line = $line & $array[$i]
        Next
    ;; Split the variable into an array with the pipes.
        $split = StringSplit($line, ',')
        If Not @error Then
            For $i = 1 To $split[0]
                $split[$i] = StringReplace($split[$i], '|', ',')
            Next
        EndIf
    EndIf
EndIf
WinActivate("Untitled - Notepad")
;Send($split[1])
;Send("{ENTER}")

;Send($split[2])
;Send("{ENTER}")
;Send($split[3])
;Send("{ENTER}")
;Send($split[4])
;Send("{ENTER}")
;Send($split[5])
;Send("{ENTER}")
;Send($split[6])
;Send("{ENTER}")
;Send($split[7])
;Send("{ENTER}")
;Send($split[8])
;Send("{ENTER}")
;Send($split[9])
;Send("{ENTER}")
;Send($split[10])
;Send("{ENTER}")
;Send($split[11])
;Send("{ENTER}")
;Send($split[12])
;Send("{ENTER}")
;Send($split[13])
;Send("{ENTER}")
;Send($split[14])
;Send("{ENTER}")
;Send($split[15])
;Send("{ENTER}")
;Send($split[16])
;Send("{ENTER}")
;Send($split[17])
;Send("{ENTER}")
;Send($split[18])
;Send("{ENTER}")
;Send($split[19])
;Send("{ENTER}")
;Send($split[20])
;Send("{ENTER}")
;Send($split[901])
_ArrayDisplay($split)
;_ArrayDisplay($array)
;_ArrayDisplay($line)
;Send($split[21])
;Send("{ENTER}")
;Send($split[22])
;Send("{ENTER}")
;Send($split[23])
;Send("{ENTER}")
;Send($split[24])
;Send("{ENTER}")
;Send($split[25])
; The array $plit holds your final elements.

;splitnow($split)
WEnd
EndFunc

formatdata()