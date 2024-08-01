#Include, functions.ahk
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

; Delete temporary files
DeleteTempFiles() {
  FileDelete, %A_Temp%\*.* ; Deletes files in the system's temp directory
  MsgBox, Temporary files deleted.
}

; Example usage
DeleteTempFiles()
