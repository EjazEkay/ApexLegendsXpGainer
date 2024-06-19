#NoEnv
#SingleInstance force
#MaxThreadsBuffer on
SendMode Input
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows On
SetTitleMatchMode RegEx

; ######################################################### Main #########################################################
Gosub, IniRead
global script_version := "v2.0.0"
global UUID := "2ff4f336fa8848048ef6fb896cfd8183"

; --- Graphic User Interface ---
Gui Add, Text, x8 y8 w30 h21 +0x200, Type:
If (GType == "Duos") {
    Gui Add, DropDownList, x40 y8 w120 vgtype, MixTape||Trios||Duos||
} Else If (GType == "Trios") {
    Gui Add, DropDownList, x40 y8 w120 vgtype, MixTape||Duos||Trios||
} Else {
    Gui Add, DropDownList, x40 y8 w120 vgtype, Duos||Trios||MixTape||
}

Gui Add, Text, x8 y32 w30 h21 +0x200, Hours:
If (Lvl == "96") {
    Gui Add, DropDownList, x40 y32 w120 vlvl, 96||16
} Else {
    Gui Add, DropDownList, x40 y32 w120 vlvl, 16||96
}

Gui Add, Text, x8 y56 w30 h21 +0x200, Match:
If (APacks == "Opened") {
    Gui Add, DropDownList, x40 y56 w120 vapacks, Requeue||Undefine
} Else {
    Gui Add, DropDownList, x40 y56 w120 vapacks, Requeue||Undefine
}

Gui Add, Text, x8 y80 w30 h21 +0x200, Legnd:
If (ALegends == "Gibi") {
    Gui Add, DropDownList, x40 y80 w120 valegends, Gibi||Wraith
} Else {
    Gui Add, DropDownList, x40 y80 w120 valegends, Wraith||Gibi
}

If (AMovement == "1") {
    Gui Add, CheckBox, x8 y104 w70 h23 Checked vamovement, Movement
} Else {
    Gui Add, CheckBox, x8 y104 w70 h23 vamovement, Movement
}

If (RAttack == "1") {
    Gui Add, CheckBox, x80 y104 w82 h23 Disabled vrattack, Auto Shoot
} Else {
    Gui Add, CheckBox, x80 y104 w82 h23 Disabled vrattack, Auto Shoot
}

Gui Add, Text, x8 y136 w155 h3 +0x10
Gui Add, Text, x8 y144 w152 h23 +0x200, Discord Updation!

If (MLUpdate == "1") {
    Gui Add, CheckBox, x8 y168 w152 h23 checked vmlupdate, MaxLevel Updation
} Else {
    Gui Add, CheckBox, x8 y168 w152 h23 vmlupdate, MaxLevel Updation
}

If (TOUpdate == "1") {
    Gui Add, CheckBox, x8 y192 w152 h23 checked vtoupdate, TimeOut Updation
} Else {
    Gui Add, CheckBox, x8 y192 w152 h23 vtoupdate, TimeOut Updation
}

Gui Add, Text, x8 y216 w152 h23 +0x200, Discord Webhook for updation
Gui Add, Button, x88 y240 w72 h34, Timeout Webhook
Gui Add, Button, x8 y240 w73 h34, Maxlevel Webhook
Gui Add, Link, x120 y326 w49 h15, <a href="https://discordapp.com/users/521582566642417684">Larry2018</a>
Gui Add, Text, x2 y311 w32 h12 +0x200, V2.0.0
Gui Add, Button, x8 y277 w152 h29, &Run
Gui Add, Button, x36 y308 w124 h17, &UUID

Gui Show, w170 h342, RFR-Larry2018
Return

