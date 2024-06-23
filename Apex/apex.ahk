#NoEnv
#Persistent
#SingleInstance, Force
#Include, settings.ahk
#Include, coordColors.ahk
#Include, functions.ahk
CoordMode, Pixel, Screen

Loop, {
  ; Window Swapping
  CurrentScreen := WinSwapFunc(CurrentScreen, TotalScreens)

  ; Pixel Search Functions
  Mainmenu := MainMenuFunc()
  Lobby := LobbyFunc()
  InGame := InGameFunc()

  ; Main Menu Block
  If (Mainmenu.isMcontinue) {
    KeysFunc("space")
  } Else If (Mainmenu.isMCinfo) {
    KeysFunc("esc")
  }

  ; Lobby Handling
  If (Lobby.isLesc && !Mainmenu.isMcontinue && !InGame.isIalive) {
    KeysFunc("esc")
  } Else If ((Lobby.isLready && Lobby.isLmode && !GameMode) || (Lobby.isLready && !Lobby.isLmode && GameMode)) {
    ClickFunc(Lobby.readyX, Lobby.readyY, 1, , 1000)
  } Else If ((Lobby.isLready && !Lobby.isLmode && !GameMode) || (Lobby.isLready && !Lobby.isLmode && GameMode)) {
    ClickFunc(200, 800, 0)
    If (!GameMode) {
      ClickFunc(1000, 500, 0)
    } Else If (GameMode) {
      ClickFunc(200, 500, 0)
    }
    ClickFunc(Lobby.readyX, Lobby.readyY, 1, , 1000)
  } Else If (Lobby.isLcontinue) {
    Sleep, 2500
    KeysFunc("space")
    KeysFunc("space")
    KeysFunc("space")
  }

  ; In Game Block
  If (InGame.isIalive) {
    KeysFunc("w down", , 2000)
    KeysFunc("w up")
  } Else If (InGame.isIreque) {
    KeysFunc("1")
  } Else If (InGame.isIgibi) {
    ClickFunc(InGame.gibiX, InGame.gibiY, 1, 60, 7500)
  } Else If (InGame.isIpathfinder) {
    ClickFunc(InGame.pathyX, InGame.pathyY, 1, 60, 7500)
  } Else If (InGame.isIwraith) {
    ClickFunc(InGame.wraithX, InGame.wraithY, 1, 60, 7500)
  }

  ; Delay
  Sleep, 1500
}

F2::
ExitApp