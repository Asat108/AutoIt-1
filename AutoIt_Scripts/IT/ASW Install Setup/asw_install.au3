; Setup ASW This should complete the ASW setup

if (WinExists("Introduction to Configuration Assistant", "")) Then

WinActivate("Introduction to Configuration Assistant", "");

Else	
	Sleep (200);
EndIf

WinActivate("Introduction to Configuration Assistant", "");
Send("!n");

WinWaitActive("Specify environment name", "");
Send("a");
Send("!n");

WinWaitActive("Choose communication protocol", "");
Send("!n");

WinWaitActive("Choose Emulator","");
Send("!n");

WinWaitActive("Verify router and emulator","");
Send("!n");

WinWaitActive("Configuration Assistant environment settings", "");
Send("{TAB}");
Send("{TAB}");
Send("{TAB}");
Send("{TAB}");
$i = 0;
while($i<80);
Send("{backspace}");
$i = $i + 1;
WEnd

Send("192.168.254.80");
Send("!n");


WinWaitActive("Verify environment name and settings", "");
Send("!n");

WinWaitActive("MSG03242  J Walk Windows Client", "");
Send("!y");

WinWaitActive("Ending Configuration Assistant", "");
Send("!f");