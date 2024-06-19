; --- Image Search Function ---

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