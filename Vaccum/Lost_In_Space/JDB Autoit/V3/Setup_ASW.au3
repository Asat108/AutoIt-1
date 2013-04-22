; this script will read and enter new JDB orders into ASW

$NewOrderFile = FileOpen("NEW_ORDERS.TXT", 0)
$line = FileReadLine($NewOrderFile)
$clean = StringStripWS($line,"")
$array = StringSplit($clean, ",")
$oshipmethod = 0


;End Variable Declaration




; Activates the ASW window - In ASW be on a command line before running the script
Func setupasw()
WinActivate("Session A - [24 x 80]", "")
	Send("go asw")
	Send("{ENTER}")
	Send("go sales1")
	Send("{ENTER}")
	Send("1")
	Send("{ENTER}")
	Send("JDB")
	Send("{TAB}")
	Send("{TAB}")
	Send("JDB")
	Send("{TAB}")
	Send("{TAB}")
	Send("JB")
	Send("{ENTER}")
; End ASW Setup Section
EndFunc

setupasw()