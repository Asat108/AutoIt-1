#include <access_ui.au3>
#include <GUIConstants.au3>

$oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode 
$mainwindow = GUICreate("Order Number", 200, 100)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked")
;$handler = GUICtrlCreateInput ( "Handler?", 10,  5, 180, 20)
;$pick = GUICtrlCreateInput ( "Order Number?", 10,  30, 180, 20)
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

; Load new Catalogs to the Access Database
$sql = "Select * FROM addy_lookup"
;Old Code
;$handler = GUICtrlRead($handler)

$oRS.Open($sql, $oConn, 1, 3)

Local $oAccess = _AccessOpen($file)


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
	
	
	;MsgBox(1, "Prints", "Item# " & $item & " Prints " & $stock & " labels")
	$sql_insert = "INSERT INTO [CF] ([order], [Order_Type], [Date], [Cust_Num], [Cust_Name], [Addy_Num], [Address_1], [Address_2], [Address_3], [City], [State], [Zip]) Values ('"&$order_number&"','"&$order_type&"','"&$order_date&"','"&$customer_num&"','"&$customer_address_num&"','"&$customer_name&"','"&$customer_address1&"','"&$customer_address2&"','"&$customer_address3&"','"&$customer_address4&"','"&$state&"','"&$zip&"')"
	
	$Valid_Address = Run("ad_stand.pl '"&$customer_address1&"' '"&$customer_address2&"' '"&$customer_address4&"' '"&$state&"' '"&$zip&"'", "C:\C:\Documents and Settings\michael\Desktop\Catalog\autoit\")
	MsgBox(1, $Valid_Address, $sql_insert)
	$oArray = ObjCreate("ADODB.Recordset")
	$oArray.Open($sql_insert, $oConn, 1, 3)
	
	;$oRS.Open($sql_insert, $oConn, 1, 3)
	;$array[$i] = $sql_insert
	;$i=$i+1
	
	$oRS.MoveNext
Next

$sql = "Select * FROM CF where Sent != 1"
;Old Code
;$handler = GUICtrlRead($handler)

$oRS.Open($sql, $oConn, 1, 3)

For $iIndex = 1 To $oRS.RecordCount
  

  $oRS.MoveNext
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