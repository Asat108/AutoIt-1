;;; This scipt deletes ZenCart orders via the Admin in IE
;;; An admin needs to be signed on before this scipt can run

#include <IE.au3>
$oIE = _IECreate ("www.jewelrysupply.com/jsadmin/")
_IENavigate ($oIE, "http://www.jewelrysupply.com/jsadmin/orders.php?page=5000")
_IELoadWait ($oIE)

$maxOrders = 1000 ;  Sets the max number of orders to delete
$i = 0
While $i < $maxOrders   
	
	; Loop to click 1st delete
		$sMyString = "Delete"
		$oLinks = _IELinkGetCollection($oIE)
			For $oLink in $oLinks
				$sLinkText = _IEPropertyGet($oLink, "innerhtml")
				If StringInStr($sLinkText, $sMyString) Then
					_IEAction($oLink, "click")
					ExitLoop
				EndIf
			Next
			
_IELoadWait ($oIE)

	; Finds and trims selected order number in url
		$titleText = WinGetText ("Zen Cart - Microsoft Internet Explorer")
		$LeftTrim = StringTrimLeft( $titleText, 62)
		$FinalTrim = StringLeft( $LeftTrim, 7)
		
		
	; Loop to check if order # is less than criteria and then deletes
		If $FinalTrim < 3058000 Then 
			_IEFormImageClick ($oIE, "Delete", "alt")
			_IELoadWait ($oIE)
			Else 
			Exit 
		EndIf
$i = $i + 1
WEnd

	