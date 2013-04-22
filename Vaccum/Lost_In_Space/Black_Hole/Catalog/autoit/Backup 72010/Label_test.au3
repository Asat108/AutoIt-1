#include <access_ui.au3>

$file = "C:\Documents and Settings\michael\Desktop\Catalog\autoit\labels2.mdb"
$label = "catalog_label"
$view = "acViewPreview"

Local $oRS
Local $oConn


$oConn = ObjCreate("ADODB.Connection")
$oRS = ObjCreate("ADODB.Recordset")
$oConn.Open("Driver={Microsoft Access Driver (*.mdb)};Dbq=labels2.mdb")

Local $oAccess = _AccessOpen($file)

$customer_numF = 'WEB554382'
$customer_nameF = 'Venisha Robinson'
$customer_address1F = '341 W. Copeland Dr.'
$customer_address2F = '#725'
$customer_address3F = ''
$customer_address4F = 'Carmel'
$stateF = 'Indiana'
$zipF = '46032'


$oAccess.Run("Load_Vars", $customer_nameF, $customer_numF, $customer_address1F, $customer_address2F, $customer_address3F, $customer_address4F, $stateF, $zipF)

$oAccess.docmd.RunMacro("print", 1)



$oAccess.CloseCurrentDatabase()
$oConn.Close
$oConn = 0

