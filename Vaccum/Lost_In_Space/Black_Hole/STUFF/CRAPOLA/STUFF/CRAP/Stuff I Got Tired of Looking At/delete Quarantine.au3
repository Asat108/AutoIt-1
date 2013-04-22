#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

$response = MsgBox (1, "Delete Syamtec Quarantine", "Clicking OK will purge the Symantec Quarantine on your system.")
If $response = 1 Then
	FileDelete ("C:\Documents and Settings\All Users\Application Data\Symantec\Symantec AntiVirus Corporate Edition\7.5\Quarantine\")
	MsgBox (0, "Delete Symantec Quarantine", "SUCCESS")
EndIf
If $response = 2 Then
	MsgBox (0, "Delete Symantec Quarantine", "User Abort Symantec Quarantine Purge.")
EndIf