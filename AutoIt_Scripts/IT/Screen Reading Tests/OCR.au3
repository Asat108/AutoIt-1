; http://msdn2.microsoft.com/en-us/library/a...office.11).aspx
#include <GUIConstants.au3>
#include <Array.au3>

Dim $miDoc, $Doc
Dim $str
Dim $oWord
Dim $sArray[500]

Const $miLANG_CZECH = 5
Const $miLANG_DANISH = 6
Const $miLANG_DUTCH = 19
Const $miLANG_ENGLISH = 9
Const $miLANG_FINNISH = 11
Const $miLANG_FRENCH = 12
Const $miLANG_GERMAN = 7
Const $miLANG_GREEK = 8
Const $miLANG_HUNGARIAN = 14
Const $miLANG_ITALIAN = 16
Const $miLANG_JAPANESE = 17
Const $miLANG_KOREAN = 18
Const $miLANG_NORWEGIAN = 20
Const $miLANG_POLISH = 21
Const $miLANG_PORTUGUESE = 22
Const $miLANG_RUSSIAN = 25
Const $miLANG_SPANISH = 10
Const $miLANG_SWEDISH = 29
Const $miLANG_TURKISH = 31
Const $miLANG_SYSDEFAULT = 2048
Const $miLANG_CHINESE_SIMPLIFIED = 2052
Const $miLANG_CHINESE_TRADITIONAL = 1028

; Initialize error handler
$oMyError = ObjEvent("AutoIt.Error","MyErrFunc")

$miDoc = ObjCreate("MODI.Document")
$miDocView = ObjCreate("MiDocViewer.MiDocView")

$Viewer = GUICreate ( "Embedded MODI Viewer", 640, 580,(@DesktopWidth-640)/2, (@DesktopHeight-580)/2 , _
                    $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS)


;Creates an ActiveX Control in the GUI.
$GUIActiveX = GUICtrlCreateObj ($miDocView, -1, -1, 640, 580)
GUICtrlSetResizing ($Viewer, $GUI_DOCKAUTO)


$miDoc.Create("C:\Documents and Settings\michael\Desktop\AutoIt\test_cap.bmp")
$miDoc.Ocr($miLANG_ENGLISH, True, False)

; Show GUI
GUISetState ()

$MiDocView.Document = $miDoc
$MiDocView.SetScale (0.75, 0.75)


While 1
    $msg = GUIGetMsg()
   
    If $msg = $GUI_EVENT_CLOSE Then    ExitLoop
Wend



$i = 0

For $oWord in $miDoc.Images(0).Layout.Words

    $str = $str & $oWord.text & @CrLf
        ConsoleWrite($oWord.text & @CRLF)
    $sArray [$i] = $oWord.text
    $i += 1
Next

_ArrayDisplay($sArray,"OCR Result")



;MsgBox(0,"",$miDocView.FileName)

;------------------------------ This is a COM Error handler --------------------------------
Func MyErrFunc()
  $HexNumber=hex($oMyError.number,8)
  Msgbox(0,"COM Error Test","We intercepted a COM Error !"       & @CRLF  & @CRLF & _
             "err.description is: "    & @TAB & $oMyError.description    & @CRLF & _
             "err.windescription:"     & @TAB & $oMyError.windescription & @CRLF & _
             "err.number is: "         & @TAB & $HexNumber              & @CRLF & _
             "err.lastdllerror is: "   & @TAB & $oMyError.lastdllerror   & @CRLF & _
             "err.scriptline is: "     & @TAB & $oMyError.scriptline     & @CRLF & _
             "err.source is: "         & @TAB & $oMyError.source         & @CRLF & _
             "err.helpfile is: "       & @TAB & $oMyError.helpfile       & @CRLF & _
             "err.helpcontext is: "    & @TAB & $oMyError.helpcontext _
            )
  SetError(1)  ; to check for after this function returns
Endfunc