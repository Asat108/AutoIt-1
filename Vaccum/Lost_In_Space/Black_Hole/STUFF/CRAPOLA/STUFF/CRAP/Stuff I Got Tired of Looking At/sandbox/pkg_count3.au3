$file = FileOpen("MI.TXT", 0)

Dim $pptotal=0
Dim $fcitotal=0
Dim $fctotal=0
Dim $cantotal=0


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
		$pptotal = $pptotal + 1
	EndIf
	If ($array[10] = "First-Class International, Parcel") Then
		$fcitotal = $fcitotal + 1
	EndIf
	If ($array[10] = "First-Class") Then
		$fctotal = $fctotal + 1
	EndIf
	If StringInstr($array[5], "CANADA") Then
		$cantotal = $cantotal + 1
	EndIf
$IntTotal = $fcitotal - $cantotal
$DomTotal = $pptotal + $fctotal

Wend



MsgBox(0, "Total Package Count", "We have shipped "&$DomTotal&" Domestic Packages "&$IntTotal&" International Packages, "&$cantotal&" Canada Packages")


FileClose($file)