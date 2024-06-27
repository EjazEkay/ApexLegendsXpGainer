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

Loop, {
  ; Delay
  Sleep, BotSpeed

  ; Window Swapping
  If GameMode
    GameModeText := "Trios"
  Else
    GameModeText := "Mixtape"

  If DebugMode
    MsgBox, , Debugger - Rfr-bot, GameMode: %GameModeText%, Variation: %Variation%`n`nGivenScreens: %TotalScreens%, NextSwap: %CurrentScreen%`n`nWindowTitle: %Ip%%CurrentScreen%%RemoteName%
  CurrentScreen := WinSwapFunc(CurrentScreen, TotalScreens, Ip, RemoteName)

  ; Pixel Search Functions
  Mainmenu := MainMenuFunc(DebugMode, BotSpeed)
  Lobby := LobbyFunc(DebugMode, BotSpeed)
  InGame := InGameFunc(DebugMode, BotSpeed)

  ; Main Menu Block
  If (Mainmenu.isMcontinue) {
    KeysFunc("space")
  } Else If (Mainmenu.isMCinfo) {
    KeysFunc("esc")
  }

  ; Lobby Handling
  If (Lobby.isLesc && !InGame.isIalive) {
    KeysFunc("esc")
  } Else If (Lobby.isLmaxlevel && !Mainmenu.isMcontinue && !InGame.isIalive) {
    If (CurrentScreen > 1) {
      TempCurrentScreen := CurrentScreen - 1
      WindowTitle := Ip . TempCurrentScreen . RemoteName
    } Else {
      WindowTitle := Ip . CurrentScreen . RemoteName
    }

    WinClose, %WindowTitle%

    Try {
      DiscordUpdation(webhookURL, message)
    } Catch e {
      MsgBox, 1, Execution Error, An error occurred: %e%, 7
    }

    If StopBot
      ExitApp

  } Else If ((Lobby.isLready && Lobby.isLmode && !GameMode) || (Lobby.isLready && !Lobby.isLmode && GameMode)) {
    ClickFunc(Lobby.readyX, Lobby.readyY, 0, , 1000)
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
  If DebugMode
    MsgBox, 0, Debugger - Rfr-bot,Current Bot Speed : %BotSpeed%`n`nScript Terminate Key : F2
  Sleep, BotSpeed
}

F2::
ExitApp