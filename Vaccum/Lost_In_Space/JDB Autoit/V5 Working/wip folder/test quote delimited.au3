#Include <File.au3>
#Include <Array.au3>
#include <Debug.au3>

_debugSetup ( "Debug!")

Global $NewOrderFile, $onum = "", $line = "", $arrTemp = 0
$oshipmethod = 0
$NewOrders = FileOpen("NEW_ORDERS.TXT", 0)
$cctype = 0
$visaNum = "4111111111111111"
$amexNum = "378282246310005"
$discNum = "6011111111111117"
$masterNum = "5555555555554444"

Func test()
	#include <Constants.au3>

$handle_read = FileOpen(@ScriptDir & "\test.csv", 0)
If $handle_read <> -1 Then
    While 1
        $string = FileReadLine($handle_read)
        If @error Then ExitLoop
        $csv = StringRegExp($string, '(".*?",|.*?,|,)', 3)
        For $i = 0 To UBound($csv) - 1
            If MsgBox(0x40001, 'CSV Data', $csv[$i]) = $IDCANCEL Then
                ExitLoop 2
            EndIf
        Next
    WEnd
    FileClose($handle_read)
Else
    MsgBox(0x40030, 'CSV Data', 'File open error')
EndIf

EndFunc


Func formatcsv()

	$file = FileOpen(@ScriptDir & "test.csv",0)
$string = FileReadLine($file)

$csv = StringRegExp($string, '(".*?",|.*?,|,)', 3)

;For $i = 0 To UBound($csv)-1
MsgBox(0,"CSV Data",$csv)
FileClose($file)
;Next


EndFunc


Func splitnow()

If _FileReadToArray("NEW_ORDERS.TXT", $NewOrderFile) == 0 Then
    MsgBox(0,"error", "Error reading in file.")
    Exit
EndIf


For $curLine = 1 To $NewOrderfile[0]

    ;clean and split the current line
    $line = StringSplit(StringStripWS($NewOrderFile[$curLine],7), ",")

    If $onum <> $line[2] Then
        ;the order number is different
        $onum = $line[2]

        ;send the array for the last order number on for processing
        ;added isArray check to prevent sending on the first loop
        If IsArray($arrTemp) Then
            processOrders($arrTemp)
        EndIf

        ;start a new temp array for the new order number
        Dim $arrTemp[1] = [$NewOrderFile[$curLine]]
    Else
        ;the order number is the same, add the line to the temp array for the current order number
        _ArrayAdd($arrTemp,$NewOrderFile[$curLine])
    EndIf

Next

;send along the last order number after the FOR loop hits the last line in the file
If UBound($arrTemp) Then
    processOrders($arrTemp)
EndIf
EndFunc

Func processOrders($split)

    ;work with array $arrOrders here, all elements will be lines with the same order number
    ; ( $arrOrders is array of plain text lines, each element is an entire line from the file )
    _ArrayDisplay($split)


    For $order In $split

            $order = StringSplit(StringStripWS($order,7), '""')

            ;WinActivate("Session A - [24 x 80]", "")

            WinActivate("Untitled - Notepad")

                Send($order[16])  ; item number
                Send("{NUMPADADD}")
                Send($order[18])  ; item qty
                Send("{NUMPADADD}")
                Send("{TAB}")
                Send("{TAB}")
                Send("{TAB}")
                Send("{TAB}")
                Send($order[19])  ; per item price
                Send("{NUMPADADD}")
                Send("{ENTER}")
			Next
			;WinWait("Array: ListView Display")
			;dship($order)
		EndFunc

Func testsplit()
	Global $file, $array, $final, $i, $split, $start, $final
$file = FileRead('test.csv', FileGetSize('test.csv'))
If Not @error Then
    $file = StringReplace($file, '""', '||')
    $array = StringSplit($file, '"')
    If Not @error Then
        $file = ''
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
            $file = $file & $array[$i]
        Next
    ;; Split the variable into an array with the pipes.
        $split = StringSplit($file, ',')
        If Not @error Then
            For $i = 1 To $split[0]
                $split[$i] = StringReplace($split[$i], '|', ',')
            Next
        EndIf
    EndIf
EndIf

; The array $plit holds your final elements.

processOrders($arrTemp)

EndFunc

testsplit()

;test()
;formatcsv()
;splitnow()