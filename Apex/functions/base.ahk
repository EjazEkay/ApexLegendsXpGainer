; Image Search Function
ImageSearchFunction(image, ByRef x, ByRef y, startX := 0, startY := 0, endX := 1919, endY := 1079, variation := 0) {
  ImageSearch, x, y, %startX%, %startY%, %endX%, %endY%, *%variation% %image%
  Return !ErrorLevel
}

; Click Perform Function
ClickFunction(coordX, coordY, oldposition := 0, delay := 2500) {
  If oldposition {
    MouseGetPos, startX, startY
    MouseMove, %coordX%, %coordY%, 15
    Click
    Sleep, %delay%
    MouseMove, startX, startY, 15
    Sleep, %delay%
  } Else {
    MouseMove, %coordX%, %coordY%, 5
    Click
    Sleep, %delay%
  }
}

; Keyboard Shortcut Key Function
; ^ for Ctrl
; ! for Alt
; + for Shift
; # for Win (Windows key)
KeysFunction(key, combination := "", delay := 1500) {
  SendInput, %combination%{%key%}
  Sleep, %delay%
}