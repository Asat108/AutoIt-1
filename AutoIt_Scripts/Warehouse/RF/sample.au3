#include <GUIConstants.au3>

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode 
$mainwindow = GUICreate("RF Cross Ref", 200, 100)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked")
$prod_id = GUICtrlCreateInput ( "SKU?", 10,  5, 180, 20)
$upc_code = GUICtrlCreateInput ( "BarCode", 10,  30, 180, 20)
$okbutton = GUICtrlCreateButton("Start", 70, 60, 60)
GUICtrlSetOnEvent($okbutton, "OKButton")
GUISetState(@SW_SHOW)

While 1
  Sleep(1000)  ; Idle around
WEnd

Func OKButton()
    ;MsgBox(0, "GUI Event", "You pressed OK!")
	;MsgBox (4096, "Title", GUICtrlRead($prod_id)&GUICtrlRead($upc_code))
	WinActivate("Session A - [24 x 80]")
	Send(GUICtrlRead($prod_id))
	Send("{ENTER}")
	Send("{F7}")
	Send("{F7}")
	Send("{F6}")
	Send("{TAB}")
	Send (GUICtrlRead($upc_code))
	Send("{ENTER}")
	Send("{F12}")
	Send("{F7}")
	Send("{F7}")
	Send("{F7}")
	Send("{F6}")
	Send (GUICtrlRead($upc_code))
	Send("{ENTER}")
	Send("{F12}")
	Send("{ENTER}")
	;clear box
	WinActivate("RF Cross Ref")
	GUICtrlSetData($prod_id,"SKU")
	GUICtrlSetData($upc_code,"BarCode")
	EndFunc

Func CLOSEClicked()
   Exit
EndFunc