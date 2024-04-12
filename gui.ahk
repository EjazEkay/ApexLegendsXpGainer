#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Add, Edit, x72 y8 w120 h21
Gui Add, Edit, x72 y35 w120 h21
Gui Add, Button, x16 y102 w176 h45, &Guest
Gui Add, Text, x16 y8 w56 h23 +0x200, Username
Gui Add, Text, x16 y35 w56 h23 +0x200, Password
Gui Add, Text, x16 y94 w178 h2 +0x10
Gui Add, Button, x16 y65 w177 h23, &Login
Gui Add, Link, x144 y154 w49 h17, <a href="https://discordapp.com/users/521582566642417684">Larry2018</a>
Gui Add, Button, x16 y149 w120 h21, &Update Webhook

Gui Show, w207 h174, Rfr Bot
Return

ButtonLogin:
    MsgBox, Under Development!
Return

ButtonGuest:
    Run, main.ahk
    ExitApp
Return

ButtonUpdateWebhook:
    Run, settings.ini
    ExitApp
Return

GuiEscape:
GuiClose:
    ExitApp
