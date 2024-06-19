; Routes
#Include, routes.ahk

trios := 0
mixtape := 1
activeMode := mixtape

; Main
Loop, {
  MainMenuFunc()
  LobbyFunc(activeMode)
  RespawnFunc()
}

F2::
ExitApp
