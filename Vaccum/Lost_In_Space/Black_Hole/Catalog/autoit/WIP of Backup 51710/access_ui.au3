; Should Open Access File so that we can print the data we need!
Func _AccessOpen($sFilePath)
	Local $oAccess = ObjCreate("Access.Application")
	If NOT IsObj($oAccess) Then Return SetError(1, 0, 0)
	If NOT FileExists($sFilePath) Then Return SetError(2, 0, 0)
	$oAccess.OpenCurrentDatabase($sFilePath)
	Return $oAccess
EndFunc ;==>_AccessOpen

Func _AccessReport($oAccess, $label)
	$oAccess.DoCmd.OpenReport($label).acPreview
EndFunc