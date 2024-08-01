; ____________________________________________________ Functions Seperator ____________________________________________________

; ; Image Search Function
; ImageSearchFunc(image, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
;   ImageSearch, x, y, startX, startY, endX, endY, *variation %image%
;   found := !ErrorLevel
;   Return { found: found, x: x, y: y }
; }

; ; Pixel Search Function
; PixelSearchFunc(color, ByRef x, ByRef y, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
;   PixelSearch, x, y, startX, startY, endX, endY, %color%, variation, Fast RGB
;   Return !ErrorLevel
; }

; Click Perform Function
ClickFunc(coordX, coordY, doubleclick := 0, oldposition := 0, speed := 10, delay := 1000) {
  If oldposition {
    MouseGetPos, startX, startY
    MouseMove, coordX, coordY, speed
    Click
    Sleep, delay
    MouseMove, startX, startY, speed
    If (doubleclick) {
      MouseMove, coordX, coordY, speed
      Click
      MouseMove, startX, startY, speed
    }
    Sleep, delay
  } Else {
    MouseMove, coordX, coordY, speed
    Click
    Sleep, delay
    If doubleclick
      Click
    Sleep, delay
  }
}

; Keyboard Shortcut Key Function - ^ for Ctrl | ! for Alt | + for Shift | # for Win (Windows key)
KeysFunc(key, combination := "", repeat := 1, delay := 1000) {
  Loop, %repeat% {
    SendInput, %combination%{%key%}
    Sleep, delay
  }
}

; ____________________________________________________ Functions Seperator ____________________________________________________

; Extract Email
ExtractEmail(text) {
  RegExMatch(text, "in as:\s*([^\s]+@[^ ]+)`n\s*`nPassword:", match)

  If match1
    return match1
  Else
    Return 0
}

; Extract Password Email
ExtractPassword(text) {
  RegExMatch(text, "Password:\s*([^\s]+)\s*", match)

  If match1
    Return Match1
  Else
    Return 0
}

; Extract IP Function
ExtractIP(text) {
  RegExMatch(text, """ip"":\s*""([^""]+)""", match)

  If match1
    return match1
  Else
    Return 0
}

; Extract EA Code
ExtractCode(Text) {
  RegExMatch(Text, "Code is:\s*(\d{6})", match)

  If match1
    Return match1
  Else
    Return 0
}

; Extract EA Code
ExtractValue(value) {
  RegExMatch(value, "Point\(x=(\d+), y=(\d+)\)", output) 
  return { x: output1, y: output2 }
}

; ____________________________________________________ Functions Seperator ____________________________________________________

; Random EA ID Generator
EAIDFunc() {
  IniRead, count, settings.ini, Settings, COUNTER

  eaid := "larrydakuta_A"count

  count := count + 1
  IniWrite, %count%, settings.ini, Settings, COUNTER

  return eaid
}

; Random EA Password Generator
EAPassFunc() {
  ; Define the character sets
  smallLetters := "abcdefghijklmnopqrstuvwxyz"
  capitalLetters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  numbers := "0123456789"

  Random, capIndex, 1, 26
  capitalLetter := SubStr(capitalLetters, capIndex, 1)

  Random, numIndex, 1, 10
  number := SubStr(numbers, numIndex, 1)

  smallPassword := ""
  Loop, 6 {
    Random, letterIndex, 1, 26
    smallPassword .= SubStr(smallLetters, letterIndex, 1)
  }

  Return capitalLetter . smallPassword . number
}

TabsFunc(tabnext := 0, tabprev := 0, tabnew := 0) {
  If tabnext
    KeysFunc("tab", "^", , 1500)
  Else If tabprev
    KeysFunc("tab", "^+", , 1500)
  Else If tabnew
    KeysFunc("n", "^+", , 1500)
}

SaveData(counter, email, pasword, ea, eapass, ip) {
  CredentialDetails := % "# Account - [" . counter . "]`n"
  CredentialDetails .= "Email Address: " . email . "`n"
  CredentialDetails .= "Email Password: " . pasword . "`n"
  CredentialDetails .= "EA Identity: " . ea . "`n"
  CredentialDetails .= "EA Password: " . eapass . "`n"
  CredentialDetails .= "Created Ip: " . ip . "`n`n"

  OutputFile := "./data/details.txt"
  FileAppend, % CredentialDetails, % OutputFile

  Return CredentialDetails
}

; PostToDiscord(message, url) {
;   message := StrReplace(message, "`n", "\n")

;   payload := "{""content"": """ . message . """}"

;   http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
;   http.Open("POST", url)
;   http.SetRequestHeader("Content-Type", "application/json")

;   try {
;     http.Send(payload)

;     if (http.Status != 204)
;       throw "Error: Unexpected error"

;   } catch error {
;     MsgBox, 0, Error, % "Error sending message to Discord:`n" . error, 3
;   }
; }

AppendDiscordText(text, filePath) {
  if FileExist(filePath) {
    FileDelete, % filePath
  }

  FileAppend, % text, % filePath
}

; ____________________________________________________ Functions Seperator ____________________________________________________

IniReadFunc() {
  IniRead, isplane, config.ini, Results, airplane
  IniRead, isincog, config.ini, Results, incagnito
  IniRead, ishome, config.ini, Results, home
  IniRead, isback, config.ini, Results, back
  IniRead, isreload, config.ini, Results, reload
  IniRead, ismail, config.ini, Results, mail
  IniRead, isdetails, config.ini, Results, details
  IniRead, isemail, config.ini, Results, email
  IniRead, isdate, config.ini, Results, date
  IniRead, iscredential, config.ini, Results, credential
  IniRead, isverify, config.ini, Results, verify
  IniRead, isagree, config.ini, Results, agree
  IniRead, isfinish, config.ini, Results, finish
  IniRead, isprofile, config.ini, Results, profile
  IniRead, istechnical, config.ini, Results, technical
  IniRead, isip, config.ini, Results, ip
  IniRead, iscaptcha, config.ini, Results, captcha
  ; IniRead, isemailback, config.ini, Results, emailback

  Return { isplane: isplane, isincog: isincog, ishome: ishome, isback: isback, isreload: isreload, ismail: ismail, isdetails: isdetails, isemail: isemail, isdate: isdate, iscredential: iscredential, isverify: isverify, isagree: isagree, isfinish: isfinish, isprofile: isprofile, istechnical: istechnical, isip: isip }
}