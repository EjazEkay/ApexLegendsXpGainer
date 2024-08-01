;      _    ____  _______  __  _     _____ ____ _____ _   _ ____  ____  
;     / \  |  _ \| ____\ \/ / | |   | ____/ ___| ____| \ | |  _ \/ ___| 
;    / _ \ | |_) |  _|  \  /  | |   |  _|| |  _|  _| |  \| | | | \___ \ 
;   / ___ \|  __/| |___ /  \  | |___| |__| |_| | |___| |\  | |_| |___) |
;  /_/   \_\_|   |_____/_/\_\ |_____|_____\____|_____|_| \_|____/|____/ 

; ____________________________________________________ [ Header ] ____________________________________________________

#NoEnv
#Persistent
#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWorkingDir, %A_ScriptDir%

; Imports
#Include, functions.ahk
WorkingDir := A_ScriptDir "\py\"
filePath := "./data/discord.txt"

; Initials Reads
IniRead, huawei_URL, settings.ini, Settings, huawei
IniRead, ea_URL, settings.ini, Settings, ea
IniRead, eaSettings_URL, settings.ini, Settings, easettings
IniRead, gmailFilePath, settings.ini, Settings, gmailFile
IniRead, disPath, settings.ini, Settings, discordFile
IniRead, sandboxTitle, settings.ini, Settings, sandboxtitle
IniRead, usedFlag, settings.ini, Settings, useflag

; Flags / Variables
Clipboard := ""
regtext := ""
resetIp := 0 ; Default 0
credFlag := 0 ; Default 0
searchFlag := 0 ; Default 0
maxUsedFlag := 2
maxLimit := 10
enableData := 0
finishFlag := 0
dobFlag := 0
credentialFlag := 0
agreeFlag := 0
codeFlag := 0
createFlag := 0

; ____________________________________________________ [ Main ] ____________________________________________________

WindowRun("firefox", huawei_URL)

Loop {
  ini := IniReadFunc(WorkingDir)

  If (ini.isLogin) {
    valueLogin := ExtractValue(ini.isLogin)
    ClickFunc(valueLogin.x, valueLogin.y, , 1)
  }

  If (ini.isData && !resetIp) {
    valueData := ExtractValue(ini.isData)
    ClickFunc(valueData.x, valueData.y, , 1)
    resetIp := 1
    enableData := 1
  } Else If (ini.isDataoff && enableData) {
    valueDataoff := ExtractValue(ini.isDataoff)
    ClickFunc(valueDataoff.x, valueDataoff.y)
    enableData := 0

    RunWait, py "%WorkingDir%ip.py", %WorkingDir%, hide
    Sleep, 250
    RunWait, py "%WorkingDir%createMail.py", %WorkingDir%, hide
    Sleep, 250

    IniRead, IP, settings.ini, Settings, ip
    IniRead, EMAIL, settings.ini, Settings, email
    IniRead, PASSWORD, settings.ini, Settings, password

    If (IP && EMAIL && PASSWORD) {
      IpAddress := IP
      EmailAddress := EMAIL
      EmailPassword := PASSWORD
      credFlag := 0
    } Else {
      MsgBox, 0, , Credential Error Occured!
    }

    Loop {
      internetAvl := PingInternet()
      If (internetAvl) {
        WindowAppRun()
        Break
      }
      MsgBox, 0, , No Internet Connection! Retrying...,3
    }
    createFlag := 1
  }

  If (ini.isCreate && createFlag) {
    ValueCreate := ExtractValue(ini.isCreate)
    ClickFunc(ValueCreate.x, ValueCreate.y)
    createFlag := 0
    dobFlag := 1
  }

  If (ini.isDob && dobFlag) {
    KeysFunc("tab", , 8, 250)
    Sleep, 500
    KeysFunc("down")
    KeysFunc("tab")
    KeysFunc("down")
    KeysFunc("tab")
    KeysFunc("down", , 25, 100)
    KeysFunc("tab")
    KeysFunc("enter", , , 2000)
    dobFlag := 0
    credentialFlag := 1
  }

  If (ini.isCred && credentialFlag) {
    KeysFunc("tab", , 2, 300)
    Send, %EmailAddress%
    KeysFunc("tab")
    EA := EAFunc()
    EaId := EA.eaid
    EaPass := EA.eapass
    Send, %EaId%
    KeysFunc("tab")
    Send, %EaPass%
    KeysFunc("tab", , 2, 300)
    Sleep, 3000
    KeysFunc("enter", , , 2000)
    credentialFlag := 0
    agreeFlag := 1
  }

  If (ini.isAgree && agreeFlag) {
    valueAgree := ExtractValue(ini.isAgree)
    ClickFunc(valueAgree.x, valueAgree.y)
    KeysFunc("tab", , 3, 300)
    KeysFunc("enter", , , 2000)
    agreeFlag := 0
  }

  If (ini.isCode) {
    RunWait, py "%WorkingDir%code.py", %WorkingDir%, hide
    Sleep, 1000

    IniRead, CODE, settings.ini, Settings, code

    If (CODE) {
      Send, %CODE%
      KeysFunc("enter")
      finishFlag := 1
    } Else {
      MsgBox, Error Code Not Found
    }
  }

  If (ini.isFinish && finishFlag) {
    KeysFunc("tab")
    KeysFunc("enter")

    CreatedAt := GetCurrentDateTime()
    SecondaryGmail := "Null"

    SaveDetailsToCSV(EmailAddress, EmailPassword, EaId, EaPass, SecondaryGmail, IpAddress, CreatedAt)

    IniRead, count, settings.ini, Settings, counter
    DiscordMessage := "# > Account [ " count " ]\n``````ahk\nEmail:" EmailAddress "`nPasword: " EmailPassword "\nEA: " EaId "\nEA-Password: " EaPass "\nSecondary: " SecondaryGmail "\nCreatedAt: " CreatedAt "\n``````\n**IpAddress:** || " ipaddress " ||"
    AppendDiscordText(DiscordMessage, disPath)
    Sleep, 500
    RunWait, py "%WorkingDir%discord.py", %WorkingDir%

    finishFlag := 0
    resetIp := 0

    Sleep, 5000

    WindowClose("EA")
    DeleteTempFiles()
  }

  If (ini.isTech) {
    MsgBox, Error Technical Issue
  }
  Sleep, 250
}

