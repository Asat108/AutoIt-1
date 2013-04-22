WinActivate("Spark")


$doesExist = WinWaitActive("Spark", "", 2)

If $doesExist = 0 Then
	WinActivate("Spark.exe")
	$doesExistAgain = WinWaitActive("Spark","" , 2)
EndIf

; MsgBox(0, "Test", "Finished Script")