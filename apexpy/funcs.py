import pyautogui
import subprocess
import time
import pymsgbox

# Images Path Address
Main = "./images/main.png"
Error = "./images/error.png"
Esc = "./images/esc.png"
Esc2 = "./images/esc2.png"
Esc3 = "./images/esc3.png"
Ready = "./images/ready.png"
Alive = "./images/alive.png"
Alive2 = "./images/alive2.png"
Reque = "./images/reque.png"
Ship = "./images/ship.png"
Continue = "./images/continue.png"
Continue2 = "./images/continue2.png"
Wraith = "./images/wraith.png"
Gibi = "./images/gibi.png"
Pathy = "./images/pathy.png"
Maxlevel = "./images/maxlevel.png"

CheckMainMenu = "./images/check_mainmenu.png"
CheckMixTape = "./images/check_mixtape.png"

# ____________________________________________________ Functions Seperator ____________________________________________________

def imagefunc(img, name="", variation=0.9):
  try:
    image = pyautogui.locateCenterOnScreen(img, grayscale=True, confidence=variation)

    if image:
      print(f"Found At: [ {image} ] - Image: {name}")
      return image
      
  except pyautogui.ImageNotFoundException:
    return 0

def activate_window():
  winSwap = r'./ahk/winSwap.exe'
  subprocess.run([winSwap], check=True)
  time.sleep(.5)

# ____________________________________________________ Functions Seperator ____________________________________________________

def getfunc():
  # Images Variables
  isMain = imagefunc(Main, 'MainMenu')
  isError = imagefunc(Error, 'Error/Info')
  isEsc = imagefunc(Esc, 'Esc Key')
  isEsc2 = imagefunc(Esc2, 'Esc2 Key')
  isEsc3 = imagefunc(Esc3, 'Esc3 Key')
  isReady = imagefunc(Ready, 'Ready Button')
  isAlive = imagefunc(Alive, 'Alive')
  isAlive2 = imagefunc(Alive2, 'Alive2')
  isReque = imagefunc(Reque, 'Reque')
  isShip = imagefunc(Ship, 'Ship', .7)
  isContinue = imagefunc(Continue, 'Continue Button')
  isContinue2 = imagefunc(Continue2, 'Continue2 Button')
  isWraith = imagefunc(Wraith, 'Wraith')
  isGibi = imagefunc(Gibi, 'Gibiraltor')
  isPathy = imagefunc(Pathy, 'Pathfinder')
  isMaxlevel = imagefunc(Maxlevel, 'Max Level')

  isCheckMainMenu = imagefunc(CheckMainMenu, 'Active: Main Menu Screen')
  isCheckMixTape = imagefunc(CheckMixTape, 'Active: MixTape Mode')

  return ( isMain, isError, isEsc, isEsc2, isEsc3, isReady, isAlive, isAlive2, isReque, isShip, isContinue, isContinue2, isWraith, isGibi, isPathy, isMaxlevel, isCheckMainMenu, isCheckMixTape )