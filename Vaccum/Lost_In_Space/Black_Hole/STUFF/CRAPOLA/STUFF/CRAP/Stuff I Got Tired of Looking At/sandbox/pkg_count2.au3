$file = FileOpen("MI.TXT", 0)

Dim $pptotal=0
Dim $fcitotal=0
Dim $cantotal=0
Dim $fctotal=0
Dim $InputWord=0
Dim $can2total=0
#Dim $SearchLines = _ArraySearch($array[5])

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
	If ($InputWord = "CANADA") Then
		$cantotal = $cantotal + 1
	EndIf
	#If ($SearchLines = "CANADA") Then
		#$can2total = $can2total + 1
	#EndIf


Wend

MsgBox(0, "Total Package Count", "We have shipped "&$pptotal&" Domestic Packages, "&$fcitotal&" First-Class International Packages, "&$fctotal&" First-Class Packages, "&$cantotal&" Canada Packages, "&$can2total&" Canada2 Packages")


FileClose($file)