#include <File.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

Global $db1, $dbprofanity, $db5desk, $alvin_input, $alvin_userinput_read, $key, $prime, $sudoprime , $arraynum[1], $x

GUICreate("Alvin 1.0.0 Pre-Alpha", 400, 400)
GUICtrlCreateLabel("Load Database", 32, 1)
GUICtrlCreateLabel("Show Database", 163, 1)
GUICtrlCreateLabel("Purge Database", 295, 1)
GUICtrlCreateLabel("Alvin:",37, 305)
GUICtrlCreateLabel("You:",37, 335)

; Database GUI Buttons
$read_db1_button = GUICtrlCreateButton("db1", 8, 16, 120, 25)
$show_db1_button = GUICtrlCreateButton("db1", 140, 16, 120, 25)
$purge_db1_button = GUICtrlCreateButton("db1", 272, 16, 120, 25)
$read_dbprofanity_button = GUICtrlCreateButton("dbprofanity", 8, 42, 120, 25)
$show_dbprofanity_button = GUICtrlCreateButton("dbprofanity", 140, 42, 120, 25)
$purge_dbprofanity_button = GUICtrlCreateButton("dbprofanity", 272, 42, 120, 25)
$read_db5desk_button = GUICtrlCreateButton("db5desk", 8, 68, 120, 25)
$show_db5desk_button = GUICtrlCreateButton("db5desk", 140, 68, 120, 25)
$purge_db5desk_button = GUICtrlCreateButton("db5desk", 272, 68, 120, 25)

; User Input Buttons
$send_userinput_button = GUICtrlCreateButton("Send", 70, 360, 50)
$display_userinput_memory_button = GUICtrlCreateButton("User Input Memory Check", 150, 360)

; KeyGen Buttons
; $generate_key_button = GUICtrlCreateButton("Begin Key Gen", 50, 250)

; Alvin Interactions
$alvin_chat = GUICtrlCreateInput("",70, 300, 320)
$user_chat = GUICtrlCreateInput($alvin_input,70,330,320)



$alvin_vars = FileOpen("alvin.vars", 0)

	If $alvin_vars = -1 Then
		MsgBox(0, "Error", "Error Opening Alvin Variables File!     error:" & @error)
		Exit
	EndIf


GUISetState(@SW_SHOW) ; launch gui


While 1
	$msg = GUIGetMsg()

	Select

; db1

		Case $msg = $read_db1_button
			MsgBox(0, "Alvin Working...", "Reading db1 database into memory...", 1)
			Opendb1Read()

		Case $msg = $show_db1_button
			_ArrayDisplay($db1, "  db1 Contents Read  ")

		Case $msg = $purge_db1_button
			MsgBox(0, "Alvin Working...", "Purging db1...", 1)
			$db1 = 0

; dbprofanity

		Case $msg = $read_dbprofanity_button
			MsgBox(0, "Alvin Working...", "Reading dbprofanity database into memory...", 1)
			OpendbprofanityRead()

		Case $msg = $show_dbprofanity_button
			_ArrayDisplay($dbprofanity, "  dbprofanity Contents Read  ")

		Case $msg = $purge_dbprofanity_button
			MsgBox(0, "Alvin Working...", "Purging dbprofanity...", 1)
			$dbprofanity = 0

; db5desk

		Case $msg = $read_db5desk_button
			MsgBox(0, "Alvin Working...", "Reading db5desk database into memory...", 1)
			Opendb5deskRead()

		Case $msg = $show_db5desk_button
			_ArrayDisplay($db5desk, "  db5desk Contents Read  ")

		Case $msg = $purge_db5desk_button
			MsgBox(0, "Alvin Working...", "Purging db5desk...", 1)
			$db5desk = 0

; user input

		Case $msg = $send_userinput_button
			$alvin_userinput_read = GUICtrlRead($user_chat)
			GUICtrlSetData($user_chat, "")
			arraynum()
			GUICtrlSetData($alvin_chat, $db5desk[$arraynum] & "" & $db5desk[$arraynum] & "" & $db5desk[$arraynum])
;			GUICtrlSetData($alvin_chat, "Sorry, Alvin is out for the moment... Try back later.")
			Sleep(4000)
			GUICtrlSetData($alvin_chat, "")
;			GUICtrlSetData($alvin_chat, $arraynum)
		Case $msg = $display_userinput_memory_button
			MsgBox(0,"Memory", $alvin_userinput_read)

;		Case $msg = $generate_key_button
;			algorith()
;			GUICtrlSetData($user_chat, $key)

; exit

		Case $msg = $GUI_EVENT_CLOSE
			MsgBox(0, "Alvin Shutting Down", "Alvin is Shutting Down...Please Wait", 1)
		ExitLoop
	EndSelect

WEnd

; read db1

Func Opendb1Read()
	If Not _FileReadToArray("./Data/db1.aldb", $db1) Then
		MsgBox(4096, "Error", "Error reading database, check for corruption!     error:" & @error)
		Exit
	EndIf

EndFunc

;read dbprofanity

Func OpendbprofanityRead()
	If Not _FileReadToArray("./Data/dbprofanity.aldb", $dbprofanity) Then
		MsgBox(4096, "Error", "Error reading database, check for corruption!     error:" & @error)
		Exit
	EndIf

EndFunc

; read db5desk

Func Opendb5deskRead()
	If Not _FileReadToArray("./Data/db5desk.aldb", $db5desk) Then
		MsgBox(4096, "Error", "Error reading database, check for corruption!     error:" & @error)
		Exit
	EndIf

EndFunc

; keygen

 Func arraynum()
	While $x < 3
		$arraynum = Abs(Random(1, 61406, 1))
		$x = $x + 1
	WEnd
	$x = 0
 EndFunc

Func algorith()
	$prime = Random(100000, 999999) * 10.5 / 2 + 22 * 17 * 4 + 183 * 3
	$sudoprime = Random(100000, 999999) * 140 * 2 / 23 - 184 * 48 / 2 * 32
	$key = Round($prime * $sudoprime, 0)
EndFunc
