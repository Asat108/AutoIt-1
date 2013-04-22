; AutoIt 3.0.103 example
; 17 Jan 2005 - CyberSlug
; This script shows manual positioning of all controls;
;   there are much better methods of positioning...
#include <GuiConstants.au3>


; GUI
GuiCreate("Conversion Utility", 250, 190)
GuiSetIcon(@SystemDir & "\calc.exe", 0)


; GROUP CONVERT FROM
GuiCtrlCreateGroup("Convert From", 10, 40, 110, 100)
$n1 = GUICtrlCreateList("", 20, 60, 80, 80)
GUICtrlSetData(-1, "Gram|Ounce|Penny Weight", "Penny Weight")
GUICtrlCreateGroup ("",-99,-99,1,1)  ;close group

; GROUP CONVERT TO
GuiCtrlCreateGroup("Convert to", 130, 40, 110, 100)
$n2 = GUICtrlCreateList("", 140, 60, 80, 80)
GUICtrlSetData(-1, "Gram|Ounce|Penny Weight", "Gram")
GUICtrlCreateGroup ("",-99,-99,1,1)  ;close group

; INPUT To Convert
$QCF = GuiCtrlCreateInput("", 10, 10, 110, 20)

; INPUT Convert
$QCT = GuiCtrlCreateInput("", 130, 10, 110, 20)

; BUTTON
$convert = GuiCtrlCreateButton("Convert", 10, 150, 100, 30)


GUISetState(@SW_SHOW)

; GUI MESSAGE LOOP
While 1
$msg = GUIGetMsg()
$m1 = GUICtrlRead($n1)
$m2 = GUICtrlRead($n2)
$QCtotal = GuiCtrlRead($QCF)
Select
	Case $msg = $Convert
		select
			Case $m1 = $m2
				MsgBox(0, "Error", "You cannot convert to the same unit...  Please select something different")
			Case Else
				Select
					case $m1 = "Penny Weight" and $m2 = "Gram"
						$output = $QCtotal * 1.55517384
						GUICtrlSetData($QCT, $output)
					case $m1 = "Penny Weight" and $m2 = "Ounce"
						$output = $QCtotal * 0.0548571429
						GUICtrlSetData($QCT, $output)
					case $m1 = "Gram" and $m2 = "Ounce"
						$output = $QCtotal * 0.0352739619
						GUICtrlSetData($QCT, $output)
					case $m1 = "Gram" and $m2 = "Penny Weight"
						$output = $QCtotal * 1.555
						GUICtrlSetData($QCT, $output)
					case $m1 = "Ounce" and $m2 = "Penny Weight"
						$output = $QCtotal * 18.2291
						GUICtrlSetData($QCT, $output)
					case $m1 = "Ounce" and $m2 = "Gram"
						$output = $QCtotal * 28.3495
						GUICtrlSetData($QCT, $output)
					EndSelect
				
			EndSelect

    Case $msg = $GUI_EVENT_CLOSE
      ExitLoop
  EndSelect
WEnd