; ____________________________________________________ Images Paths ____________________________________________________

global Data := "./images/data.png"
global Login := "./images/login.png"
global Data_Off := "./images/data_off.png"
global Search := "./images/search.png"
global Dob := "./images/dob.png"
global Cred := "./images/cred.png"
global Agree := "./images/agree.png"
global Code := "./images/code.png"
global Tech := "./images/tech.png"

; ____________________________________________________ Functions Seperator ____________________________________________________

; Image Search Function
ImageSearchFunc(image, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
  ImageSearch, x, y, startX, startY, endX, endY, *variation %image%
  found := !ErrorLevel
  Return { found: found, x: x, y: y }
}

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

WindowSwap(title) {
  If WinExist(title) {
    WinActivate
  } Else {
    MsgBox, 0, Error: Screen not found, The window "%title%" was not found.
    ExitApp
  }
}

WindowRun(program, urls*) {
  extension := ".exe"
  runprogram := program . extension

  if (urls.MaxIndex() > 0) {
    for index, url in urls {
      Run, %runprogram% %url%
      Sleep, 1500
    }
  }
}

WindowClose(title) {
  If WinExist(title) {
    WinClose, %title%
  } Else {
    MsgBox, 0, Error: The window with the title "%title%" does not exist.
  }
}

TabSwap(next := 0, prev := 0, newTab := 0) {
  If next
    KeysFunc("tab", "^")
  Else If prev
    KeysFunc("tab", "^+")
  Else If newTab
    KeysFunc("t", "^")
}

; ____________________________________________________ Functions Seperator ____________________________________________________

; Random EA Generator
EAFunc() {
  IniRead, count, settings.ini, Settings, counter

  eaid := "larry2018_A"count
  eapass := "Milkymagic@0123"

  count := count + 1
  IniWrite, %count%, settings.ini, Settings, counter

  return { eaid: eaid, eapass: eapass }
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

AppendDiscordText(text, filePath) {
  if FileExist(filePath) {
    FileDelete, % filePath
  }

  FileAppend, % text, % filePath
}

; ____________________________________________________ Functions Seperator ____________________________________________________

SearchFunc() {
  isData := ImageSearchFunc(Data)
  isLogin := ImageSearchFunc(Login)
  isData_Off := ImageSearchFunc(Data_Off)
  isSearch := ImageSearchFunc(Search)
  isDob := ImageSearchFunc(Dob)
  isCred := ImageSearchFunc(Cred)
  isAgree := ImageSearchFunc(Agree)
  isCode := ImageSearchFunc(Code)
  isTech := ImageSearchFunc(Tech)

  Return { isData: isData, isLogin: isLogin, isData_Off: isData_Off, isSearch: isSearch, isDob: isDob, isCred: isCred, isAgree: isAgree, isCode: isCode, isTech: isTech }
}