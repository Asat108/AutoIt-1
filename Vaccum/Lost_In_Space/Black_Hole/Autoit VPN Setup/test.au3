$dir = "c:"
Run("explorer.exe" & "c:")
Send("{LWIN}" & "{R}")
WinWaitActive("Run")
Send("C:\TEMPVPN")
Send("{ENTER}")