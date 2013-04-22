$conn = ObjCreate( "ADODB.Connection" )
$DSN = "PROVIDER={iSeries Access ODBC Driver};SERVER=192.168.254.80\JEWELRYSUPPLY;DATABASE=JS1380BFJS;UID=wse;PWD=wse;"
$conn.Open($DSN)
$rs = ObjCreate( "ADODB.RecordSet" )
$rs.Open( "SELECT * from SROOSHE", $conn )
MsgBox(0, "AutoIT-SQL Result", "Value = " & $rs.Fields( "myVersion" ).Value )
$conn.close 