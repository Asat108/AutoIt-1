$file = FileOpen("filelist.csv", 0)

If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf
; Loading Files
$replace = FileOpen("replace.txt", 0)

If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

$embed = FileOpen("embed_code.txt", 0)

If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Check if file opened for reading OK

While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")
	
	$openFile = FileOpen($array[1], 0)
	$szText = FileRead($openFile)
    $replace_me = FileRead($replace)
	$embed_this = FileRead($embed)
   
    $embed_final = StringReplace($embed_this, "REPLACE", $array[2])

    $szText = StringReplace($szText, $replace_me, $embed_final)
	
	
	$new_file_name = fileopen("updated\"&$array[1], 2)
    FileWrite($new_file_name,$szText)
	FileClose($new_file_name)
	FileClose($openFile)
	
WEnd