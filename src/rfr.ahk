#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#SingleInstance force
#MaxThreadsBuffer on
#Persistent
Process, Priority, , A
SetBatchLines, -1
ListLines Off
SetWorkingDir %A_ScriptDir%
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
#Include, paths.ahk

; ######################################################### Head #########################################################
RunAsAdmin()
GoSub, IniRead
global UUID := UserId
HideProcess()

; ######################################################### Main #########################################################
Loop {
    ; ### MainMenu Block ###
    MainMenuFunction()

    ; ### Lobby Block ###
    LobbyFunction()

    ; ### GameType Block ###
    If (GType == "Trios") {
        TriosFunction()
    } Else If (GType == "Duos") {
        DuosFunction()
    } Else If (GType == "MixTape") {
        MixTapeFunction()
    } Else {
        MsgBox, GameType Error, Please Restart Script!
        IfExist, settings.ini 
        {
            IniWrite, "MixTape", settings.ini, GameType, Type
        }
        Goto, ExitSub
    }

    ; ### InGame Block ###
    IngameFunction()

    ; ### Other's Block ###
    OtherFunction()
    LegendFunction()
}

; --- Image Search Function ---
ImageSearchFunction(image, ByRef x, ByRef y, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
    ImageSearch, x, y, %startX%, %startY%, %endX%, %endY%, *%variation% %image%
    Return !ErrorLevel
}

ClickFunction(coordX, coordY, oldposition := 0, delay := 2500) {
    If oldposition {
        MouseGetPos, startX, startY
        Click, %coordX%, %coordY%
        Sleep, %delay%
        MouseMove, startX, startY, 0
    } Else {
        Click, %coordX%, %coordY%
        Sleep, %delay%
    }
}

KeysFunction(key, combination := "",delay := 1500) {
    SendInput, %combination%{%key%}
    Sleep, %delay%
}

MainMenuFunction() {
    isMainMenu := ImageSearchFunction(Mainmenu, MainmenuX, MainmenuY, 800, 590, 1110, 700, 65)
    isRetry := ImageSearchFunction(Mainmenu_Retry, Mainmenu_RetryX, Mainmenu_RetryY, 800, 590, 1110, 700, 90)
    isError_Info_Continue := ImageSearchFunction(Error_Info_Continue, Error_Info_ContinueX, Error_Info_ContinueY, 750, 600, 1130, 850)

    If (isMainMenu || isRetry)
        KeysFunction("space", , 7500)

    If isError_Info_Continue
        ClickFunction(Error_Info_ContinueX, Error_Info_ContinueY)
}

LobbyFunction() {
    isNews := ImageSearchFunction(News, NewsX, NewsY, 750, 0, 960, 85, 5)
    isContinue_A := ImageSearchFunction(Continue_A, Continue_AX, Continue_AY, 760, 950, 1155, 1030, 10)
    isContinue_B := ImageSearchFunction(Continue_B, Continue_BX, Continue_BY, 760, 950, 1155, 1030, 20)
    isPromo_Close := ImageSearchFunction(Promo_Close, Promo_CloseX, Promo_CloseY, , , , , 25)

    If (isNews || isPromo_Close)
        KeysFunction("esc")

    If (isContinue_A || isContinue_B)
        KeysFunction("space")
}

TriosFunction() {
    isTriosActive := ImageSearchFunction(TriosActive, TriosActiveX, TriosActiveY, 50, 825, 140, 870, 10)
    isDuosActive := ImageSearchFunction(DuosActive, DuosActiveX, DuosActiveY, 50, 825, 140, 870, 10)
    isMixTapeActive := ImageSearchFunction(MixTapeActive, MixTapeActiveX, MixTapeActiveY, 150, 660, 330, 700, 5)
    readyButton := ImageSearchFunction(Ready, ReadyX, ReadyY, 40, 905, 420, 1030, 10)

    If isTriosActive && readyButton
        ClickFunction(ReadyX, ReadyY, 1)
    Else If isDuosActive
        ClickFunction(DuosActiveX, DuosActiveY)
    Else If isMixTapeActive
        ClickFunction(MixTapeActiveX, MixTapeActiveY + 50)

    isTrios := ImageSearchFunction(Trios, TriosX, TriosY, 90, 415, 460, 550, 10)
    If isTrios {
        ClickFunction(TriosX, TriosY)
        If readyButton
            ClickFunction(ReadyX, ReadyY, 1)
    }
}

DuosFunction() {
    isTriosActive := ImageSearchFunction(TriosActive, TriosActiveX, TriosActiveY, 50, 825, 140, 870, 10)
    isDuosActive := ImageSearchFunction(DuosActive, DuosActiveX, DuosActiveY, 50, 825, 140, 870, 10)
    isMixTapeActive := ImageSearchFunction(MixTapeActive, MixTapeActiveX, MixTapeActiveY, 150, 660, 330, 700, 5)
    readyButton := ImageSearchFunction(Ready, ReadyX, ReadyY, 40, 905, 420, 1030, 10)

    If isDuosActive && readyButton
        ClickFunction(ReadyX, ReadyY, 1)
    Else If isTriosActive
        ClickFunction(TriosActiveX, TriosActiveY)
    Else If isMixTapeActive
        ClickFunction(MixTapeActiveX, MixTapeActiveY + 50)

    isDuos := ImageSearchFunction(Duos, DuosX, DuosY, 90, 550, 460, 690, 10)
    If isDuos {
        ClickFunction(DuosX, DuosY)
        If readyButton
            ClickFunction(ReadyX, ReadyY, 1)
    }
}

