#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; ____________________________________________________ Config.ini ____________________________________________________

IfNotExist, config.ini
{
  IniWrite, 1, config.ini, Results, current_screen
  IniWrite, 1, config.ini, Results, max_screens
}

IniRead, CurrentScreen, config.ini, Results, current_screen
IniRead, MaxScreens, config.ini, Results, max_screens

; ____________________________________________________ Calling Function ____________________________________________________

WinSwapFunc(CurrentScreen, MaxScreens)

; ____________________________________________________ Functions Seperator ____________________________________________________

WinSwapFunc(CurrentScreen, MaxScreens) {
  WindowTitle := "PC" . CurrentScreen . " - Remote Desktop Connection"

  If WinExist(WindowTitle) {
    WinActivate
  } Else {
    MsgBox, 0, Error: Screen not found, The window "%WindowTitle%" was not found., 5
  }

  NextScreen := (CurrentScreen + 1 > MaxScreens) ? 1 : CurrentScreen + 1
  IniWrite, %NextScreen%, config.ini, Results, current_screen

  ExitApp
}