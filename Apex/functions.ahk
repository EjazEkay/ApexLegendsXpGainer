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
WinSwapFunc(CurrentScreen, TotalScreens, Ip, RemoteName) {
  If (TotalScreens > 1) {
    WindowTitle := Ip . CurrentScreen . RemoteName ; Title : Ip[Counter] - Remote Desktop Connection

    If WinExist(WindowTitle) {
      WinActivate
    } Else {
      MsgBox, 0, Error: Screen not found, The window "%windowTitle%" was not found., 5
    }

    If (CurrentScreen < TotalScreens) {
      Return CurrentScreen + 1
    } 
    Return 1
  }
  Return 1
}

; Debug PixelGetColor
DPGCFunc(ByRef Color, X, Y) {
  PixelGetColor, Color, X, Y, Fast RGB
}

; Debugger Function
DebuggerFunc(name, DX, DY, isVar, isVarC, isVarXT, isVarYL, checkSpeed := 4000) {
  DPGCFunc(DC, DX, DY)
  MsgBox, 0, Debugger - Rfr-bot | %name%, Status: [ %isVar% ] - False : 0 | True : 1`n`nGivenColor: %isVarC%, GotColor: %DC%`n`nCoordX: %DX%, CoordY: %DY%`n`nCoordXT: %isVarXT%, CoordYL: %isVarYL%
  Sleep, checkSpeed
}

; ------------------------ Pixel Search Functions ------------------------
; MainMenu
MainMenuFunc(DebugMode, BotSpeed) {
  isMcontinue := PixelSearchFunc(McontinueC, McontinueX, McontinueY, McontinueXT, McontinueYL, McontinueXB, McontinueYR, McontinueV)
  If (!DebugMode) {
    If isMcontinue
      Return { isMcontinue: isMcontinue }
  } Else {
    DebuggerFunc("MainMenu Continue", McontinueX, McontinueY, isMcontinue, McontinueC, McontinueXT, McontinueYL, BotSpeed)
  }

  isMCinfo := PixelSearchFunc(MCinfoC, MCinfoX, MCinfoY, MCinfoXT, MCinfoYL, MCinfoXB, MCinfoYR, MCinfoV)
  If (!DebugMode) {
    Return { isMcontinue: isMcontinue, isMCinfo: isMCinfo }
  } Else {
    DebuggerFunc("MainMenu Error/Info", MCinfoX, MCinfoY, isMCinfo, MCinfoC, MCinfoXT, MCinfoYL, BotSpeed)
  }
}

; Lobby
LobbyFunc(DebugMode, BotSpeed) {
  isLesc := PixelSearchFunc(LescC, LescX, LescY, LescXT, LescYL, LescXB, LescYR, LescV)
  If isLesc && !DebugMode
    Return { isLesc: isLesc }

  ; Debugger
  If DebugMode
    DebuggerFunc("Lobby Escape", LescX, LescY, isLesc, LescC, LescXT, LescYL, BotSpeed)

  isLmaxlevel := 0 ; PixelSearchFunc(LmaxlevelC, LmaxlevelX, LmaxlevelY, LmaxlevelXT, LmaxlevelYL, LmaxlevelXB, LmaxlevelYR, LmaxlevelV)
  If isLmaxlevel && !DebugMode
    Return { isLmaxlevel: isLmaxlevel }

  ; Debugger
  If DebugMode
    DebuggerFunc("Lobby MaxLevel", LmaxlevelX, LmaxlevelY, isLmaxlevel, LmaxlevelC, LmaxlevelXT, LmaxlevelYL, BotSpeed)

  isLready := PixelSearchFunc(LreadyC, LreadyX, LreadyY, LreadyXT, LreadyYL, LreadyXB, LreadyYR, LreadyV)
  isLmode := PixelSearchFunc(LmodeC, LmodeX, LmodeY, LmodeXT, LmodeYL, LmodeXB, LmodeYR, LmodeV)
  If isLready || isLmode && !DebugMode
    Return { isLesc: isLesc, isLready: isLready, isLmode: isLmode, readyX: LreadyX, readyY: LreadyY }

  ; Debugger
  If DebugMode {
    DebuggerFunc("Lobby Ready Button", LreadyX, LreadyY, isLready, LreadyC, LreadyXT, LreadyYL, BotSpeed)
    DebuggerFunc("Lobby Game Mode", LmodeX, LmodeY, isLmode, LmodeC, LmodeXT, LmodeYL, BotSpeed)
  }

  isLcontinue := PixelSearchFunc(LcontinueC, LcontinueX, LcontinueY, LcontinueXT, LcontinueYL, LcontinueXB, LcontinueYR, LcontinueV)

  If (!DebugMode) {
    Return { isLesc: isLesc, isLready: isLready, isLmode: isLmode, isLcontinue: isLcontinue }
  } Else {
    DebuggerFunc("Lobby Skips", LcontinueX, LcontinueY, isLcontinue, LcontinueC, LcontinueXT, LcontinueYL, BotSpeed)
  }
}

