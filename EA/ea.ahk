#NoEnv
#Persistent
#Include, path.ahk
#SingleInstance, Force
#Include, settings.ahk
#Include, functions.ahk
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWorkingDir, %A_ScriptDir%

Loop {
  CreateEA := CreateEAFunc(browserPath, url, url2)

  If (CreateEA) {
    MsgBox, Everthing Went Good!
  } Else {
    MsgBox, Something Went Wrong!
  }

  Sleep, 2000
}

F2::
ExitApp