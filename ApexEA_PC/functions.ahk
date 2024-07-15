; ____________________________________________________ Functions Seperator ____________________________________________________

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

  if (urls.MaxIndex() < 0) {
    Run, %runprogram%
  } else {
    for index, url in urls {
      Run, %runprogram% %url%
      Sleep, 1500
    }
  }
}

WindowAppRun() {
  RunWait, "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EALauncher.exe"
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

ScrollDown(times) {
  Loop %times% {
    Send {WheelDown}
    Sleep, 100
  }
}

; ____________________________________________________ Functions Seperator ____________________________________________________

; Random EA Generator
EAFunc() {
  IniRead, count, settings.ini, Settings, counter
  count := count + 1

  eaid := "RfrBeta_B"count
  eapass := EAPassFunc()

  IniWrite, %count%, settings.ini, Settings, counter

  return { eaid: eaid, eapass: eapass }
}

; Firefox Incagnito
firefoxIncog() {
  Run, firefox.exe -private-window https://ea.com/register
}

PingInternet() {
  RunWait, %ComSpec% /c ping -n 1 google.com, , Hide
  if (ErrorLevel = 0) {
    return 1
  } else {
    return 0
  }
}

DeleteTempFiles() {
  FileDelete, %A_Temp%\*.*
  MsgBox, 0, , Temporary files deleted., 2
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

AppendDiscordText(text, filePath) {
  if FileExist(filePath) {
    FileDelete, % filePath
  }

  FileAppend, % text, % filePath
}

SaveDetailsToCSV(EmailAddress, EmailPassword, EaId, EaPass, SecondaryGmail, IpAddress, CreatedAt) {
  csvFile := "./data/temp.csv"

  if (!FileExist(csvFile)) {
    header := "Email,Email Password,Ea,Ea Password,Secondary Email,Ip,Created At`n"
    FileAppend, % header, % csvFile
  }

  dataRow := EmailAddress . "," . EmailPassword . "," . EaId . "," . EaPass . "," . SecondaryGmail . "," . IpAddress . "," . CreatedAt . "`n"

  FileAppend, % dataRow, % csvFile
}

; Extract EA Code
ExtractValue(value) {
  RegExMatch(value, "Point\(x=(\d+), y=(\d+)\)", output) 
  return { x: output1, y: output2 }
}

; ____________________________________________________ Functions Seperator ____________________________________________________

IniReadFunc(WorkingDir) {
  RunWait, py "%WorkingDir%ea.py", %WorkingDir%, hide

  Sleep, 1000
  filename := "config.ini"

  IniRead, isData, config.ini, Results, data
  IniRead, isLogin, config.ini, Results, login
  IniRead, isDataoff, config.ini, Results, dataoff
  IniRead, isSearch, config.ini, Results, search
  IniRead, isDob, config.ini, Results, dob
  IniRead, isCred, config.ini, Results, cred
  IniRead, isAgree, config.ini, Results, agree
  IniRead, isCode, config.ini, Results, code
  IniRead, isTech, config.ini, Results, tech
  IniRead, isFinish, config.ini, Results, finish
  IniRead, isAddemail, config.ini, Results, addemail
  IniRead, isVerify, config.ini, Results, verify
  IniRead, isVerifybtn, config.ini, Results, verifybtn
  IniRead, isContinue, config.ini, Results, continue
  IniRead, isSubmit, config.ini, Results, submit
  IniRead, isCaptcha, config.ini, Results, captcha
  IniRead, isCreate, config.ini, Results, create

  Return { isData: isData, isLogin: isLogin, isDataoff: isDataoff, isSearch: isSearch, isDob: isDob, isCred: isCred, isAgree: isAgree, isCode: isCode, isTech: isTech, isFinish: isFinish, isAddemail: isAddemail, isVerify: isVerify, isVerifybtn: isVerifybtn, isContinue: isContinue, isSubmit: isSubmit, isCaptcha: isCaptcha, isCreate: isCreate }
}

; Gmail Variations Function
ReadAndRemoveFirstLine(filePath) {
  if !FileExist(filePath)
    return ""

  FileRead, fileContents, % filePath
  lines := StrSplit(fileContents, "`n", "`r")

  if lines.MaxIndex() = 0
    return ""

  firstLine := lines[1]
  lines.RemoveAt(1)

  file := FileOpen(filePath, "w")
  Loop, % lines.MaxIndex()
    file.WriteLine(lines[A_Index])
  file.Close()

  return firstLine
}

; Current Time / Date
GetCurrentDateTime() {
  FormatTime, currentTime,, HH:mm:ss dd/MM/yyyy
  return currentTime
}

; Clean Data
CleanData(data) {
  StringReplace, data, data, `n, , All
  StringReplace, data, data, `r, , All
  return data
}