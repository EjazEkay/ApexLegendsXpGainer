; Image Search Function
ImageSearchFunc(image, ByRef x, ByRef y, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
  ImageSearch, x, y, startX, startY, endX, endY, *variation %image%
  Return !ErrorLevel
}
; Pixel Search Function
PixelSearchFunc(color, ByRef x, ByRef y, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
  PixelSearch, x, y, startX, startY, endX, endY, %color%, variation, Fast RGB
  Return !ErrorLevel
}
; Click Perform Function
ClickFunc(coordX, coordY, oldposition := 0, speed := 20, delay := 1000) {
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
KeysFunc(key, combination := "", repeat := 1, delay := 1000) {
  Loop, %repeat% {
    SendInput, %combination%{%key%}
    Sleep, delay
  }
}

; ____________________________________________________ Functions Seperator ____________________________________________________

; Run App Function
Runfunc(path) {
  Run, %path%
  Sleep, 1000
}

; Close App Function
Closefunc(title) {
  IfWinExist, %title%
  {
    WinClose
  }
  else
  {
    MsgBox, 0, Window Error, The window with title "%title%" was not found., 5
  }
}

; Activate App Function
Activatefunc(title) {
  IfWinExist, %title%
  {
    WinActivate, , %title%
  }
  else
  {
    MsgBox, 0, Window Error, The window with title "%title%" was not found, 3
  }
}
; ____________________________________________________ Functions Seperator ____________________________________________________

; EA App Function
EaAppFunc(Path, Email, Password, WinEA) {
  ; Run Game
  Runfunc(Path)

  Loop, 60 {
    Activatefunc(WinEA)
    isLogin := ImageSearchFunc(Login, LoginX, LoginY)

    If (isLogin) {
      KeysFunc("Tab", , 7, 100)
      Send, %Email%
      KeysFunc("Tab", , , 100)
      Send, %Password%
      KeysFunc("Tab", , 2, 100)
      KeysFunc("Space")
      KeysFunc("Tab", , 4, 100)
      KeysFunc("Enter")
    }
    Sleep, 1000
  }
  Return 0
}

; MainMenu Function
MainMenu() {
  isMain := ImageSearchFunc(Main, MainX, MainY, , , , , 32)
  MsgBox, %isMain%
  If isMain
    Return { isMain: isMain }

  isInfo := PixelSearchFunc(InfoC, InfoX, InfoY, InfoXT, InfoYL, InfoXB, InfoYR, 2)
  If isInfo
    Return { isInfo: isInfo }

  isReady := ImageSearchFunc(Ready, ReadyX, ReadyY, , , , , 32)
  If isReady
    Return { isReady: isReady, ReadyX: ReadyX, ReadyY: ReadyY }

  isAlive := PixelSearchFunc(AliveC, AliveX, AliveY, AliveXT, AliveYL, AliveXB, AliveYR, 2)
  If isAlive
    Return { isAlive: isAlive }
}