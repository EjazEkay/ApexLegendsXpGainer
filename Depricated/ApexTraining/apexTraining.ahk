; Libraries
#NoEnv
#Persistent
#SingleInstance, Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWorkingDir, %A_ScriptDir%

; Functions Imports
#Include, functions.ahk
#Include, paths.ahk

; Variables
WinEA := "EA"
Path := "D:\Apex\r5apex.exe"
EmailArray := ["email@example.com", "email2@example.com"]
Email := 
Password := "Milkymagic@0123"

; Main Loop
Loop {
  ; Email Array Handling
  ; If (1) {
  ;   if (A_Index > EmailArray.MaxIndex()) {
  ;     MsgBox, No more emails in the array.
  ;     ExitApp
  ;   }
  ;   Email := EmailArray[A_Index]
  ; }

  ; EaAppFunction := EaAppFunc(Path, Email, Password, WinEA)

  ; If (EaAppFunction) {
  ;   MsgBox, Code Block Here!
  ; } Else {
  ;   Closefunc(WinEA)
  ; }

  MainMenu := MainMenu()
  If (MainMenu.isMain) {
    KeysFunc("Space")
  } Else If (MainMenu.isInfo) {
    KeysFunc("Space")
    KeysFunc("Esc")
  } Else If (MainMenu.isReady) {
    ClickFunc(MainMenu.ReadyX, MainMenu.ReadyY, 1, 5)
  } Else If (MainMenu.isAlive) {
    KeysFunc("C")
    KeysFunc("Space")
    KeysFunc("W down")
    Sleep, 50
    KeysFunc("LShift down")
    Sleep, 50
    KeysFunc("LCtrl down")
    Sleep, 50
    KeysFunc("W up")
    KeysFunc("LShift up")
    KeysFunc("LCtrl up")
  }

  Sleep, 2000
}

F2::
ExitApp