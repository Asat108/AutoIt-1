#include <_XMLDomWrapper.au3>
#include <Array.au3>
#include <access_ui.au3>
#include <GUIConstants.au3>
#include <Debug.au3>

Opt("WinTitleMatchMode", 2)

$debugging = True
_debugSetup ( "Debug!")

$oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode 
$mainwindow = GUICreate("Order Number", 200, 100)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked")
$time_to_loop = GUICtrlCreateCheckbox( "Print All Catalogs", 5, 5)
$catalogs_to_print = GUICtrlCreateInput ( "Total Number of Catalog's to print", 10,  30, 180, 20)
$okbutton = GUICtrlCreateButton("Start", 130, 60, 60)
$preload_button = GUICtrlCreateButton("Preload", 10, 60, 60)
$count_button = GUICtrlCreateButton("Count", 70, 60, 60)
GUICtrlSetOnEvent($okbutton, "OKButton")
GUICtrlSetOnEvent($preload_button, "Preload")
GUICtrlSetOnEvent($count_button, "count")
GUISetState(@SW_SHOW)

;Variables

Global $file = "C:\Documents and Settings\michael\Desktop\Catalog\autoit\labels2.mdb"
Global $label = "catalog_label"
Global $view = "acViewPreview"
Global $ZoneArr[237][2]
Global $Catalogs_per_bag = 20

While 1
  Sleep(1000)  ; Idle around
WEnd

Func Count()

Preload()

Local $oAccess = _AccessOpen($file)
Local $oRS
Local $oConn
Local $Dazzle_Folder = "c:\Program Files\Envelope Manager\DAZzle"

; Load ADODB connection
$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

; Load SQL query
$sql2 = "Select * FROM CF where CF.sent = '0'"

; Run SQL Query
$oRS.Open($sql2, $oConn, 1, 3)

msgbox (1, "Current Catalog Total", "There are "&$oRS.RecordCount&" catalogs in the system", "")

$oAccess.CloseCurrentDatabase()
$oConn.Close
$oConn = 0

EndFunc

Func Preload()

Local $oAccess = _AccessOpen($file)

Local $oRS
Local $oConn
Local $Dazzle_Folder = "c:\Program Files\Envelope Manager\DAZzle"

$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")

; Setup Zone Array for matching address by zip

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

; Backup CF table before wrighting

$oAccess.docmd.RunMacro("CopyCF")

; Load the Zones to and Array
$sql_zone = "Select * from Zones ORDER BY Zones.Zip ASC"

_DebugOut( "Running Zone" )

$oRS.Open($sql_zone, $oConn, 1, 3)

For $zoneIndex = 1 To $oRS.RecordCount

$ZoneArr[$zoneIndex][0] = $oRS.Fields("zip").value
$ZoneArr[$zoneIndex][1] = $oRS.Fields("zone").value
; Output results of Zip / Zone array
;_debugout("Zip:"&$ZoneArr[$zoneIndex][0]&" Zone:"&$ZoneArr[$zoneIndex][1] )
$oRS.MoveNext
Next

_debugout( UBound($ZoneArr) )

$oConn.Close

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

$sql_top = "Select TOP 1 * from CF ORDER BY CF.order DESC"

$oRS.Open($sql_top, $oConn, 1, 3)

$top1 = $oRS.Fields("order").value

