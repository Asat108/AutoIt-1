Global $outputArrayRS [1][1]
Global $fieldCount
Global $recordCount

$tableName = "TungHsin-New"
$dataBase = "TEST_overStock_label.mdb"
$query = "Select * From " & $tableName

ReadDBDataToArray($query, $dataBase)

printOutput()

Func ReadDBDataToArray($_sql, $_dbname)
    $adoCon = ObjCreate ("ADODB.Connection")
    $adoCon.Open ("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $_dbname)
    $adoRs = ObjCreate ("ADODB.Recordset")
    $adoRs.CursorType = 1
    $adoRs.LockType = 3
    $adoRs.Open ($_sql, $adoCon)
    $fieldCount = $adoRs.Fields.Count
    $recordCount = $adoRs.RecordCount
    ReDim $outputArrayRS[$recordCount][$fieldCount]
    $outputArrayRS = $adoRs.GetRows()
    $adoCon.Close
EndFunc

; just a tiny function to test if array is populated correctly.
Func printOutput()
    For $x = 0 to $recordCount -1 Step 1
        For $y = 0 to $fieldCount - 1 Step 1
            MsgBox(0, "test", $outputArrayRS[$x][$y])
        Next
    Next
EndFunc