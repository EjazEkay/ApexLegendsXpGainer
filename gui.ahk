#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

if !FileExist("settings.ini") {
    MsgBox, 4, Warning!, Couldn't find settings.ini. Do you want to create settings.ini file?, 15
    ifMsgBox Yes
    {
        IniWrite, "Trios", settings.ini, gametype, type
        IniWrite, "1920x1080", settings.ini, screen settings, resolution
        IniWrite, "https://discord.com/api/webhooks/1228261672272138280/yjqe5kj-vSLCFuDYGbzKRDxIJMarmrYHM7otEKR6bLObi-XqB7SHoZphITgcQv7G2z9x", settings.ini, webhook, URL
    }
    else
    {
        ExitApp
    }

} else {
    IniRead, type, settings.ini, gametype, type
}

if (type == "MixTape") {
    Gui Add, Radio, x80 y1 w63 h23 vMixTape Checked, MixTape
} else {
    Gui Add, Radio, x80 y1 w63 h23 vMixTape, MixTape
}
if (type == "Trios") {
    Gui Add, Radio, x150 y1 w62 h23 vTrios Checked, Trios
} else {
    Gui Add, Radio, x150 y1 w62 h23 vTrios, Trios
}
Gui Add, Button, x16 y26 w176 h25 gButtonRun, &Run
Gui Add, Text, x18 y55 w175 h2 +0x10
Gui Add, Text, x17 y0 w58 h23 +0x200, Game Type:
Gui Add, Link, x144 y65 w49 h17, <a href="https://discordapp.com/users/521582566642417684">Larry2018</a>
Gui Add, Button, x16 y60 w120 h21 gButtonUpdateWebhook, &Update Webhook

Gui Show, w207 h85, Rfr Bot
Return

ButtonRun:
    Gui, Submit, NoHide
    if Trios
        IniWrite, Trios, settings.ini, gametype, type
    else if MixTape
        IniWrite, MixTape, settings.ini, gametype, type
    Run, main.ahk
ExitApp
Return

ButtonUpdateWebhook:
    Run, settings.ini
ExitApp
Return

GuiClose:
ExitApp
