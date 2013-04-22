$file = FileOpen("MI.TXT", 0)

Dim $total=0

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf


; Read in lines of text until the EOF is reached
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$array = StringSplit($line, "	")
    
	If ($array[10] = "Parcel Post") Then
		$total = $total + 1
	EndIf
		
	
Wend

MsgBox(0, "Total Package Count", "We have shipped "&$total&" packages.")


FileClose($file)