; Loop {
;   ini := IniReadFunc(WorkingDir)

;   If (ini.isData && resetIp) {
;     valueData := ExtractValue(ini.isData)
;     ClickFunc(valueData.x, valueData.y, , 1)
;     enableData := 1
;     resetIp := 0
;   } Else If (ini.isLogin) {
;     valueLogin := ExtractValue(ini.isLogin)
;     ClickFunc(valueLogin.x, valueLogin.y, , 1)
;   } Else If (ini.isDataoff && enableData) {
;     valueDataoff := ExtractValue(ini.isDataoff)
;     ClickFunc(valueDataoff.x, valueDataoff.y)
;     enableData := 0
;     credFlag := 1
;     searchFlag := 1
;     Sleep, 6000
;     firefoxIncog()
;     Sleep, 6000
;   }

;   If (credFlag) {
;     RunWait, py "%WorkingDir%ip.py", %WorkingDir%
;     Sleep, 500
;     RunWait, py "%WorkingDir%createMail.py", %WorkingDir%
;     Sleep, 500

;     IniRead, IP, settings.ini, Settings, ip
;     IniRead, EMAIL, settings.ini, Settings, email
;     IniRead, PASSWORD, settings.ini, Settings, password

;     If (IP && EMAIL && PASSWORD) {
;       IpAddress := IP
;       EmailAddress := EMAIL
;       EmailPassword := PASSWORD
;       credFlag := 0
;     } Else {
;       MsgBox, 0, , Error Occured!
;     }

;     ; Flag Date of Birth When no Search Image
;     dobFlag := 1
;   }

;   ; If (ini.isSearch && searchFlag) {
;   ;   searchFlag := 0
;   ;   valueSearch := ExtractValue(ini.isSearch)
;   ;   ClickFunc(valueSearch.x, valueSearch.y, , 1)
;   ;   Send, %ea_URL%
;   ;   Sleep, 2000
;   ;   KeysFunc("enter")
;   ;   dobFlag := 1
;   ; }

;   If (ini.isDob && dobFlag) {
;     KeysFunc("tab", , 8, 250)
;     Sleep, 500
;     KeysFunc("down")
;     KeysFunc("tab")
;     KeysFunc("down")
;     KeysFunc("tab")
;     KeysFunc("down", , 25, 100)
;     KeysFunc("tab")
;     KeysFunc("enter", , , 2000)
;     dobFlag := 0
;     credentialFlag := 1
;   }

;   If (ini.isCred && credentialFlag) {
;     KeysFunc("tab", , 2, 300)
;     Send, %EmailAddress%
;     KeysFunc("tab")
;     EA := EAFunc()
;     EaId := EA.eaid
;     EaPass := EA.eapass
;     Send, %EaId%
;     KeysFunc("tab")
;     Send, %EaPass%
;     KeysFunc("tab", , 2, 300)
;     Sleep, 3000
;     KeysFunc("enter", , , 2000)
;     credentialFlag := 0
;     agreeFlag := 1
;   }

;   If (ini.isAgree && agreeFlag) {
;     valueAgree := ExtractValue(ini.isAgree)
;     ClickFunc(valueAgree.x, valueAgree.y)
;     KeysFunc("tab", , 3, 300)
;     KeysFunc("enter", , , 2000)
;     agreeFlag := 0
;     codeFlag := 1
;   }

;   If (ini.isCode && codeFlag) {
;     RunWait, py "%WorkingDir%code.py", %WorkingDir%
;     Sleep, 500

;     IniRead, CODE, settings.ini, Settings, code

;     If (CODE) {
;       Send, %CODE%
;       KeysFunc("enter")
;       finishFlag := 1
;     } Else {
;       MsgBox, Error Code Not Found
;     }
;     codeFlag := 0
;   }

;   If (ini.isFinish && finishFlag) {
;     KeysFunc("tab")
;     KeysFunc("enter")
;     TabSwap(, , 1)
;     Send, %eaSettings_URL%
;     Sleep, 500
;     KeysFunc("enter")
;     Sleep, 10000
;     MouseMove, 960, 540, 10
;     ScrollDown(10)

;     CreatedAt := GetCurrentDateTime()

;     usedFlagTemp := usedFlag
;     usedFlagTemp := usedFlagTemp + 1
;     IniWrite, %usedFlagTemp%, settings.ini, Settings, useflag

;     If (usedFlagTemp > maxUsedFlag) {
;       IniWrite, 0, settings.ini, Settings, useflag
;       SecondaryGmail := CleanData(ReadAndRemoveFirstLine(gmailFilePath))
;     } Else {
;       file := FileOpen(gmailFilePath, "r")
;       SecondaryGmail := CleanData(file.ReadLine())
;       file.Close()
;     }

;     SaveDetailsToCSV(EmailAddress, EmailPassword, EaId, EaPass, SecondaryGmail, IpAddress, CreatedAt)

;     IniRead, count, settings.ini, Settings, counter
;     DiscordMessage := "# > Account [ " count " ]\n``````ahk\nEmail:" EmailAddress "`nPasword: " EmailPassword "\nEA: " EaId "\nEA-Password: " EaPass "\nSecondary: " SecondaryGmail "\nCreatedAt: " CreatedAt "\n``````\n**IpAddress:** || " ipaddress " ||"
;     AppendDiscordText(DiscordMessage, disPath)
;     Sleep, 500
;     RunWait, py "%WorkingDir%discord.py", %WorkingDir%
;     finishFlag := 0
;   }

;   If (ini.isTech) {
;     searchFlag := 1
;   }

;   If (ini.isAddemail) {
;     valueAddmail := ExtractValue(ini.isAddemail)
;     ClickFunc(valueAddmail.x, valueAddmail.y)
;   } Else If (ini.isVerify) {
;     valueVerify := ExtractValue(ini.isVerify)
;     ClickFunc(valueVerify.x, valueVerify.y)
;   } Else If (ini.isSubmit) {
;     valueSubmit := ExtractValue(ini.isSubmit)
;     RunWait, py "%WorkingDir%code.py", %WorkingDir%
;     Sleep, 1500
;     IniRead, CODE, settings.ini, Settings, code
;     Sleep, 250
;     Send, %CODE%
;     Sleep, 250
;     ClickFunc(valueSubmit.x, valueSubmit.y)
;   } Else If (ini.isContinue) {
;     valueContinue := ExtractValue(ini.isContinue)
;     Send, %SecondaryGmail%
;     Sleep, 250
;     ClickFunc(valueContinue.x, valueContinue.y)
;   } Else If (ini.isVerifybtn) {
;     valueVerifyBtn := ExtractValue(ini.isVerifybtn)
;     RunWait, py "%WorkingDir%googleCode.py", %WorkingDir%
;     Sleep, 1500
;     IniRead, GMAILCODE, settings.ini, Settings, gmailcode
;     Sleep, 250
;     Send, %GMAILCODE%
;     Sleep, 250
;     ClickFunc(valueVerifyBtn.x, valueVerifyBtn.y, , , , 2500)
;     KeysFunc("F4", "!")
;     resetIp := 1
;     If (CreationLimit >= MaxLimit) {
;       MsgBox, 0, Info, Account Creation Limit Has Been Reached!
;       ExitApp
;     } Else {
;       ; WindowSwap()
;       MsgBox, 0, Info, An Account has been Created, 3
;     }
;   }

;   Sleep, 1000
; }

; ____________________________________________________ [ Bottom ] ____________________________________________________

F2::
ExitApp