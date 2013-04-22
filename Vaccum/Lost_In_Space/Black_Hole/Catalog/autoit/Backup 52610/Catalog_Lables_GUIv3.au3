#include <access_ui.au3>
#include <GUIConstants.au3>

$oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode 
$mainwindow = GUICreate("Order Number", 200, 100)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked")
$catalogs_to_print = GUICtrlCreateInput ( "Total Number of Catalog's to print", 10,  30, 180, 20)
$okbutton = GUICtrlCreateButton("Start", 70, 60, 60)
GUICtrlSetOnEvent($okbutton, "OKButton")
GUISetState(@SW_SHOW)

While 1
  Sleep(1000)  ; Idle around
WEnd

Func OKButton()

$file = "C:\Documents and Settings\michael\Desktop\Catalog\autoit\labels2.mdb"
$label = "catalog_label"
$view = "acViewPreview"

Local $oRS
Local $oConn



$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")
$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

Local $oAccess = _AccessOpen($file)

$sql_top = "Select TOP 1 * from CF ORDER BY CF.order DESC"

$oRS.Open($sql_top, $oConn, 1, 3)

$top1 = $oRS.Fields("order").value

$oConn.Close



$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

;msgbox(1, "Top 1", $top1)

; Load new Catalogs to the Access Database

; Check for 
if $top1 = Chr(0) Then
	$top1 = 1
EndIf

$sql = "Select * FROM addy_lookup where OHORNO >"&$top1
;msgbox(1, "SQL Code", $sql)

$oRS.Open($sql, $oConn, 1, 3)

For $iIndex = 1 To $oRS.RecordCount
	
	$order_numberUC = $oRS.Fields("OHORNO").value
	$order_typeUC = $oRS.Fields("OHORDT").value
	$order_dateUC = $oRS.Fields("OHODAT").value
	$customer_numUC = $oRS.Fields("OHCUNO").value
	$customer_address_numUC = $oRS.Fields("ADADNO").value
	$customer_nameUC = $oRS.Fields("ADNAME").value
	$customer_address1UC = $oRS.Fields("ADADR1").value
	$customer_address2UC = $oRS.Fields("ADADR2").value
	$customer_address3UC = $oRS.Fields("ADADR3").value
	$customer_address4UC = $oRS.Fields("ADADR4").value
	$city_zipUC = $oRS.Fields("ADPOCD").value
	$countryUC = $oRS.Fields("ADCOUN").value
	
    $order_number = StringStripWS($order_numberUC, 8)  
	$order_type = StringStripWS($order_typeUC, 8)  
	$order_date = StringStripWS($order_dateUC, 8)
	$customer_num = StringStripWS($customer_numUC, 8)  
	$customer_address_num = StringStripWS($customer_address_numUC, 8)  
	$customer_nameUC = StringStripWS($customer_nameUC, 1)
	$customer_address1UC = StringStripWS($customer_address1UC, 1)
	$customer_address2UC = StringStripWS($customer_address2UC, 1)
	$customer_address3UC = StringStripWS($customer_address3UC, 1)
	$customer_address4UC = StringStripWS($customer_address4UC, 1)
	$customer_name = StringStripWS($customer_nameUC, 2)
	$customer_name = StringReplace($customer_name, '"', '')
	$customer_name = StringReplace($customer_name, "'", "")
	$customer_address1 = StringStripWS($customer_address1UC, 2)
	$customer_address2 = StringStripWS($customer_address2UC, 2)
	$customer_address3 = StringStripWS($customer_address3UC, 2)
	$customer_address4 = StringStripWS($customer_address4UC, 2)
	$state_zip = StringStripWS($city_zipUC, 8)
	
	;Split State and zip fields to two fields
	$state = StringLeft($state_zip, 2)
	$zip = StringTrimLeft($state_zip, 2)
	
	$country = StringStripWS($countryUC, 8)
	$oAccess.visible = 0
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Remove Variable's when ready to go live
;$customer_address1 = ""
;$customer_address2 = "8 Wildwood Drive"
;$customer_address4 = "Old Lyme"
;$state = "CT"
;$zip = ""

$cmd = 'c:\perl\bin\perl "'&@ScriptDir&'\ad_stand.pl" "'&$customer_address1&'" "'&$customer_address2&'" "'&$customer_address4&'" "'&$state&'" "'&$zip&'" > "'&@ScriptDir&'\ADDY.TXT"'

;msgbox(1, "Test", $cmd)

