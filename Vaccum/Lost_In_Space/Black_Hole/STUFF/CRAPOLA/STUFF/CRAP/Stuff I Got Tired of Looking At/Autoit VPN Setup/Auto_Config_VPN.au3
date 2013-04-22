; Auto install and config VPN to Office network
;_debugSetup ( "Debug!")
HotKeySet("{ESC}")
AdlibRegister("popup")
AdlibRegister("settings")
AdlibRegister("norestart")
Func popup()
	If WinActivate("Hardware Installation") Then
		Send("{TAB}")
		Send("{TAB}")
		Send("{ENTER}")
	EndIf
EndFunc

Func settings()
	If WinActivate("System Settings Change") Then
		Send("{TAB}")
		Send("{ENTER}")
	EndIf
EndFunc
Func norestart()
	If WinActivate("SonicWALL Global VPN Client", "Do you want to restart your computer now?") Then
		Send("{RIGHT}")
		Send("{ENTER}")
	EndIf
EndFunc

MsgBox(0, "Pre-Install Message", "In the event your VPN installation does not go as planed..." & @LF & "1) Wait for the program\install to finish" & @LF & "2) Then you will be able to view detailed instructions, including photos, in the HELP file located on the CD-ROM." & @LF &""& @LF & "If you are still in need of assistance contact your IT Dept.")
MsgBox(0,"Installation Warning", "--------------WARNING!!-----------WARNING!!--------------" & @LF & "DO NOT USE THE COMPUTER DURING THE INSTALLATION PROCESS - DOING SO WILL CRASH THE INSTALL!!!")
$continue=MsgBox(1,"VPN CLIENT SETUP", "To Start the installation click 'OK', or 'Cancel' to abort.")
If $continue=1 Then
Run("GVCSetup32.exe")  ; runs setup file
WinWaitActive("SonicWALL Global VPN Client") ; waits for setup window to appear
Send("{ENTER}") ; next
WinWaitActive("SonicWALL Global VPN Client") ; waits for setup window to refresh
Send("{TAB}")
Send("{RIGHT}")
Send("{ENTER}") ; these commands move the selection to "i agree" then "next"
WinWaitActive("SonicWALL Global VPN Client") ; waits for refresh
Send("{ENTER}") ; next
WinWaitActive("SonicWALL Global VPN Client") ; waits for refresh
Send("{ENTER}") ; last window before installation begins - next
;WinWaitActive("Hardware Installation")
;Send("{TAB}")
;Send("{TAB}")
;Send("{ENTER}")
;WinWaitActive("SonicWALL Global VPN Client")
;Send("{ENTER}")
WinWaitActive("SonicWALL Global VPN Client", "SonicWALL Global VPN Client has been successfully installed.")
Send("{ENTER}")
;Send("{ENTER}")
MsgBox(0, "INSTALLATION COMPLETE", "Installation Completed! Setup will now configure your VPN Connection. Click OK to Continue.")
WinWaitClose("INSTALLATION COMPLETE")
Run("C:\Program Files\SonicWALL\SonicWALL Global VPN Client\SWGVC.exe")
WinWaitActive("New Connection Wizard")
Send("{TAB}")
Send("{ENTER}")
WinActivate("SonicWALL Global VPN Client")
Send("{F10}")
Send("{DOWN}")
Send("{DOWN}")
Send("{DOWN}")
Send("{DOWN}")
Send("{DOWN}")
Send("{ENTER}")
Send("{TAB}")
Send("{ENTER}")
MsgBox(0, "SELECT VPN CONFIG FILE", "Please select the Config file located in the same folder you started this program from -- it's called: 'WAN GroupVPN_Home_Base.rcf' -- and click 'Open'")
WinWaitActive("Import Connection")
Send("{TAB}")
Send("JSvpn11")
Send("{ENTER}")
WinWaitActive("SonicWALL Global VPN Client")
Send("{F10}")
Send("{DOWN}")
Send("{ENTER}")
WinWaitActive("Connection Warning")
Send("{RIGHT}")
Send("{RIGHT}")
Send("{SPACE}")
Send("{ENTER}")
MsgBox(0, "Configuration Complete", "All Finished! Please type in your username and password provided to you to connect.")
WinWaitClose("Configuration Complete")
;Send("{LWIN}" & "{R}")
;WinWaitActive("Run")
;Send("C:\TEMPVPN")
;Send("{ENTER}")
MsgBox(0, "Verify Settings", "In case your VPN connection does not work here are the settings for you to verify:" & @LF & "Connection Type - Remote Access" & @LF & "IP Address - 66.60.137.106" & @LF & "Username and Password - Provided by IT Dept." & @LF &""& @LF &"TO VIEW DETAILED INSTALLATION INSTRUCTIONS VIEW THE HELP FILE LOCATED ON THE CD-ROM.")

Else
	MsgBox(0,"Aborted Install", "You have chosen to abort the install, please try again.")
EndIf
