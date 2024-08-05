; Libraries
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
CoordMode, Pixel, Screen

; Variables
version := "v1.0.1"

; Settings
If !FileExist("settings.ini") {
  MsgBox, 4, Warning!, Couldn't find settings.ini. Do you want to create settings.ini file?, 15
  ifMsgBox Yes
  {
    IniWrite, 0, settings.ini, type, RGB
    IniWrite, 0, settings.ini, type, AutoClose
    IniWrite, 0, settings.ini, details, XT
    IniWrite, 0, settings.ini, details, YL
    IniWrite, 0, settings.ini, details, XB
    IniWrite, 0, settings.ini, details, YR
    IniWrite, FFFFFF, settings.ini, details, Color
    IniWrite, 0, settings.ini, details, Variation
  }
  Else
  {
    ExitApp
  }
} Else {
  IniRead, RGB, settings.ini, type, RGB
  IniRead, AutoCloseScript, settings.ini, type, AutoClose
  IniRead, CoordXT, settings.ini, details, XT
  IniRead, CoordYL, settings.ini, details, YL
  IniRead, CoordXB, settings.ini, details, XB
  IniRead, CoordYR, settings.ini, details, YR
  IniRead, GivenColor, settings.ini, details, Color
  IniRead, ColorVariation, settings.ini, details, Variation
}

Gui Add, Text, x-48 y112 w218 h2 +0x10
Gui Add, Text, x8 y0 w60 h23 +0x200, SelectType
Gui Add, Button, gPixelSearch x0 y64 w120 h40, &SearchPixel
Gui Add, Button, gColorSearch x0 y24 w120 h40, &SearchColor
Gui Add, Text, x85 y115 w120 h16 +0x200, %version%

Gui Show, w120 h130, %version%
Return

; Pixel Color Search On Specific Coordinates
PixelSearch:
  Gui 2: Font,, Trebuchet MS
  Gui 2: Add, Text, x8 y8 w120 h23 +0x200, Coord X-Top:
  Gui 2: Add, Text, x8 y32 w120 h23 +0x200, Coord Y-Left:
  Gui 2: Add, Text, x8 y56 w120 h23 +0x200, Coord X-Bottom:
  Gui 2: Add, Text, x8 y80 w120 h23 +0x200, Coord Y-Right:
  Gui 2: Add, Text, x29 y112 w198 h2 +0x10
  Gui 2: Add, Text, x8 y144 w120 h23 +0x200, Variation:
  Gui 2: Font
  Gui 2: Font,, FixedSys
  Gui 2: Add, Button, gSearchPixel x28 y176 w198 h35, &SearchPixel
  Gui 2: Font
  Gui 2: Font,, Trebuchet MS
  Gui 2: Add, Text, x29 y221 w198 h2 +0x10
  Gui 2: Add, Link, x192 y224 w55 h17, <a href="https://discord.com/users/521582566642417684">Larry2018</a>
  Gui 2: Add, Text, x2 y228 w35 h15 +0x200, %version%
  Gui 2: Add, Edit, x128 y8 w104 h23, 1
  Gui 2: Add, UpDown, vGetXT Range0-5000 x230 y8 w18 h23, %CoordXT%
  Gui 2: Add, Edit, x128 y32 w104 h23, 1
  Gui 2: Add, UpDown, vGetYL Range0-5000 x230 y32 w18 h23, %CoordYL%
  Gui 2: Add, Edit, x128 y56 w104 h23, 1
  Gui 2: Add, UpDown, vGetXB Range0-5000 x230 y56 w18 h23, %CoordXB%
  Gui 2: Add, Edit, x128 y80 w104 h23, 1
  Gui 2: Add, UpDown, vGetYR Range0-5000 x230 y80 w18 h23, %CoordYR%
  Gui 2: Add, Text, x8 y120 w60 h23 +0x200, Color-RGB
  Gui 2: Add, Text, x112 y125 w14 h14 +0x200, 0x
  Gui 2: Add, Edit, vGetColor x128 y120 w104 h23, %GivenColor%
  Gui 2: Add, Edit, x128 y144 w104 h23, 1
  Gui 2: Add, UpDown, vGetVariation Range0-255 x230 y144 w18 h23, %ColorVariation%

  Gui 2: Show, w246 h243, RfrDebugger - %version%
Return

SearchPixel:
  Gui, Submit, NoHide

  ; Save Settings
  IniWrite, %GetXT%, settings.ini, details, XT
  IniWrite, %GetYL%, settings.ini, details, YL
  IniWrite, %GetXB%, settings.ini, details, XB
  IniWrite, %GetYR%, settings.ini, details, YR
  IniWrite, %GetColor%, settings.ini, details, Color
  IniWrite, %GetVariation%, settings.ini, details, Variation

  If GetCheckValue
    MsgBox, X-TOP: %GetXT%, Y-LEFT: %GetYL%, X-BOTTOM: %GetXB%, Y-RIGHT: %GetYR%`nColor: 0x%GetColor%, Variation: %GetVariation%

  PixelSearch, OutputX, OutputY, GetXT, GetYL, GetXB, GetYR, 0x%GetColor%, GetVariation, Fast RGB
  If ErrorLevel = 0
    MsgBox, 0, Info, GivenColor: 0x%GetColor%`nFound At - CoordX: %OutputX%, CoordY: %OutputY%
  Else
    MsgBox, 0, Info, Color: 0x%GetColor% Not Found - Try Again!

Return

; Pixel Search On By Given Color
ColorSearch:
  Gui 3: Add, Text, x8 y24 w120 h23 +0x200, Enter "Y" Coordinate:
  Gui 3: Add, Text, x8 y0 w120 h23 +0x200, Enter "X" Coordinate:
  Gui 3: Add, Edit, vXCoord x129 y2 w120 h21
  Gui 3: Add, Edit, vYCoord x129 y27 w120 h21
  Gui 3: Add, Text, x-1 y56 w265 h2 +0x10
  Gui 3: Add, Text, x224 y112 w120 h18 +0x200, %version%
  Gui 3: Add, Button, gSearchColor x7 y90 w242 h23, &Search
  If (RGB)
    Gui 3: Add, CheckBox, vRGBColor x8 y64 w120 h23 Checked, RGB Color
  Else {
    Gui 3: Add, CheckBox, vRGBColor x8 y64 w120 h23, RGB Color
  }
  If (AutoCloseScript) {
    Gui 3: Add, CheckBox, vAutoClose x130 y64 w120 h23 Checked, Auto Close
  } Else {
    Gui 3: Add, CheckBox, vAutoClose x130 y64 w120 h23, Auto Close
  }

  Gui 3: Show, w258 h130, Rfr - Debugger %version%
Return

SearchColor:
  Gui, Submit, NoHide
  If (RGBColor) {
    PixelGetColor, color, %XCoord%, %YCoord%, Fast RGB
    IniWrite, 1, settings.ini, type, RGB
  } Else {
    IniWrite, 0, settings.ini, type, RGB
    PixelGetColor, color, %XCoord%, %YCoord%
  }
  Sleep, 3000
  MsgBox, 0, Debugger %version%, The color at (%XCoord%, %YCoord%) is %color%.

  If (AutoClose) {
    IniWrite, 1, settings.ini, type, AutoClose
    ExitApp
  } Else {
    IniWrite, 0, settings.ini, type, AutoClose
  }
Return

; GUI Close
GuiEscape:
GuiClose:
ExitApp