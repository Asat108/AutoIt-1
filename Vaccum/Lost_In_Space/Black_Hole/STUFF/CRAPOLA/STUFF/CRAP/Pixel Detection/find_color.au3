WinWaitActive ("Session A - [24 x 80]");
Sleep (5000)
$pos = MouseGetPos()
$var = PixelGetColor( $pos[0] , $pos[1] )
MsgBox(0,"The decmial color is", $var)
MsgBox(0,"The hex color is", Hex($var, 6))