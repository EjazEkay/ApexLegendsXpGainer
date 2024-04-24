#NoEnv
#SingleInstance force
#MaxThreadsBuffer on
SendMode Input
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
SetTitleMatchMode RegEx

RunAsAdmin()

global UUID := "f0e345643a044908a260d7c04443655f"

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

ActiveMonitorInfo(ByRef X, ByRef Y, ByRef Width, ByRef Height)
{
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    SysGet, monCount, MonitorCount
    Loop %monCount% {
        SysGet, curMon, Monitor, %a_index%
        if ( mouseX >= curMonLeft and mouseX <= curMonRight and mouseY >= curMonTop and mouseY <= curMonBottom ) {
            X := curMonTop
            y := curMonLeft
            Height := curMonBottom - curMonTop
            Width := curMonRight - curMonLeft
            return
        }
    }
}

RunAsAdmin()
{
    Global 0
IfEqual, A_IsAdmin, 1, Return 0

Loop, %0%
    params .= A_Space . %A_Index%

DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
ExitApp
}

GuiClose:
ExitApp
