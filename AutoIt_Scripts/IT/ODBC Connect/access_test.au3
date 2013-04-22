Local $oRS
Local $oConn

$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")
$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=reception_notes.mdb")

$oRS.Open("Select * FROM reception_notes where ohorno = 8015052", $oConn, 1, 3)


For $iIndex = 1 To $oRS.RecordCount
	MsgBox(1,"", "There are " & $oRS.RecordCount & " product records." & " They are" & $oRS.Fields("OLPRDC").value)
	$oRS.MoveNext
Next


$oConn.Close
$oConn = 0