$success = RunWait(@ComSpec & " /c " & $cmd, @ScriptDir, @SW_HIDE)

$file = FileOpen(@ScriptDir&'\ADDY.TXT', 0)

If $file = -1 Then
	sleep (10000)
	$file = FileOpen(@ScriptDir&'\ADDY.TXT', 0)
	if $file = -1 Then
	Msgbox(1, "WHy???", $order_number&" "&$order_type&" "&$order_date&" "&$customer_num&" "&$customer_address_num)
    MsgBox(0, "Error", "Unable to open file.")
    ExitLoop
	EndIf
EndIf

Dim $array[7]
$i = 0
While 1
$line = FileReadLine($file)
If @error = -1 Then ExitLoop
$clean = StringStripWS($line, 1) 
$clean = StringStripWS($clean, 2)
$array[$i] = $clean
$i = $i + 1
WEnd
FileClose($file)

$customer_address1 = $array[1]
$customer_address2 = $array[2]
$city = $array[3]
$customer_address4 = $array[4]
$zip = $array[5]&"-"&$array[6]

if $success = 0 Then
	
	$sql_insert = "INSERT INTO [CF] ([order], [Order_Type], [Date], [Cust_Num], [Cust_Name], [Addy_Num], [Address_1], [Address_2], [Address_3], [City], [State], [Zip], [Sent]) Values ('"&$order_number&"','"&$order_type&"','"&$order_date&"','"&$customer_num&"','"&$customer_name&"','"&$customer_address_num&"','"&$customer_address1&"','"&$customer_address2&"','"&$customer_address3&"','"&$city&"','"&$state&"','"&$zip&"',0)"
	
	$oArray = ObjCreate("ADODB.Recordset")
	$oArray.Open($sql_insert, $oConn, 1, 3)
	
		
else
	
	Msgbox (1, "ERROR didn't work", "Unable to process this addres no verification possible status "&$success)
	
EndIf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;MsgBox(1, "Prints", "Item# " & $item & " Prints " & $stock & " labels")
	;$oRS.Open($sql_insert, $oConn, 1, 3)
	;$array[$i] = $sql_insert
	;$i=$i+1
	
	$oRS.MoveNext
Next


$oRS.close

$sql2 = "Select * FROM CF where CF.sent = '0'"
;Old Code
;$handler = GUICtrlRead($handler)

$oRS.Open($sql2, $oConn, 1, 3)

;For $iIndex = 1 To $oRS.RecordCount
For $iIndex = 1 To GUICtrlRead($catalogs_to_print)
  $order_numF = $oRS.Fields("order").value
  $customer_numF = $oRS.Fields("Cust_Num").value
  $customer_nameF = $oRS.Fields("Cust_Name").value
  $customer_address1F = $oRS.Fields("Address_1").value
  $customer_address2F = $oRS.Fields("Address_2").value
  $customer_address3F = $oRS.Fields("Address_3").value
  
  ;Un needed extra field has been renamed to city
  ;if Not $oRS.Fields("Address_4").value == Chr(0) Then
  ;$customer_address4F = $oRS.Fields("Address_4").value
  ;Else
  ;$customer_address4F = ""
  ;EndIf
  $cityF = $oRS.Fields("City").value
  $stateF = $oRS.Fields("State").value
  $zipF = $oRS.Fields("Zip").value
  
  $oAccess.Run("Load_Vars", $customer_numF, $customer_nameF, $customer_address1F, $customer_address2F, $customer_address3F, $stateF, $cityF, $zipF)
  
  ; Print Label with previous variables
  $oAccess.docmd.RunMacro("print", 1)
  $oRS.MoveNext
  
  
  
  
  $sql3 = "Update CF Set Sent = 1 where CF.order = "&$order_numF
  ;MsgBox(1 , "Test SQL3", $sql3)
  $oRS2 = ObjCreate("ADODB.Recordset")
  $oRS2.Open($sql3, $oConn, 1, 3)
    
Next

$oAccess.CloseCurrentDatabase()
$oConn.Close
$oConn = 0

EndFunc

Func MyErrFunc()
	$HexNumber = Hex($oMyError.number, 8)
	MsgBox(0, "COM Test", "We intercepted a COM Error !" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $oMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $oMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & $HexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $oMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $oMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $oMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $oMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $oMyError.helpcontext _
			)
	SetError(1) ; to check for after this function returns
EndFunc   ;==>MyErrFunc

Func CLOSEClicked()
   Exit
EndFunc