$oConn.Close

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

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
	; Do not need to be cleaned but left for completeness
	;$customer_address2 = StringReplace($customer_address2, '"', '')
	;$customer_address2 = StringReplace($customer_address2, "'", "")
	$customer_address3 = StringReplace($customer_address3, '"', '')
	$customer_address3 = StringReplace($customer_address3, "'", "")
	; Do not need to be cleaned but left for completeness
	;$customer_address1 = StringReplace($customer_address1, '"', '')
	;$customer_address1 = StringReplace($customer_address1, "'", "")
	$customer_address4 = StringReplace($customer_address4, '"', '')
	$customer_address4 = StringReplace($customer_address4, "'", "")
	$city_zipUC = StringReplace($city_zipUC, '"', '')
	$city_zipUC = StringReplace($city_zipUC, "'", "")
	$state_zip = StringStripWS($city_zipUC, 8)
	$city = $customer_address4
	
	
	;Split State and zip fields to two fields
	$state = StringLeft($state_zip, 2)
	$zip = StringTrimLeft($state_zip, 2)
	$zipleft3 = StringMid($zip, 1, 3)
	
	;_DebugOut( "Zip left = "&$zipleft3 )
		
	$country = StringStripWS($countryUC, 8)
	$oAccess.visible = 0
	
	For $zoneI = 1 To (Ubound($ZoneArr)-1)
	
	if $ZoneArr[$zoneI][0] = $zipleft3 Then
		
		$zone = $ZoneArr[$zoneI][1]
		
	ElseIf $ZoneArr[$zoneI][0] < $zipleft3 Then
		;$zoneIndexm1 = $zoneI - 1 
		;$zone = $ZoneArr[$zoneIndexm1][1]
		$zone = $ZoneArr[$zoneI][1]
	EndIf
				
    Next
		

    $sql_insert = "INSERT INTO [CF] ([order], [Order_Type], [Date], [Cust_Num], [Cust_Name], [Addy_Num], [Address_1], [Address_2], [Address_3], [City], [State], [Zip], [Sent], [Zone]) Values ('"&$order_number&"','"&$order_type&"','"&$order_date&"','"&$customer_num&"','"&$customer_name&"','"&$customer_address_num&"','"&$customer_address1&"','"&$customer_address2&"','"&$customer_address3&"','"&$city&"','"&$state&"','"&$zip&"',0,'"&$zone&"')"
	
	$oArray = ObjCreate("ADODB.Recordset")
	$oArray.Open($sql_insert, $oConn, 1, 3)
	$oRS.MoveNext
	
Next

$oRS.close
_DebugOut( "The Preload List is complete" )

EndFunc

Func PrintStatBag($line1)

Local $oAccess = _AccessOpen($file)
Local $oRS
Local $oConn
Local $Dazzle_Folder = "c:\Program Files\Envelope Manager\DAZzle"

; Load ADODB connection
$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

; Load SQL query
$sql_zone_bag = "Select * from Zones where Zones.Zone like '"&$line1&"' ORDER BY Zones.Zip ASC"

; Run SQL Query
$oRS.Open($sql_zone_bag, $oConn, 1, 3)

$print_bag_zip = $oRS.Fields("Zip").value
$print_bag_name = $oRS.Fields("Name").value
$print_bag_zone = $oRS.Fields("Zone").value



_DebugOut( "Printing Stat Bag, "&$line1&", "&$print_bag_zip&", "&$print_bag_name&", "&$print_bag_zone)

$oAccess.Run("Load_Zip", $print_bag_zip, $print_bag_name, $print_bag_zone)

