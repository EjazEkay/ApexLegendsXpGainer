#Include, functions.ahk
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

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

; WindowRun("windowssandbox")
; isDob := ImageSearchFunc(Dob)
; MsgBox, % "Details: " isDob.found

; IniRead, gmailFilePath, settings.ini, Settings, gmailFile

; nextGmail := ReadAndRemoveFirstLine(gmailFilePath)

; MsgBox, % nextGmail
; ; ihsa.n.s.u.l.ta.n01.23@gmail.com

; test := GetCurrentDateTime()
; MsgBox, %test%

; Sample data
; EmailAddress := "@gmail.com"
; EmailPassword := "password123"
; EaId := "ea_username"
; EaPass := "ea_password"
; SecondaryGmail := "secondary@gmail.com"
; IpAddress := "192.168.1.1"
; CreatedAt := GetCurrentDateTime()

; ; Save details to CSV file
; SaveDetailsToCSV(EmailAddress, EmailPassword, EaId, EaPass, SecondaryGmail, IpAddress, CreatedAt)
; IniRead, sandboxTitle, settings.ini, Settings, sandboxtitle

; WindowClose(sandboxTitle)

; Loop {
;   avl := SearchFunc()

;   MsgBox, % "IsDob: " . avl.isDob.found
; Sleep, 3000

; }
; IniRead, gmailFilePath, settings.ini, Settings, gmailFile

; If (usedFlag > maxUsedFlag) {
;   usedFlag := 0
;   SecondaryGmail := ReadAndRemoveFirstLine(gmailFilePath)
; } Else {
;   file := FileOpen(gmailFilePath, "r")
;   SecondaryGmail := file.ReadLine()
;   file.Close()
; }

; MsgBox, %SecondaryGmail%

; WindowSwap("Mobile WiFi  Mozilla Firefox")