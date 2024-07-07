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
#Include, coordColors.ahk
#Include, functions.ahk
CoordMode, Pixel, Screen
SetWorkingDir, %A_ScriptDir%

If !FileExist("settings.ahk") {
  ExitApp
} Else If (DebugMode < 0 || DebugMode > 1) {
  MsgBox, 0, Error, Code Error %DebugMode%, 2
  ExitApp
}

; ____________________________________________________ [ Main ] ____________________________________________________

Loop {
  ; Delay
  Sleep, 1500

  ; Image Serach
  RunWait, py "%WorkingDir%apex.py", %WorkingDir%, hide

  ini := IniReadFunc()

  ; Main Menu Block
  If (ini.ismain) {
    KeysFunc("space")
  }

  If (ini.iserror) {
    KeysFunc("esc")
  }

  If (ini.isesc || ini.isesc2) {
    KeysFunc("esc")
  }

  If (ini.isready) {
    Vready := ExtractValue(ini.isready)
    ClickFunc(Vready.x, Vready.y, 5)
  }

  If (ini.istype) {
    Vtype := ExtractValue(ini.istype)
    ClickFunc(Vtype.x, Vtype.y)
  }

  Sleep, 400
}

; ____________________________________________________ [ Bottom ] ____________________________________________________

F2::
ExitApp