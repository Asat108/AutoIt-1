;#include <_XMLDomWrapper.au3>
#include <Array.au3>
;#include <access_ui.au3>
#include <GUIConstants.au3>
#include <Debug.au3>

Opt("WinTitleMatchMode", 2)

$debugging = True
;_debugSetup ( "Debug!",True)

$oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode
$mainwindow = GUICreate("REC SMART LABEL", 250, 180)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked")
;$time_to_loop = GUICtrlCreateCheckbox( "Print All Catalogs", 10, 5)
$vendor = GUICtrlCreateInput( "Vendor #", 15, 30, 60)
;$summary_button = GUICtrlCreateButton("Print Summary", 62, 28)
;$summary_bpm = GUICtrlCreateButton("Print BPM", 138, 28)
$casecount = GUICtrlCreateInput ( "Case Count", 10,  60, 180, 20)
;$okbutton = GUICtrlCreateButton("Start", 130, 90, 60)
;$preload_button = GUICtrlCreateButton("Preload", 10, 90, 60)
;$count_button = GUICtrlCreateButton("Count", 70, 90, 60)
$total = GUICtrlCreateInput ( "Total Number of Product", 10,  125, 180, 20)
$process_button = GUICtrlCreateButton("GO", 10, 150, 60)
;$ignore_addressv = GUICtrlCreateCheckbox( "Ignore Address Errors", 75, 152)

;GUICtrlSetOnEvent($process_button, "process_cat")
;GUICtrlSetOnEvent($okbutton, "OKButton")
;GUICtrlSetOnEvent($summary_bpm, "old_zone")
;GUICtrlSetOnEvent($preload_button, "Preload")
;GUICtrlSetOnEvent($count_button, "count")
;GUICtrlSetOnEvent($summary_button, "summary_print")
GUISetState(@SW_SHOW)

;Variables

Global $file = "C:\Documents and Settings\michael\Desktop\Catalog\autoit\labels2.mdb"
Global $label = "catalog_label"
Global $view = "acViewPreview"
Global $ZoneArr[237][2]
Global $ZoneArr2[83][2]
Global $Catalogs_per_bag = 20

While 1
  Sleep(1000)  ; Idle around
WEnd

Func CLOSEClicked()
   Exit
EndFunc