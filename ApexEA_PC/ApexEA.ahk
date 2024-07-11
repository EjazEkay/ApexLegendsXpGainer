;      _    ____  _______  __  _     _____ ____ _____ _   _ ____  ____  
;     / \  |  _ \| ____\ \/ / | |   | ____/ ___| ____| \ | |  _ \/ ___| 
;    / _ \ | |_) |  _|  \  /  | |   |  _|| |  _|  _| |  \| | | | \___ \ 
;   / ___ \|  __/| |___ /  \  | |___| |__| |_| | |___| |\  | |_| |___) |
;  /_/   \_\_|   |_____/_/\_\ |_____|_____\____|_____|_| \_|____/|____/ 

; ____________________________________________________ [ Header ] ____________________________________________________

#NoEnv
#Persistent
#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWorkingDir, %A_ScriptDir%

; Imports
#Include, functions.ahk
WorkingDir := A_ScriptDir "\py\"
filePath := "./data/discord.txt"

; Initials Reads
IniRead, huawei_URL, settings.ini, Settings, huawei
IniRead, ea_URL, settings.ini, Settings, ea
IniRead, eaSettings_URL, settings.ini, Settings, easettings
IniRead, count, settings.ini, Settings, counter
IniRead, sandboxTitle, settings.ini, Settings, sandboxtitle
IniRead, firefoxTitle, settings.ini, Settings, firefoxtitle

; Flags / Variables
Clipboard := ""
regtext := ""
resetIp := 1 ; Default 1
credFlag := 0 ; Default 0
searchFlag := 1 ; Default 1

; ____________________________________________________ [ Main ] ____________________________________________________

WindowRun("firefox", huawei_URL)

Loop {
  avl := SearchFunc()

  If (avl.isData.found && resetIp) {
    ClickFunc(avl.isData.x, avl.isData.y, , 1)
  } Else If (avl.isLogin.found) {
    ClickFunc(avl.isLogin.x + 5, avl.isLogin.y + 5, , 1)
  } Else If (avl.isData_Off.found) {
    ClickFunc(avl.isData_Off.x, avl.isData_Off.y)
    resetIp := 0
    credFlag := 1
    WindowRun("WindowsSandbox")
  }

  If (credFlag) {
    RunWait, py "%WorkingDir%ip.py", %WorkingDir%
    Sleep, 500
    RunWait, py "%WorkingDir%createMail.py", %WorkingDir%
    Sleep, 500

    IniRead, IP, settings.ini, Settings, ip
    IniRead, EMAIL, settings.ini, Settings, email
    IniRead, PASSWORD, settings.ini, Settings, password

    If (IP && EMAIL && PASSWORD) {
      IpAddress := IP
      EmailAddress := EMAIL
      EmailPassword := PASSWORD
      credFlag := 0
    } Else {
      MsgBox, 0, , Error Occured!, 5
    }
  }

  If (avl.isSearch.found && searchFlag) {
    ClickFunc(avl.isSearch.x, avl.isSearch.y, , 1)
    KeysFunc(ea_URL, , , 2000)
    KeysFunc("enter")
    searchFlag := 0
  }

  If (avl.isDob.found) {
    KeysFunc("tab", , 8, 250)
    KeysFunc("down")
    KeysFunc("tab")
    KeysFunc("down")
    KeysFunc("tab")
    KeysFunc("down", , 25, 100)
    KeysFunc("tab")
    KeysFunc("enter", , , 2000)
  }

  If (avl.isCred.found) {
    KeysFunc("tab", , 2, 300)
    Send, %EmailAddress%
    KeysFunc("tab")
    EA := EAFunc()
    eaid := EA.eaid
    eapass := EA.eapass
    Send, %eaid%
    KeysFunc("tab")
    Send, %eapass%
    KeysFunc("tab", , 2, 300)
    KeysFunc("enter", , , 2000)
  }

  If (avl.isAgree.found) {
    ClickFunc(avl.isAgree.x, avl.isAgree.y)
    KeysFunc("tab", , 3, 300)
    KeysFunc("enter", , , 2000)
  }

  If (avl.isCode.found) {
    RunWait, py "%WorkingDir%code.py", %WorkingDir%
    Sleep, 500

    IniRead, CODE, settings.ini, Settings, code

    If (CODE) {
      Send, %CODE%
      KeysFunc("enter")
    } Else {
      MsgBox, Error Code Not Found
    }
  }

  ; If (avl.isFinish.found) {
  ;   KeysFunc()
  ;   KeysFunc("enter")
  ; }

  MsgBox, Ip: %IpAddress%, Email: %Email%, Password: %Password%
  MsgBox, 0, , Loop End Rerunning, 3

  Sleep, 400
}

; ____________________________________________________ [ Bottom ] ____________________________________________________

F2::
ExitApp