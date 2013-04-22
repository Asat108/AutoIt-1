WinWaitActive ("Session A - [24 x 80]");
Sleep (5000)
$pos = MouseGetPos()
MsgBox(0, "Mouse x,y:", $pos[0] & "," & $pos[1])