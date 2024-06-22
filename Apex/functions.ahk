; ------------------------ Base Functions ------------------------
; Pixel Search Function
PixelSearchFunc(color, ByRef x, ByRef y, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
  PixelSearch, x, y, startX, startY, endX, endY, %color%, variation, Fast RGB
  Return !ErrorLevel
}

; Click Perform Function
ClickFunc(coordX, coordY, oldposition := 0, speed := 20, delay := 1500) {
  If oldposition {
    MouseGetPos, startX, startY
    MouseMove, coordX, coordY, speed
    Click
    Sleep, delay
    MouseMove, startX, startY, speed
    Sleep, delay
  } Else {
    MouseMove, coordX, coordY, speed
    Click
    Sleep, delay
  }
}

; Keyboard Shortcut Key Function - ^ for Ctrl | ! for Alt | + for Shift | # for Win (Windows key)
KeysFunc(key, combination := "", delay := 1500) {
  SendInput, %combination%{%key%}
  Sleep, delay
}

; Window Swapping Function
WinSwapFunc(CurrentScreen, TotalScreens) {
  If (TotalScreens > 1) {
    WindowTitle := "192.168.0." . CurrentScreen . " - Remote Desktop Connection" ; Title : Ip[Counter] - Remote Desktop Connection

    If WinExist(WindowTitle) {
      WinActivate
    } Else {
      MsgBox, 1, Error: Screen not found, The window "%windowTitle%" was not found., 5
    }

    If (CurrentScreen < TotalScreens) {
      Return CurrentScreen + 1
    } 
    Return 1
  }
  Return 1
}

; ------------------------ Pixel Search Functions ------------------------
; MainMenu
MainMenuFunc() {
  isMcontinue := PixelSearchFunc(McontinueC, McontinueX, McontinueY, McontinueXT, McontinueYL, McontinueXB, McontinueYR, 0)

  If isMcontinue
    Return { isMcontinue: isMcontinue }

  isMCinfo := PixelSearchFunc(MCinfoC, MCinfoX, MCinfoY, MCinfoXT, MCinfoYL, MCinfoXB, MCinfoYR, 0)
  Return { isMcontinue: isMcontinue, isMCinfo: isMCinfo }
}

; Lobby
LobbyFunc() {
  isLesc := PixelSearchFunc(LescC, LescX, LescY, LescXT, LescYL, LescXB, LescYR, 0)

  If isLesc
    Return { isLesc: isLesc }

  isLready := PixelSearchFunc(LreadyC, LreadyX, LreadyY, LreadyXT, LreadyYL, LreadyXB, LreadyYR, 0)
  isLmode := PixelSearchFunc(LmodeC, LmodeX, LmodeY, LmodeXT, LmodeYL, LmodeXB, LmodeYR, 0)

  If isLready || isLmode
    Return { isLesc: isLesc, isLready: isLready, isLmode: isLmode, readyX: LreadyX, readyY: LreadyY }

  isLcontinue := PixelSearchFunc(LcontinueC, LcontinueX, LcontinueY, LcontinueXT, LcontinueYL, LcontinueXB, LcontinueYR, 0)
  Return { isLesc: isLesc, isLready: isLready, isLmode: isLmode, isLcontinue: isLcontinue }
}

; InGame
InGameFunc() {
  isIalive := PixelSearchFunc(IaliveC, IaliveX, IaliveY, IaliveXT, IaliveYL, IaliveXB, IaliveYR, 0)

  If isIalive
    Return { isIalive: isIalive }

  isIreque := PixelSearchFunc(IrequeC, IrequeX, IrequeY, IrequeXT, IrequeYL, IrequeXB, IrequeYR, 0)
  Return { isIalive: isIalive, isIreque: isIreque }
}