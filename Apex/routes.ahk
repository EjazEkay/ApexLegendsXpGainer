; Configuration
#Include, config.ahk

; Images
; Main Menu
global Loading_Screen := "screenshots/loading-screen.png"
; Lobby
global Ready_Button := "screenshots/ready-button.png"
global Match_Type := "screenshots/match-type.png"
global Esc_Key := "screenshots/esc-key.png"
global Space_Summary := "screenshots/space-summary.png"
; Respawn
global Cell := "screenshots/cell.png"
global Reque := "screenshots/reque.png"

; Functions
#Include, functions/base.ahk
#Include, functions/mainmenu.ahk
#Include, functions/lobby.ahk
#Include, functions/respawn.ahk