MixTapeFunction() {
    isTriosActive := ImageSearchFunction(TriosActive, TriosActiveX, TriosActiveY, 50, 825, 140, 870, 10)
    isDuosActive := ImageSearchFunction(DuosActive, DuosActiveX, DuosActiveY, 50, 825, 140, 870, 10)
    isMixTapeActive := ImageSearchFunction(MixTapeActive, MixTapeActiveX, MixTapeActiveY, 150, 660, 330, 700, 5)
    readyButton := ImageSearchFunction(Ready, ReadyX, ReadyY, 40, 905, 420, 1030, 10)

    If !(isTriosActive || isDuosActive) && isMixTapeActive && readyButton
        ClickFunction(ReadyX, ReadyY, 1)
    Else If isTriosActive
        ClickFunction(TriosActiveX, TriosActiveY)
    Else If isDuosActive
        ClickFunction(DuosActiveX, DuosActiveY)

    isMixTape := ImageSearchFunction(MixTape, MixTapeX, MixTapeY, 855, 275, 1190, 290, 5)
    If isMixTape {
        ClickFunction(MixTapeX, MixTapeY)
        If readyButton
            ClickFunction(ReadyX, ReadyY, 1)
    }
}

IngameFunction() {
    inTriosOrDuos := ImageSearchFunction(Tr_Ds_Playing, Tr_Ds_PlayingX, Tr_Ds_PlayingY, 400, 900, 670, 1070, 10)
    inMixtape := ImageSearchFunction(Mixtape_Playing, Mixtape_PlayingX, Mixtape_PlayingY, 400, 900, 670, 1070, 10)

    If inTriosOrDuos {
        KeysFunction("w down", , 2500)
        KeysFunction("w up")
    }

    If inMixtape {
        KeysFunction("w down", , 2500)
        KeysFunction("w up")
    }
}

OtherFunction() {
    isShip := ImageSearchFunction(Ship, ShipX, ShipY, , , , , 32)
    isRequeue := ImageSearchFunction(Requeue, RequeueX, RequeueY)
    isRequeue2 := ImageSearchFunction(Requeue2, Requeue2X, Requeue2Y, 1400, , , 110, 25)
    isEscapeKey := ImageSearchFunction(EscapeKey, EscapeKeyX, EscapeKeyY, , 970, 200, , 80)
    isEscapeKey2 := ImageSearchFunction(EscapeKey2, EscapeKey2X, EscapeKey2Y, , 940, 200, , 32)
    isEscape_Back := ImageSearchFunction(Escape_Back, Escape_BackX, Escape_BackY, , , , , 32)
    isReturn_Lobby := ImageSearchFunction(Return_Lobby, Return_LobbyX, Return_LobbyY, 1550, 1020, , , 25)

    If (isRequeue || isRequeue2) {
        KeysFunction("1")
    }

    If isShip {
        ClickFunction(ShipX, ShipY)
    }

    If (isEscapeKey || isEscape_Back || isEscapeKey2) {
        KeysFunction("esc")
    }

    If (isReturn_Lobby && !isRequeue2) {
        KeysFunction("space", , 1200)
    }
}

LegendFunction() {
    isGibi := ImageSearchFunction(Gibi, GibiX, GibiY, , , , , 80)
    isWraith := ImageSearchFunction(Wraith, WraithX, WraithY, , , , , 80)
    isLifeline := ImageSearchFunction(Lifeline, LifelineX, LifelineY, , , , , 80)

    If isGibi
        ClickFunction(GibiX, GibiY)

    If isWraith
        ClickFunction(WraithX, WraithY)

    If isLifeline
        ClickFunction(LifelineX, LifelineY)
}

; --- Settings.ini ---
IniRead:
    IfNotExist, settings.ini
    {
        MsgBox, Couldn't find settings.ini. Click Ok to Create!

        IniWrite, "MixTape", settings.ini, GameType, Type
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
        IniRead, MLWebhook, settings.ini, Webhook, MLU
        IniRead, TOWebhook, settings.ini, Webhook, TOU
        IniRead, UserId, settings.ini, UUID, UUID
    }
return

; ######################################################### Bottom #########################################################
RunAsAdmin() {
    Global 0
IfEqual, A_IsAdmin, 1, Return 0

Loop, %0%
    params .= A_Space . %A_Index%

DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
ExitApp
}

HideProcess() {
    if ((A_Is64bitOS=1) && (A_PtrSize!=4))
        hMod := DllCall("LoadLibrary", Str, "hyde64.dll", Ptr)
    else if ((A_Is32bitOS=1) && (A_PtrSize=4))
        hMod := DllCall("LoadLibrary", Str, "hyde.dll", Ptr)
    else
    {
        MsgBox, Mixed Versions detected!`nOS Version and AHK Version need to be the same (x86 & AHK32 or x64 & AHK64).`n`nScript will now terminate!
        ExitApp
    }

    if (hMod)
    {
        hHook := DllCall("SetWindowsHookEx", Int, 5, Ptr, DllCall("GetProcAddress", Ptr, hMod, AStr, "CBProc", ptr), Ptr, hMod, Ptr, 0, Ptr)
        if (!hHook)
        {
            MsgBox, SetWindowsHookEx failed!`nScript will now terminate!
            ExitApp
        }
    }
    else
    {
        MsgBox, LoadLibrary failed!`nScript will now terminate!
        ExitApp
    }

    MsgBox, % "Process ('" . A_ScriptName . "') hidden! `nYour uuid is " UUID
return
}

ExitSub:
    if (hHook)
    {
        DllCall("UnhookWindowsHookEx", Ptr, hHook)
        MsgBox, % "Process unhooked!"
    }
    if (hMod)
    {
        DllCall("FreeLibrary", Ptr, hMod)
        MsgBox, % "Library unloaded"
    }
ExitApp