; --- Settings.ini ---
IniRead:
    IfNotExist, settings.ini
    {
        MsgBox, Couldn't find settings.ini. Click Ok to Create!

        IniWrite, "Mixtape", settings.ini, GameType, Type
        IniWrite, "20", settings.ini, AccLevel, Level
        IniWrite, "Unopened", settings.ini, AccPacks, Packs
        IniWrite, "Wraith", settings.ini, AccLegends, Legends
        IniWrite, "True", settings.ini, AccMovement, Movement
        IniWrite, "False", settings.ini, AccMovement, ResponseAttack
        IniWrite, "False", settings.ini, AccUpdation, MaxLevelUpdate
        IniWrite, "False", settings.ini, AccUpdation, TimeOutUpdate
        IniWrite, "", settings.ini, Webhook, MLU
        IniWrite, "", settings.ini, Webhook, TOU
        IniWrite, "", settings.ini, UUID, UUID

        if (A_ScriptName == "gui.ahk") {
            Run "gui.ahk"
        } else if (A_ScriptName == "gui.exe") {
            Run "gui.exe"
        }
    }
    Else {
        IniRead, GType, settings.ini, GameType, Type
        IniRead, Lvl, settings.ini, AccLevel, Level
        IniRead, APacks, settings.ini, AccPacks, Packs
        IniRead, ALegends, settings.ini, AccLegends, Legends
        IniRead, AMovement, settings.ini, AccMovement, Movement
        IniRead, RAttack, settings.ini, AccMovement, ResponseAttack
        IniRead, MLUpdate, settings.ini, AccUpdation, MaxLevelUpdate
        IniRead, TOUpdate, settings.ini, AccUpdation, TimeOutUpdate
        IniRead, UserId, settings.ini, UUID, UUID
    }
return

; --- Button Run ---
ButtonRun:
    Gui, submit
        IniWrite, "%gtype%", settings.ini, GameType, Type
        IniWrite, "%lvl%", settings.ini, AccLevel, Level
        IniWrite, "%apacks%", settings.ini, AccPacks, Packs
        IniWrite, "%alegends%", settings.ini, AccLegends, Legends
        IniWrite, "%amovement%", settings.ini, AccMovement, Movement
        IniWrite, "%rattack%", settings.ini, AccMovement, ResponseAttack
        IniWrite, "%mlupdate%", settings.ini, AccUpdation, MaxLevelUpdate
        IniWrite, "%toupdate%", settings.ini, AccUpdation, TimeOutUpdate

    if (A_ScriptName == "gui.ahk") {
        CloseScript("rfr.ahk")
        Run "rfr.ahk"
    } else if (A_ScriptName == "gui.exe") {
        CloseScript("rfr.exe")
        Run "rfr.exe"
    }
ExitApp

ButtonTimeoutWebhook:
    InputBox, TimeoutWebhookInput, Timeout Webhook URL, Enter the Timeout Webhook URL: `nCurrent Webhook:
    if ErrorLevel
        return

    IniWrite, "%TimeoutWebhookInput%", settings.ini, Webhook, TOU
    ExitApp
return

ButtonMaxlevelWebhook:
    InputBox, MaxlevelWebhookInput, Maxlevel Webhook URL, Enter the Maxlevel Webhook URL: `nCurrent Webhook:
    if ErrorLevel
        return

    IniWrite, "%MaxlevelWebhookInput%", settings.ini, Webhook, MLU
    ExitApp
return

ButtonUUID:
    InputBox, UUIDInput, User Unique Identity Key, Enter Your 24 Digits UUID - ABC12345678904123123123 `nMy UUID: %UserId%
    if ErrorLevel
        return

    IniWrite, "%UUIDInput%", settings.ini, UUID, UUID
    ExitApp
return


; ######################################################### Bottom #########################################################
CloseScript(Name) {
    DetectHiddenWindows On
    SetTitleMatchMode RegEx
    IfWinExist, i)%Name%.* ahk_class AutoHotkey
    {
        WinClose
        WinWaitClose, i)%Name%.* ahk_class AutoHotkey, , 2
        If ErrorLevel
            return "Unable to close " . Name
        else
            return "Closed " . Name
    }
    else
        return Name . " not found"
}

GuiClose:
ExitApp
