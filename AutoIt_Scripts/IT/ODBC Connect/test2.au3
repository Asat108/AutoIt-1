$conn = ObjCreate( "ADODB.Connection" )
$DSN = "Driver={iSeries Access ODBC Driver};System=192.168.254.80;DSN=JEWELRYSUPPLY;Uid=wse;Pwd=wse;"
$conn.Open($DSN)
$rs = ObjCreate( "ADODB.RecordSet" )
$rs.Open( "select * from sroorshe;", $conn )
MsgBox(0, "AutoIT-SQL Result", "Value = " & $rs.Fields( "BANNER" ).Value )
$conn.close
