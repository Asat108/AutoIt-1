$file = FileOpen("file_list.txt", 0)


; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

	
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
	$clean = StringStripWS($line, 8)  
	$array = StringSplit($clean, ",")

$fileW = FileOpen($array[1], 10)

If $fileW = -1 Then
    MsgBox(0, "Error", "Unable to open file "&$array[1])
    Exit
EndIf

FileWriteLine($fileW, "<html> " & @CRLF)
FileWriteLine($fileW, "<head> " & @CRLF)
FileWriteLine($fileW, "<title>Jewelry Supplies - "&$array[2]&"</title>" & @CRLF)
FileWriteLine($fileW, "</head> " & @CRLF)

FileWriteLine($fileW, "<body>" & @CRLF)
FileWriteLine($fileW, "<h1>Jewelry Supplies</h1>" & @CRLF)
FileWriteLine($fileW, "<p>This page has moved<br />" & @CRLF)
FileWriteLine($fileW, "Click here for <a href=""http://www.jewelrysupply.com/"">Jewelry Supplies</a></p>" & @CRLF)
FileWriteLine($fileW, "</head> " & @CRLF)


FileClose($fileW)
Wend


FileClose($file)