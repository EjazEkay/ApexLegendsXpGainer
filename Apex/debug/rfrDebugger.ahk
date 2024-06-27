; Libraries
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
CoordMode, Pixel, Screen

; Variables
version := "v1.0.0"

; Settings
If !FileExist("settings.ini") {
  MsgBox, 4, Warning!, Couldn't find settings.ini. Do you want to create settings.ini file?, 15
  ifMsgBox Yes
  {
    IniWrite, 0, settings.ini, type, RGB
    IniWrite, 0, settings.ini, type, AutoClose
  }
  Else
  {
    ExitApp
  }
} Else {
  IniRead, RGB, settings.ini, type, RGB
  IniRead, AutoCloseScript, settings.ini, type, AutoClose
}

; Graphic User Interface
Gui Add, Text, x8 y24 w120 h23 +0x200, Enter "Y" Coordinate:
Gui Add, Text, x8 y0 w120 h23 +0x200, Enter "X" Coordinate:
Gui Add, Edit, vXCoord x129 y2 w120 h21
Gui Add, Edit, vYCoord x129 y27 w120 h21
Gui Add, Text, x-1 y56 w265 h2 +0x10
Gui Add, Text, x224 y112 w120 h18 +0x200, %version%
Gui Add, Button, gSearchColor x7 y90 w242 h23, &Search
If (RGB)
  Gui Add, CheckBox, vRGBColor x8 y64 w120 h23 Checked, RGB Color
Else {
  Gui Add, CheckBox, vRGBColor x8 y64 w120 h23, RGB Color
}
If (AutoCloseScript) {
  Gui Add, CheckBox, vAutoClose x130 y64 w120 h23 Checked, Auto Close
} Else {
  Gui Add, CheckBox, vAutoClose x130 y64 w120 h23, Auto Close
}

Gui Show, w258 h130, Rfr - Debugger %version%
Return

; Pixel Search On Specific Coordinates
SearchColor:
  Gui, Submit, NoHide
  If (RGBColor) {
    PixelGetColor, color, %XCoord%, %YCoord%, Fast RGB
    IniWrite, 1, settings.ini, type, RGB
  } Else {
    PixelGetColor, color, %XCoord%, %YCoord%
  }
  MsgBox, 0, Debugger %version%, The color at (%XCoord%, %YCoord%) is %color%.

  if (AutoClose) {
    IniWrite, 1, settings.ini, type, AutoClose
    ExitApp
  }
Return

; GUI Close
GuiEscape:
GuiClose:
ExitApp