;Uncomment to print this label (Once you uncomment this you will print the bag labels every 20 bags and at the end

;--------------------------------------------------------

$oAccess.docmd.RunMacro("print_bag", 1)

;--------------------------------------------------------


$oAccess.CloseCurrentDatabase()
$oConn.Close
$oConn = 0

EndFunc

func SetBatch()
	
Local $oAccess = _AccessOpen($file)

Local $oRS
Local $oConn
Local $Dazzle_Folder = "c:\Program Files\Envelope Manager\DAZzle"

$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")

; Setup Zone Array for matching address by zip

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

$sql_top = "Select TOP 1 * from CF ORDER BY CF.batch DESC"

$oRS.Open($sql_top, $oConn, 1, 3)

$lastBatch = $oRS.Fields("batch").value

$currentBatch = $lastBatch + 1

Return($currentBatch)

$oConn.Close
	

EndFunc

Func Print($var1)

Local $oAccess = _AccessOpen($file)
Local $oRS
Local $oConn
Local $Dazzle_Folder = "c:\Program Files\Envelope Manager\DAZzle"

; Load ADODB connection
$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

; Load SQL query
$sql2 = "Select * FROM CF where CF.sent = '0' and CF.response IS NOT NULL order by CF.zone ASC"

; Run SQL Query
$oRS.Open($sql2, $oConn, 1, 3)

; Loop through count total or run all checked
If GuiCtrlRead($time_to_loop) = $GUI_CHECKED Then
	$loop = $oRS.RecordCount
Else
	$loop = GUICtrlRead($catalogs_to_print)
EndIf

$total_count = 1
$loopIndex = 1
$statbag_count = 1
$last_zone = 0
$current_zone = 0

While $loopIndex < $loop

$print_order_number = $oRS.Fields("order").value
$print_order_type = $oRS.Fields("Order_Type").value
$print_order_date = $oRS.Fields("Date").value
$print_customer_num = $oRS.Fields("Cust_Num").value
$print_customer_address_num = $oRS.Fields("Addy_Num").value
$print_customer_name = $oRS.Fields("Cust_Name").value
$print_customer_address1 = $oRS.Fields("Address_1").value
$print_customer_address2 = $oRS.Fields("Address_2").value
$print_customer_address3 = $oRS.Fields("Address_3").value
$print_city = $oRS.Fields("City").value
$print_state = $oRS.Fields("State").value
$print_zone = $oRS.Fields("Zone").value
$print_zip = $oRS.Fields("Zip").value
$current_zone = $print_zone

If $Catalogs_per_bag < $statbag_count Then

PrintStatBag($current_zone)
$statbag_count = 1

ElseIf $last_zone = 0 Then
	
	_DebugOut($current_zone&", This should be 0 First Run")

ElseIf $last_zone <> $current_zone Then
_debugout($last_zone&", "&$current_zone)
PrintStatBag($last_zone)
$statbag_count = 1

EndIf




  ;Pre Load Access with correct variables
  $oAccess.Run("Load_Vars", $print_customer_name, $print_customer_num, $print_customer_address1, $print_customer_address2, $print_customer_address3, $print_city, $print_state, $print_zip, $print_zone)
   
  _DebugOut($print_order_number&", "&$print_order_number&", "&$current_zone&", "&$statbag_count)
 
  
  ;Print Label with previous variables
  
  ;--------------------------------------------------- UNCOMMENT TO PRINT -------------------------------------------------------------------
  
  $oAccess.docmd.RunMacro("print", 1)
  
  ;------------------------------------------------------------------------------------------------------------------------------------------
  
  $sql_update = "Update CF Set Sent = 1, batch = "&$var1&" where CF.order = "&$print_order_number
  $oRS2 = ObjCreate("ADODB.Recordset")
  $oRS2.Open($sql_update, $oConn, 1, 3)
  _debugout( $sql_update )
  
  $total_count = $total_count + 1
  $loopIndex = $loopIndex + 1
  $statbag_count = $statbag_count + 1
  $oRS.MoveNext
  
  $last_zone = $current_zone
  
  ; Total Count used for testing loop to verify final bag will print
  ;_debugout($total_count)
  
  ; Print Stat Bag if last record
  if $total_count >= $loop Then
	  _Debugout("The Final Record, sending additional print")
	  PrintStatBag($current_zone)
  EndIf

WEnd

EndFunc

Func OKButton()
	
; Run the Batch Set (This will find the last batch number and increment it)
$batch = SetBatch()
; Run the Preload Function and Pre Load all new orders to the Access database copy
Preload();

; Load all variables needed
Local $oAccess = _AccessOpen($file)
Local $oRS
Local $oConn
Local $Dazzle_Folder = "c:\Program Files\Envelope Manager\DAZzle"

; Load ADODB connection
$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")

$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

; Load SQL query
$sql2 = "Select * FROM CF where CF.sent = '0' and CF.response IS NULL order by CF.order ASC"

; Run SQL Query
$oRS.Open($sql2, $oConn, 1, 3)

; Loop through count total or run all checked
If GuiCtrlRead($time_to_loop) = $GUI_CHECKED Then
	$loop = $oRS.RecordCount
Else
	$loop = GUICtrlRead($catalogs_to_print)
EndIf

$badIndex = 0
$iIndex = 1
While $iIndex <= $loop and ($iIndex+$badIndex) <= $oRS.RecordCount
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
  
  $XMLfilename = 'verification.xml'
  
  $XMLfile = FileOpen($Dazzle_Folder&'\verification.xml', 2)

	If $file = -1 Then
	
	_debugout( "Couldn't open XML file for wrighting "&$order_numF )
	; MsgBox(0, "Couldn't Open XML File for wrighting", "")
	
	ExitLoop
	EndIf
   
  FileWriteLine($XMLfile, '<DAZzle start="DAZ" prompt="NO" autoclose="YES">')
  FileWriteLine($XMLfile, '<Package ID="'&$order_numF&'">')
  FileWriteLine($XMLfile, '<ToTitle></ToTitle>')
  FileWriteLine($XMLfile, '<ToCompany></ToCompany>')
  FileWriteLine($XMLfile, '<ToAddress1>'&$customer_address1F&'</ToAddress1>')
  FileWriteLine($XMLfile, '<ToAddress2>'&$customer_address2F&'</ToAddress2>')
  FileWriteLine($XMLfile, '<ToAddress3>'&$customer_address3F&'</ToAddress3>')
  FileWriteLine($XMLfile, '<ToAddress4></ToAddress4>')
  FileWriteLine($XMLfile, '<ToAddress5></ToAddress5>')
  FileWriteLine($XMLfile, '<ToAddress6></ToAddress6>')
  FileWriteLine($XMLfile, '<ToCity>'&$cityF&'</ToCity>')
  FileWriteLine($XMLfile, '<ToState>'&$stateF&'</ToState>')
  FileWriteLine($XMLfile, '<ToPostalCode>'&$zipF&'</ToPostalCode>')
  FileWriteLine($XMLfile, '<ToZIP4></ToZIP4>')
  FileWriteLine($XMLfile, '<ToCountry></ToCountry>')
  FileWriteLine($XMLfile, '<ToDeliveryPoint></ToDeliveryPoint>')
  FileWriteLine($XMLfile, '<ToCountry></ToCountry>')
  FileWriteLine($XMLfile, '<ToCarrierRoute></ToCarrierRoute>')
  FileWriteLine($XMLfile, '<ToReturnCode></ToReturnCode>')
  FileWriteLine($XMLfile, '</Package>')
  FileWriteLine($XMLfile, '</DAZzle>')

  FileClose($XMLfile)
  
  if $XMLfile = -1 Then
	  _debugout ("Autoit Didn't successfully close the XML file sleeping.")
	  sleep (2000)
	  FileClose($XMLfile)
  EndIf
  
  _debugout ("Finished Wrighting to XML file")
  _debugout($XMLfile)
  
  $cmd = "dazzle.exe "&$XMLfilename
  ;MsgBox (0, "About to call Dazzle", "DAZZLE is about to run! "&$cmd)
  
  ;$success = RunWait(@ComSpec & " /c " & $cmd, @ScriptDir, @SW_HIDE)

 do
 sleep (200)
 $success = Run(@ComSpec & " /c " & $cmd, $Dazzle_Folder, @SW_HIDE)

 if WinExists("[TITLE:DAZzle Designer; CLASS:#32770]", ".xml") Then
_debugout("Couldn't create output file")
 WinActivate("[TITLE:DAZzle Designer; CLASS:#32770]", "")
 Send("{ENTER}")
 WinActivate("[TITLE:DAZzle Designer; CLASS:#32770]", "")
 Send("{ENTER}")
  Sleep(600)
 $success = Run(@ComSpec & " /c " & $cmd, $Dazzle_Folder, @SW_HIDE)
 EndIf	 
	 
 until WinWait("Dial-A-ZIP® for Lists", "", "")
 
 if WinExists("Dial-A-ZIP® for Lists", "") Then
 WinActivate( "Dial-A-ZIP® for Lists", "")
 Send("O")
 EndIf
  
 $sXMLfile = $Dazzle_Folder&'\verification.xml'


  _debugout ("About to Open XML file")
  $result = _XMLFileOpen($sXMLFile)
  if @error then 
  
  _debugout ("Failed to open XML file for reading Dazzle is not done with it yet #"&$order_numF )
  _debugout ("Sleeping will try again")
   sleep (2000)
   
   $result = _XMLFileOpen($sXMLFile)
   if @error then 
	_debugout ("Second Sleep Failed, Skipping"&$order_numF)
	EndIf

  EndIf

  $customer_address1F = _XMLGetValue ("/DAZzle/Package/ToAddress1")
  $customer_address2F = _XMLGetValue ("/DAZzle/Package/ToAddress2")
  $customer_address3F = _XMLGetValue ("/DAZzle/Package/ToAddress3")
  $cityF = _XMLGetValue ("/DAZzle/Package/ToCity")
  $stateF = _XMLGetValue ("/DAZzle/Package/ToState")
  $zipF = _XMLGetValue ("/DAZzle/Package/ToPostalCode")
  $response = _XMLGetValue ("/DAZzle/Package/ToReturnCode")
  
  $zipleft3F = StringMid( $zipF[1], 1, 3)
  	For $zoneI = 1 To (Ubound($ZoneArr)-1)
		if $ZoneArr[$zoneI][0] = $zipleft3F Then
			$zoneF = $ZoneArr[$zoneI][1]
	ElseIf $ZoneArr[$zoneI][0] < $zipleft3F Then
			$zoneF = $ZoneArr[$zoneI][1]
	EndIf
				
    Next
  ;msgbox (0, "Repsonse", "The Response code was "&$response[1])

if @error = 0 Then

  if $response[1] = 32 or $response[1] = 31 or $response[1] = 25 Then
  
  ;$sql3 = "Update CF Set Sent = 1, response = "&$response[1]&", zone = "&$zoneF&" where CF.order = "&$order_numF
  $sql3 = "Update CF Set Sent = 0, response = "&$response[1]&", zone = "&$zoneF&" where CF.order = "&$order_numF
  
  ;MsgBox(1 , "Test SQL3", $sql3)
  $oRS2 = ObjCreate("ADODB.Recordset")
  $oRS2.Open($sql3, $oConn, 1, 3)
  _debugout( $sql3 )
  $iIndex = $iIndex + 1
  
  Else

  if $response[1] = '' Then
	  $response[1] = '0'
  EndIf
  ;MsgBox(0, "Address Couldn't Verify", "Address did not verify and threw error "&$response)
  ;$sql4 = "Update CF Set Sent = 2, response = "&$response[1]&" where CF.order = "&$order_numF
  $sql4 = "Update CF Set Sent = 2, response = "&$response[1]&", zone = "&$zoneF&" where CF.order = "&$order_numF
  _debugout( $sql4 )
  $oRS3 = ObjCreate("ADODB.Recordset")
  $oRS3.Open($sql4, $oConn, 1, 3)
  
  $badIndex = $badIndex + 1
  
  EndIf
  
Else
	
	;Msgbox (0, "Subscript?", @error&" Error code, did not find XML for Order "&$order_numF)
	_debugout( "Couldn't find Response code for order #:"&$order_numF)
EndIf
  
  $oRS.MoveNext
    
WEnd

$oAccess.CloseCurrentDatabase()
$oConn.Close
$oConn = 0

Print($batch)

MsgBox (0, "Finished", "Finished Printing your run of catalogs")

EndFunc

Func MyErrFunc()
	$HexNumber = Hex($oMyError.number, 8)
	;MsgBox(0, "COM Test", "We intercepted a COM Error !" & @CRLF & @CRLF & _
	;		"err.description is: " & @TAB & $oMyError.description & @CRLF & _
	;		"err.windescription:" & @TAB & $oMyError.windescription & @CRLF & _
	;		"err.number is: " & @TAB & $HexNumber & @CRLF & _
	;		"err.lastdllerror is: " & @TAB & $oMyError.lastdllerror & @CRLF & _
	;		"err.scriptline is: " & @TAB & $oMyError.scriptline & @CRLF & _
	;		"err.source is: " & @TAB & $oMyError.source & @CRLF & _
	;		"err.helpfile is: " & @TAB & $oMyError.helpfile & @CRLF & _
	;		"err.helpcontext is: " & @TAB & $oMyError.helpcontext _
	;		)
		;_debugOut ("!!!! ERROR !!!! order number #"&$order_numF )
		_debugout ("err.description is: " & @TAB & $oMyError.description & @CRLF & _
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