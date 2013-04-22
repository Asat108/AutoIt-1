$customer_address1 = ""
$customer_address2 = "8 Wildwood Drive"
$customer_address4 = "Old Lyme"
$state = "CT"
$zip = ""

$cmd = 'c:\perl\bin\perl "'&@ScriptDir&'\ad_stand.pl" "'&$customer_address1&'" "'&$customer_address2&'" "'&$customer_address4&'" "'&$state&'" "'&$zip&'" > "'&@ScriptDir&'\ADDY.TXT"'

;msgbox(1, "Test", $cmd)

$success = RunWait(@ComSpec & " /c " & $cmd, @ScriptDir, @SW_HIDE)

$file = FileOpen(@ScriptDir&'\ADDY.TXT', 0)

If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

Dim $array[7]
$i = 0
While 1
$line = FileReadLine($file)
If @error = -1 Then ExitLoop
$clean = StringStripWS($line, 1) 
$clean = StringStripWS($clean, 2)
$array[$i] = $clean
$i = $i + 1
WEnd

if $success = 0 Then
	
	For $x = 1 To UBound($array) - 1
	MsgBox(80, "Message", $array[$x])
	Next

else
	
	Msgbox (1, "ERROR didn't work", "Unable to process this addres no verification possible status "&$success)
	
EndIf