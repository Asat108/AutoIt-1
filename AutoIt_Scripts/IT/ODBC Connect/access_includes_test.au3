#include <access_ui.au3>

local $oAccess = _AccessOpen("reception_notes.mdb")

$oAccess.DoCmd.OpenReport("label", "acViewNormal")

;$oAccess.DoCmd.OpenReport("label")