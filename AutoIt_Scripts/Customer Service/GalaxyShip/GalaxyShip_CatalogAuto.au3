$file = FileOpen("catalogList.txt", 0)
Opt("WinTitleMatchMode", 3) ;1=absolute, 0=relative, 2=client

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

WinActivate("Galaxy Ship by Endicia (Account 562360)", "")

While 1
	WinWaitActive ("Galaxy Ship by Endicia (Account 562360)", "")
	$line = FileReadLine($file)
	If @error = -1 Then ExitLoop
    Send($line)
	Send("{ENTER}")
	Sleep(05000) ;5 seconds (Checking Address)
	Select
		Case WinActive ("Galaxy Ship by Endicia (Account 562360)", "")
		 Sleep(05000) ;5 seconds
	     Send ("{F5}")
	    Case Else
	     $errorText = WinGetText ("[Active]")
         $errorFile = FileOpen("addressIssues.txt", 1)
	     FileWriteLine($errorFile, $line & $errorText &@CRLF)
	     FileClose($errorFile)
	     Send("{ENTER}")
    EndSelect
Wend
FileClose($file)