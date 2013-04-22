$answer=MsgBox(1, "VPN Setup", "You are about to configure VPN access for Jewelry Supply, Inc. To continue click 'OK'")
If $answer=1 Then
	DirCreate("C:\TEMPVPN")
	FileCopy("*.*", "C:\TEMPVPN\")
	Run("C:\TEMPVPN\Auto_Config_VPN.exe")
Else
	Exit
EndIf