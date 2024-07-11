;      _    ____  _______  __  _     _____ ____ _____ _   _ ____  ____  
;     / \  |  _ \| ____\ \/ / | |   | ____/ ___| ____| \ | |  _ \/ ___| 
;    / _ \ | |_) |  _|  \  /  | |   |  _|| |  _|  _| |  \| | | | \___ \ 
;   / ___ \|  __/| |___ /  \  | |___| |__| |_| | |___| |\  | |_| |___) |
;  /_/   \_\_|   |_____/_/\_\ |_____|_____\____|_____|_| \_|____/|____/ 

; ____________________________________________________ [ Header ] ____________________________________________________

#NoEnv
#Persistent
#SingleInstance, Force
#Include, settings.ahk
#Include, functions.ahk
CoordMode, Pixel, Screen
SetWorkingDir, %A_ScriptDir%

WorkingDir := A_ScriptDir "\py\"

If !FileExist("settings.ahk") {
  ExitApp
} Else If (DebugMode < 0 || DebugMode > 1) {
  MsgBox, 0, Error, Code Error %DebugMode%, 2
  ExitApp
}

; ____________________________________________________ [ Main ] ____________________________________________________

Loop {
  For index, value in maxlevel {
    If (value = CurrentScreen) {
      flagmaxlevel := 1
      Break
    } Else {
      flagmaxlevel := 0
    }
  }

  ; Delay
  Sleep, 1500

  ; Image Serach
  RunWait, py "%WorkingDir%apex.py", %WorkingDir%, hide

  ini := IniReadFunc()

  If (ini.ismaxlevel && flagmaxlevel) {
    CurrentScreen := CurrentScreen + 1
    CurrentScreen := WinSwapFunc(CurrentScreen, TotalScreens, Ip, RemoteName)
  } Else If (ini.ismaxlevel && !flagmaxlevel) {
    MsgBox, 0, Update, MaxLevel Has been reached. PC%CurrentScreen%, 3

    AppendDiscordText(disMessage, filePath)
    RunWait, py "%WorkingDir%discord.py", %WorkingDir%

    maxlevel.Push(CurrentScreen)
  } Else If (!ini.ismaxlevel && flagmaxlevel) {
    maxlevel.RemoveAt(CurrentScreen)
    flagmaxlevel := 0
  }

  If (ini.ismain) {
    KeysFunc("space")
  } Else If (ini.iserror) {
    KeysFunc("esc")
  }

  If (ini.isesc || ini.isesc2) {
    KeysFunc("esc")
  }

  If ((ini.isready && ini.istype && !GameMode) || (ini.isready && !ini.istype && GameMode)) {
    Vready := ExtractValue(ini.isready)
    ClickFunc(Vready.x, Vready.y, 1)
  } Else If ((ini.isready && !ini.istype && !GameMode) || (ini.isready && ini.istype && GameMode)) {
    ClickFunc(Vready.x, Vready.y - 100, 1)
    If (!GameMode) {
      ClickFunc(Vready.x + 500, Vready.y - 300, 1)
    } Else If (GameMode) {
      ClickFunc(Vready.x, Vready.y - 400, 1)
    }
    ClickFunc(Vready.x, Vready.y, 1)
  }

  If (ini.isalive || ini.isalive2) {
    KeysFunc("w down", , 2000)
    KeysFunc("w up")
  }

  If (ini.isreque) {
    KeysFunc("1")
  }

  If (ini.isship || ini.isship2) {
    Vship := ExtractValue(ini.isship)
    Vship2 := ExtractValue(ini.isship2)
    ClickFunc(Vship.x, Vship.y)
    ClickFunc(Vship2.x, Vship2.y)
  }

  If (ini.iscontinue) {
    KeysFunc("space", , 250, 4)
  }

  If (ini.iswraith || ini.isgibi) {
    Vwraith := ExtractValue(ini.iswraith)
    Vgibi := ExtractValue(ini.isgibi)
    ClickFunc(Vwraith.x, Vwraith.y)
    ClickFunc(Vgibi.x, Vgibi.y)
    Sleep, 5000
  }

  If !(ini.ismaxlevel || flagmaxlevel) {
    CurrentScreen := WinSwapFunc(CurrentScreen, TotalScreens, Ip, RemoteName)
  }

  Sleep, 400
}

; ____________________________________________________ [ Bottom ] ____________________________________________________

F2::
ExitApp