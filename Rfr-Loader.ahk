#SingleInstance Force
#include ./JSON/JSON.ahk
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

; Variables
version := "v1.0.0"
GetHWID() {
  hwid := ""
  ComObj := ComObjGet("winmgmts:\\.\root\cimv2")
  for Device in ComObj.ExecQuery("Select * from Win32_ComputerSystemProduct")
    hwid := Device.UUID
  return hwid
}
SendPostRequest(url, data, token) {
  http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  http.Open("POST", "http://localhost:5000/update-hwid", false)
  http.SetRequestHeader("Content-Type", "application/json")
  http.SetRequestHeader("Authorization", "Bearer " . token)

  try {
    http.Send(data)
    if (http.Status() != 200) {
      throw "Error: Status " . http.Status() . ", " . http.ResponseText
    }
    ; return http.ResponseText
  } catch error {
    MsgBox, % "Error: " . error
    ExitApp
  }
}

; ; Login / SignUp - Loader
Gui, Font,, Consolas
Gui, Add, Text, x8 y8 w58 h23 +0x200, Email:
Gui, Add, Edit, x72 y8 w176 h23 vEmail
Gui, Add, Text, x8 y32 w58 h23 +0x200, Password:
Gui, Add, Edit, x72 y32 w176 h23 vPassword
Gui, Add, Button, x6 y62 w243 h30 gLogin, &Login
Gui, Add, Text, x0 y112 w258 h2 +0x10
Gui, Add, Text, x97 y96 w111 h14 +0x200, Dont Have Account?
Gui, Add, Link, x208 y96 w39 h14, <a href="">SignUp</a>
Gui, Add, Link, x192 y120 w56 h14, <a href="https://discord.com/users/521582566642417684">Larry2018</a>
Gui, Add, Text, x8 y120 w36 h14 +0x200, v1.0.0
Gui, Add, Text, x128 y120 w64 h14 +0x200, Need help?

Gui, Show, w255 h142, Rfr - Loader | %version%
Return

Login:
  Gui, Submit, NoHide
  HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  HttpObj.Open("POST", "http://localhost:5000/login", false)
  HttpObj.SetRequestHeader("Content-Type", "application/json")
  JsonData := "{""credential"":""" Email """, ""password"":""" Password """}"
  HttpObj.Send(JsonData)
  ResponseText := HttpObj.ResponseText
  ResponseStatus := HttpObj.Status

  If (ResponseStatus = 200) {
    ResponseObj := JSON.Load(ResponseText)

    Token := ResponseObj.token
    UserId := ResponseObj.userId
    Username := ResponseObj.username
    UserHWID := ResponseObj.userHWID
    UserStatus := ResponseObj.userStatus
    ActiveSubs := ResponseObj.gameSubs

    ; Get local HWID
    LocalHWID := GetHWID()

    If (UserHWID = "") {
      data := "{ ""hwid"": """ LocalHWID """ }"
      SendPostRequest(url, data, Token)
    } Else {
      If (LocalHWID != UserHWID) {
        MsgBox, 0, HWID Error, HWID mismatch!
        ExitApp
      }
    }

    ActiveSubsStr := ""
    Loop, % ActiveSubs.MaxIndex()
    {
      ActiveSub := ActiveSubs[A_Index]
      Game := ActiveSub.game
      ExpirationDate := ActiveSub.expirationDate
      ActiveSubsStr .= Game " - " ExpirationDate "|"
    }

    ; MsgBox, UserId: %UserId%`n`nUser Token: %Token%`n`nUsername: %Username%`nUserHWID: %UserHWID%`n`nActiveSubs: `n%ActiveSubsStr%
    ; Selection Game - Loader
    Gui 2: Font, s12, Consolas
    Gui 2: Font
    Gui 2: Font, s12 w600 cGray, Georgia
    Gui 2: Add, Text, x8 y8 w245 h23 +0x200, Welcome %Username%!
    Gui 2: Font
    Gui 2: Font, s12, Consolas
    Gui 2: Add, Text, x-9 y40 w418 h2 +0x10
    Gui 2: Font
    Gui 2: Font, s8, Consolas
    Gui 2: Add, Text, x5 y152 w216 h30 +0x200, UserID: %UserId%
    Gui 2: Font
    Gui 2: Font, s12, Consolas
    Gui 2: Add, Text, x8 y48 w384 h23 +0x200, Available Games
    Gui 2: Add, DropDownList, x8 y72 w384, Select Game||%ActiveSubsStr%
    Gui 2: Add, StatusBar,, Connected
    Gui 2: Add, Button, gRunScript x8 y112 w385 h29, &Run Script
    Gui 2: Add, Text, x-3 y104 w406 h2 +0x10
    Gui 2: Font
    Gui 2: Font, s8, Consolas
    Gui 2: Add, Link, x336 y160 w57 h14, <a href="https://discord.com/users/521582566642417684">Larry2018</a>
    Gui 2: Font
    Gui 2: Font, s12, Consolas
    Gui 2: Font
    Gui 2: Font, s8, Consolas
    Gui 2: Add, Text, x272 y160 w64 h14 +0x200, Need Help?
    Gui 2: Font

    Gui 2: Show, w400 h200, Rfr - Loader | v1.0.1
    Return

    RunScript:

    Return

  } Else {
    ResponseObj := JSON.Load(ResponseText)
    Message := ResponseObj.Message

    MsgBox, 0, Error, There was an issue with your login attempt. Please check your credentials and try again.`n`nServer Response: %Message%
  }
  Return

  ; GUI Close
  GuiEscape:
  GuiClose:
  ExitApp
