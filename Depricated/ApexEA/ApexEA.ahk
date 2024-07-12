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

; Initials Reads
IniRead, count, settings.ini, Settings, COUNTER

; Imports
#Include, functions.ahk
WorkingDir := A_ScriptDir "\py\"
filePath := "./data/discord.txt"

; Variables
DiscordMessage := ""
Clipboard := ""
WindowTitle := "23053RN02A"
urlIp := "http://ipinfo.io/json"
urlMail := "https://mail.tm/en/"
urlEA := "https://ea.com/register/"

url := "" ; default urlIp
regtext := "" ; default ""

; Credentials
ipaddress := ""
emailaddress := ""
emailpassword := ""
eaid := ""
eapass := ""
emailcode := 
counter := count

; Flags
goback := 0 ; default 0
changeip := 1 ; default 1
refresh := 0 ; default 0
needip := 1 ; default 1
needcred := 0 ; default 0
havecode := 0 ; default 0
easteps := 0 ; default 0
swapdone := 0 ; default 0

; ____________________________________________________ [ Main ] ____________________________________________________

If WinExist(WindowTitle) {
  WinActivate
} Else {
  MsgBox, 0, Error: Screen not found, The window "%windowTitle%" was not found., 60
  ExitApp
}

Loop {
  ; Image Serach
  RunWait, py "%WorkingDir%ea.py", %WorkingDir%, hide

  ini := IniReadFunc()

  If (ini.isplane && changeip) {
    Vplane := ExtractValue(ini.isplane)
    ClickFunc(Vplane.x, Vplane.y, 1, 1, , 1800)
    Sleep, 3000
    changeip := 0
    url := urlIp
  }

  If (ini.isincog) {
    Vincog := ExtractValue(ini.isincog)
    ClickFunc(Vincog.x, Vincog.y)
  }

  If (ini.ishome && url != "") {
    KeysFunc("tab", , 6, 300)
    Send, %url%
    Sleep, 300
    KeysFunc("enter")
    url := ""
  }

  If (ini.isreload && refresh) {
    Vreload := ExtractValue(ini.isreload)
    ClickFunc(Vreload.x, Vreload.y, 1, 1)
    refresh := 0
  }

  If (ini.isip && needip) {
    Sleep, 1000
    KeysFunc("a", "^")
    KeysFunc("c", "^", , 2000)
    ClipWait, 7000
    regtext := Clipboard
    ipaddress := ExtractIP(regtext)
    regtext := ""
    Clipboard := ""

    If (!ipaddress) {
      MsgBox, 0, RegEx Error, Unable to fetch the Ip address retrying [3], 3
      refresh := 1
    } Else {
      TabsFunc(, , 1)
      needip := 0
      needcred := 1
      url := urlMail
    }
  }

  If (ini.ismail && !ini.isdetails && needcred) {
    Sleep, 200
    Vmail := ExtractValue(ini.ismail)
    ClickFunc(Vmail.x - 50, Vmail.y)
    Sleep, 200
    KeysFunc("a", "^")
    KeysFunc("c", "^", , 2000)
    ClipWait, 7000
    regtext := Clipboard
    emailaddress := ExtractEmail(regtext)
    emailpassword := ExtractPassword(regtext)
    regtext := ""
    Clipboard := ""

    If !(emailaddress && emailpassword) {
      MsgBox, 0, RegEx Error, Unable to fetch the Credentials retrying [3], 3
      refresh := 1
    } Else {
      TabsFunc(, , 1)
      needcred := 0
      url := urlEA
      easteps := 1
    }
  }

  If (ini.isemail && !havecode) {
    Vemail := ExtractValue(ini.isemail)
    ClickFunc(Vemail.x, Vemail.y)
    Sleep, 200
    KeysFunc("a", "^")
    KeysFunc("c", "^", , 2000)
    regtext := Clipboard
    emailcode := ExtractCode(regtext)
    regtext := ""
    Clipboard := ""

    If (!emailcode) {
      Send, {RButton}
      Sleep, 3000
      refresh := 1
    } Else {
      havecode := 1
      Send, {RButton}
      TabsFunc(1)
    }
  }

  If (ini.isdate && easteps == 1) {
    KeysFunc("tab", , 7, 300)
    KeysFunc("down")
    KeysFunc("tab")
    KeysFunc("down")
    KeysFunc("tab")
    KeysFunc("down", , 25, 100)
    KeysFunc("tab")
    KeysFunc("enter", , , 2000)
    easteps := 2
  }

  If (ini.iscredential && easteps == 2) {
    KeysFunc("tab", , 2, 300)
    Send, %emailaddress%
    KeysFunc("tab")
    eaid := EAIDFunc()
    Send, %eaid%
    KeysFunc("tab")
    eapass := EAPassFunc()
    Send, %eapass%
    KeysFunc("tab", , 2, 300)
    KeysFunc("enter", , , 2000)
    easteps := 3
  }

  If (ini.isagree && easteps == 3) {
    KeysFunc("tab", , 9, 500)
    KeysFunc("space")
    KeysFunc("tab", , 3, 300)
    KeysFunc("enter", , , 2000)
    easteps := 4
  }

  If (ini.isverify && easteps == 4) {
    If (!swapdone) {
      Sleep, 250
      TabsFunc(0, 1)
      Sleep, 250
      refresh := 1
      swapdone := 1
    }

    If (havecode) {
      Send, %emailcode%
      KeysFunc("enter")
      easteps := 5
      swapdone := 0
      emailcode := ""
      havecode := 0
      SaveData(counter, emailaddress, emailpassword, eaid, eapass, ipaddress)
      emailAddress := StrReplace(emailAddress, "`n", "")
      DiscordMessage := "# > Account [ " counter " ]\n``````ahk\nEmail:" emailaddress "`nPasword: " emailpassword "\nEA: " eaid "\nEA-Password: " eapass "\n``````\n**IpAddress:** || " ipaddress " ||"
      AppendDiscordText(DiscordMessage, filePath)
      Sleep, 500
      RunWait, py "%WorkingDir%discord.py", %WorkingDir%
      counter := counter + 1
    }
  }

  If (ini.isfinish && easteps == 5) {
    KeysFunc("tab")
    KeysFunc("enter")
    ; easteps := 6
    easteps := 0
    goback := 1
    changeip := 1
    needip := 1
    ipaddress := ""
    emailaddress := ""
    emailpassword := ""
    eaid := ""
    Sleep, 5000
  }

  If (ini.isback && goback) {
    Vback := ExtractValue(ini.isback)
    ClickFunc(Vback.x, Vback.y)
    Sleep, 1000
    MouseMove, Vback.x + 100, Vback.y - 300, 20
    Send {Click down}
    MouseMove, Vback.x + 100, Vback.y - 600, 50
    Send {Click up}
    goback := 0
  }

  If (ini.istechnical) {
    refresh := 1
    easteps := 1
  }

  If (ini.captcha) {
    MsgBox, Please Solve Captcha to preed the automation :(, Click Ok after solving captcha.
  }

  Sleep, 400
}

; ____________________________________________________ [ Bottom ] ____________________________________________________

F2::
ExitApp

; Future Code Here
; If (ini.isprofile && easteps == 6) {
;   easteps := 0
;   changeip := 1

;   ipaddress := ""
;   emailaddress := ""
;   emailpassword := ""
;   eaid := ""

;   needip := 1
;   goback := 1
; }

; KeysFunc("tab")
; KeysFunc("space")
; KeysFunc("tab", , 2, 400)
; KeysFunc("enter")
; Loop, 10 {
;   Send, {WheelUp}
; }
