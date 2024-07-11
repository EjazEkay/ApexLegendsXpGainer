#Include, functions.ahk

; ; regtext := Clipboard
; ; Email := ExtractEmail(regtext)
; ; Email := StrReplace(ExtractEmail(regtext), "`r", "")
; ; MsgBox, Email: %Email%,

; IniRead, huawei_URL, settings.ini, Settings, HUAWEI
; IniRead, ipinfo_URL, settings.ini, Settings, IPINFO
; IniRead, mail_URL, settings.ini, Settings, MAILTM
; IniRead, gmail_URL, settings.ini, Settings, GMAIL

; Sleep, 1000
; WindowRun("firefox", huawei_URL, ipinfo_URL, mail_URL, gmail_URL)

; avl := SearchFunc()
; MsgBox, % "Data Image: " avl.isData.found

; text := ""
; text := Clipboard

; IpAddress := ExtractIP(text)
; Password := ExtractPassword(text)
; Email := ExtractEmail(text)
; Code := ExtractCode(text)

; text := ""

; MsgBox, %IpAddress%, %Password%, %Email%, %Code%

; Create a WinHttpRequest object

; WorkingDir := A_ScriptDir "\py\"
; RunWait, py "%WorkingDir%ip.py", %WorkingDir%

; MsgBox, %IpAddress%

; WorkingDir := A_ScriptDir "\py\"
; RunWait, py "%WorkingDir%createMail.py", %WorkingDir%

WindowRun("WindowsSandbox")