; InGame
InGameFunc(DebugMode, BotSpeed) {
  isIalive := PixelSearchFunc(IaliveC, IaliveX, IaliveY, IaliveXT, IaliveYL, IaliveXB, IaliveYR, IaliveV)
  If isIalive && !DebugMode
    Return { isIalive: isIalive }

  ; Debugger 1
  If DebugMode
    DebuggerFunc("Playing - Alive", IaliveX, IaliveY, isIalive, IaliveC, IaliveXT, IaliveYL, BotSpeed)

  isIreque := PixelSearchFunc(IrequeC, IrequeX, IrequeY, IrequeXT, IrequeYL, IrequeXB, IrequeYR, IrequeV)
  If isIreque && !DebugMode
    Return { isIalive: isIalive, isIreque: isIreque }

  ; Debugger 2
  If DebugMode
    DebuggerFunc("Playing - Reque", IrequeX, IrequeY, isIreque, IrequeC, IrequeXT, IrequeYL, BotSpeed)

  isIesc := PixelSearchFunc(IescC, IescX, IescY, IescXT, IescYL, IescXB, IescYR, IescV)
  If isIesc
    Return { isIesc: isIesc }

  isIship := PixelSearchFunc(IshipC, IshipX, IshipY, IshipXT, IshipYL, IshipXB, IshipYR, IshipV)
  If isIship
    Return { isIship: isIship, shipX: IshipX, shipY: IshipY }

  isIgibi := PixelSearchFunc(IgibiC, IgibiX, IgibiY, IgibiXT, IgibiYL, IgibiXB, IgibiYR, IgibiV)
  If isIgibi && !DebugMode
    Return { isIgibi: isIgibi, gibiX: IgibiX, gibiY: IgibiY }

  isIpathfinder := PixelSearchFunc(IpathfinderC, IpathfinderX, IpathfinderY, IpathfinderXT, IpathfinderYL, IpathfinderXB, IpathfinderYR, IpathfinderV)
  If isIpathfinder && !DebugMode
    Return { isIpathfinder: isIpathfinder, pathyX: IpathfinderX, pathyY: IpathfinderY }

  isIwraith := PixelSearchFunc(IwraithC, IwraithX, IwraithY, IwraithXT, IwraithYL, IwraithXB, IwraithYR, IwraithV)
  If isIwraith && !DebugMode
    Return { isIwraith: isIwraith, wraithX: IwraithX, wraithY: IwraithY }
}

; ------------------------ Webhook Functions ------------------------
DiscordUpdation(webhookURL, message) {
  If (webhookURL = "") {
    MsgBox, 0, Error Webhook URL, Webhook Url not found!, 5
    Return
  }

  jsonPayload := "{""content"": """ message """}"

  http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  http.Open("POST", webhookURL, false)
  http.SetRequestHeader("Content-Type", "application/json")

  http.Send(jsonPayload)

  if (http.Status != 204) {
    MsgBox, % "Failed to send message. Status code: " . http.Status . "`nResponse: " . http.ResponseText
  }
}