; ------------------------ Base Functions ------------------------
; Image Search Function
ImageSearchFunc(image, ByRef x, ByRef y, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
  ImageSearch, x, y, startX, startY, endX, endY, *variation %image%
  Return !ErrorLevel
}

; Click Perform Function
ClickFunc(coordX, coordY, oldposition := 0, speed := 20, delay := 1000) {
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
KeysFunc(key, combination := "", repeat := 1, delay := 1000) {
  Loop, %repeat% {
    SendInput, %combination%{%key%}
    Sleep, delay
  }
}

; ------------------------ Credential Functions ------------------------
; Extract Email
ExtractEmail(Text) {
  RegExMatch(Text, "in as:\s*([^\s]+@[^ ]+)`n\s*`nPassword:", Match)
  return Match1
}

; Extract Password Email & EA
ExtractPassword(Text) {
  RegExMatch(Text, "Password:\s*([^\s]+)\s*Temp", Match)
  return Match1
}

; Random EA ID Generator
EA_IDFunc() {
  characters := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  RandomString := ""

  Loop, 4 {
    Random, randIndex, 1, StrLen(characters)
    RandomString .= SubStr(characters, randIndex, 1)
  }
  RandomString .= "_"

  Loop, 6 {
    Random, randIndex, 1, StrLen(characters)
    RandomString .= SubStr(characters, randIndex, 1)
  }
  RandomString .= "_"

  Loop, 3 {
    Random, randNumber, 0, 9
    RandomString .= randNumber
  }
  return RandomString
}

; Extract IP Function
ExtractIP() {
  Url := "https://ipinfo.io/json"
  WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  WebRequest.Open("GET", Url)

  try {
    WebRequest.Send()

    while WebRequest.Status != 200
      Sleep, 100

    Response := WebRequest.ResponseText
    RegExMatch(Response, """ip"":\s*""([^""]+)""", match)
    return match1
  } catch error {
    return ""
  }
}

; Extract EA Code
ExtractCode(Text) {
  RegExMatch(Text, "Code is:\s*(\d{6})", Match)
  return Match1
}

; ------------------------ Main Get Credentials Functions ------------------------
; Credential Function
CredentialFunc() {
  Ip := ExtractIP()

  OldClipboard := ClipboardAll
  Clipboard := ""

  CredTempCount := 0
  Cred2TempCount := 0

  Loop {
    isDMailTM := ImageSearchFunc(Dark_mailtm, DmailTMX, DmailTMY, , , , , 16)
    isLMailTM := ImageSearchFunc(Light_mailtm, LmailTMX, LmailTMY, , , , , 16)

    If (isDMailTM || isLMailTM) {
      ClickFunc(DmailTMX + 105, DmailTMY)
      CredTempCount := 0
      Cred2TempCount := 0

      Loop {
        isReloadCheck := ImageSearchFunc(Reload_check, ReloadCheckX, ReloadCheckY, , , , , 16)

        If (!isReloadCheck) {
          KeysFunc("a", "^", , 250)
          KeysFunc("c", "^", , 250)
          ClipWait, 3500

          If (ErrorLevel) {
            MsgBox, 0, Error, Clipboard Copying Issue - Retrying In: 30 Seconds, 30
            Return 0
          }
          Break
        }

        Sleep, 2000

        If (CredTempCount >= 15) {
          If (Cred2TempCount >= 1) {
            MsgBox, 0, Error, Something Went Wrong! - Retrying In: 30 Seconds, 30
            Return 0
          }

          Cred2TempCount := Cred2TempCount + 1
          CredTempCount := 0
          KeysFunc("F5")
        }

        CredTempCount := CredTempCount + 1
      }
      Break
    }

    Sleep, 2000

    If (CredTempCount >= 15) {
      If (Cred2TempCount >= 1) {
        MsgBox, 0, Error, Something Went Wrong! - Retrying In: 30 Seconds, 30
        Return 0
      }

      Cred2TempCount := Cred2TempCount + 1
      CredTempCount := 0
      KeysFunc("F5")
    }

    CredTempCount := CredTempCount + 1
  }

  CopiedText := Clipboard
  Clipboard := OldClipboard

  EmailAddress := ExtractEmail(CopiedText)
  EmailPassword := ExtractPassword(CopiedText)
  EAIdentity := EA_IDFunc()
  EAPassword := "aA1" . EmailPassword

  If !(EmailAddress || EmailPassword)
    MsgBox, 0, Credential Error, Failed to extract email or password.

  Return { Email: EmailAddress, EmailPassword: EmailPassword, EA: EAIdentity, EAPassword: EAPassword, IpAddress: Ip }
}

; ------------------------ Functions ------------------------
; Browser URL Function
Browserfunc(browserPath, url, url2, delay := 500) {
  Run, %browserPath% -private-window %url%
  Sleep, delay
  Run, %browserPath% -private-window %url2%
}

; ------------------------ Other Functions ------------------------
; EA Create Account Function
CreateEAFunc(browserPath, url, url2) {
  ; Open Browser With 2 Tabs - EA, MailTM
  Browserfunc(browserPath, url, url2)

  ; Get Credentials - Email, Password, EA, EA Password
  Credentials := CredentialFunc()
  TempCounter := 0
  Temp2Counter := 0

  KeysFunc("Tab", "^", , 350)

  Loop {
    isEa_1st := ImageSearchFunc(Ea_1st, Ea_1stX, Ea_1stY, , , , , 8)

    If (isEa_1st) {
      TempCounter := 0
      Temp2Counter := 0

      KeysFunc("Tab", , 8, 350)
      KeysFunc("Down", , , 350)
      KeysFunc("Tab", , , 350)
      KeysFunc("Down", , , 350)
      KeysFunc("Tab", , , 350)
      KeysFunc("Down", , 24, 100)
      KeysFunc("Tab", , , 350)
      KeysFunc("Enter", , , 350)

      Loop {
        isEa_2nd := ImageSearchFunc(Ea_2nd, Ea_2ndX, Ea_2ndY, , , , , 8)

        If (isEa_2nd) {
          TempCounter := 0
          Temp2Counter := 0

          KeysFunc("Tab", , 2, 350)
          Send, % Credentials.Email
          Sleep, 400
          KeysFunc("Tab")
          Send, % Credentials.EA
          Sleep, 400
          KeysFunc("Tab")
          Send, % Credentials.EAPassword
          Sleep, 1000
          KeysFunc("Tab", , 2, 350)
          KeysFunc("Enter", , , 350)

          Loop {
            isEa_3rd := ImageSearchFunc(Ea_3rd, Ea_3rdX, Ea_3rdY, , , , , 8)

            If (isEa_3rd) {
              TempCounter := 0
              Temp2Counter := 0

              ClickFunc(Ea_3rdX + 5, Ea_3rdY + 5, 1)
              KeysFunc("Tab", , 3, 200)
              KeysFunc("Enter", , , 350)

              Loop {
                isEa_4th := ImageSearchFunc(Ea_4th, Ea_4thX, Ea_4thY, , , , , 8)

                If (isEa_4th) {
                  TempCounter := 0
                  Temp2Counter := 0

                  KeysFunc("Tab", "^", , 500)
                  KeysFunc("F5", , , 3000)
                  OldClipboard := ClipboardAll
                  Clipboard := ""

                  Loop {
                    isEa_code := ImageSearchFunc(Ea_code, Ea_codeX, Ea_codeY, , , , , 8)

                    If (isEa_code) {
                      TempCounter := 0
                      Temp2Counter := 0

                      KeysFunc("a", "^", , 250)
                      KeysFunc("c", "^", , 250)
                      ClipWait, 3500

                      CopiedText := Clipboard
                      Clipboard := OldClipboard

                      EACode := ExtractCode(CopiedText)

                      If !EACode
                        Return 0

                      KeysFunc("Tab", "^")
                      Send, %EACode%
                      KeysFunc("Tab")
                      KeysFunc("Enter", , , 2000)
                      KeysFunc("Tab")
                      KeysFunc("Enter")

                      Loop {
                        isEa_complete := ImageSearchFunc(Ea_complete, Ea_completeX, Ea_completeY, , , , , 8)

                        If (isEa_complete) {
                          CredentialDetails := % "# Account - [" . SerialCounter . "]`n"
                          CredentialDetails .= "Email Address: " . Credentials.Email . "`n"
                          CredentialDetails .= "Email Password: " . Credentials.EmailPassword . "`n"
                          CredentialDetails .= "EA Identity: " . Credentials.EA . "`n"
                          CredentialDetails .= "EA Password: " . Credentials.EAPassword . "`n"
                          CredentialDetails .= "Created Ip: " . Credentials.IpAddress . "`n`n"

                          OutputFile := "details.txt"
                          FileAppend, % CredentialDetails, % OutputFile

                          SerialCounter := SerialCounter + 1
                          Return 1
                          Break
                        }

                        Sleep, 1500
                        TempCounter := TempCounter + 1

                        If (TempCounter >= 15) {
                          If (Temp2Counter >= 1) {
                            MsgBox, 0, Error, Unable to resolve the Error!, Retrying In: 30 Seconds, 30
                            Return 0
                          }

                          Temp2Counter := Temp2Counter + 1
                          TempCounter := 0
                          KeysFunc("F5")
                        }
                      }
                      Break
                    }

                    Sleep, 1500
                    TempCounter := TempCounter + 1

                    If (TempCounter >= 15) {
                      If (Temp2Counter >= 1) {
                        MsgBox, 0, Error, Unable to resolve the Error!, Retrying In: 30 Seconds, 30
                        Return 0
                      }

                      Temp2Counter := Temp2Counter + 1
                      TempCounter := 0
                      KeysFunc("F5")
                    }
                  }
                  Break
                }

                Sleep, 1500
                TempCounter := TempCounter + 1

                If (TempCounter >= 15) {
                  If (Temp2Counter >= 1) {
                    MsgBox, 0, Error, Unable to resolve the Error!, Retrying In: 30 Seconds, 30
                    Return 0
                  }

                  Temp2Counter := Temp2Counter + 1
                  TempCounter := 0
                  KeysFunc("F5")
                }
              }
              Break
            }

            Sleep, 1500
            TempCounter := TempCounter + 1

            If (TempCounter >= 15) {
              If (Temp2Counter >= 1) {
                MsgBox, 0, Error, Unable to resolve the Error!, Retrying In: 30 Seconds, 30
                Return 0
              }

              Temp2Counter := Temp2Counter + 1
              TempCounter := 0
              KeysFunc("F5")
            }
          }
          Break
        }

        Sleep, 1500
        TempCounter := TempCounter + 1

        If (TempCounter >= 15) {
          If (Temp2Counter >= 1) {
            MsgBox, 0, Error, Unable to resolve the Error!, Retrying In: 30 Seconds, 30
            Return 0
          }

          Temp2Counter := Temp2Counter + 1
          TempCounter := 0
          KeysFunc("F5")
        }
      }
      Break
    }

    Sleep, 1500
    TempCounter := TempCounter + 1

    If (TempCounter >= 15) {
      If (Temp2Counter >= 1) {
        MsgBox, 0, Error, Unable to resolve the Error! - Retrying In: 30 Seconds, 30
        Return 0
      }

      Temp2Counter := Temp2Counter + 1
      TempCounter := 0
      KeysFunc("F5")
    }
  }

  Return 1
}

; Change IP Address
ChangeIpFunc() {

}