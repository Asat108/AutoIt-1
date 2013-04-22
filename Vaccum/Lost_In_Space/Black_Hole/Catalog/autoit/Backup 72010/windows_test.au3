Do
 sleep (50)
until WinExists("Dial-A-ZIP® for Lists", "") or WinExists("[TITLE:DAZzle Designer; CLASS:#32770]", "")
 
if WinExists("Dial-A-ZIP® for Lists", "") Then
 WinActivate( "Dial-A-ZIP® for Lists", "")
 Send("O")
 
 Elseif WinExists("[TITLE:DAZzle Designer; CLASS:#32770]", "") Then
 WinActivate("[TITLE:DAZzle Designer; CLASS:#32770]", "")
 Send("{ENTER}")
 
 WinExists("[TITLE:DAZzle Designer; CLASS:#32770]", "")
 WinActivate("[TITLE:DAZzle Designer; CLASS:#32770]", "")
 Send("{ENTER}")
 EndIf
 