#Include <File.au3>
#Include <Array.au3>

Global $NewOrderFile, $onum = "", $line = "", $arrTemp = 0

;Read in the entire file to an array

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


Func processOrders($arrOrders)

    ;work with array $arrOrders here, all elements will be lines with the same order number
    ; ( $arrOrders is array of plain text lines, each element is an entire line from the file )
    _ArrayDisplay($arrOrders)


    For $order In $arrOrders

            $order = StringSplit(StringStripWS($order,7), ",")

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

EndFunc

splitnow()