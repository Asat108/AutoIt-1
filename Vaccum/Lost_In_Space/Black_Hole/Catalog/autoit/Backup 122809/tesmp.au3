Local $Dazzle_Folder = "c:\Program Files\Envelope Manager\DAZzle"
$XMLfilename = 'verification.xml'

$cmd = "dazzle.exe "&$XMLfilename
  
;$success = RunWait(@ComSpec & " /c " & $cmd, @ScriptDir, @SW_HIDE)
$success = RunWait(@ComSpec & " /c " & $cmd, $Dazzle_Folder, @SW_MAXIMIZE)