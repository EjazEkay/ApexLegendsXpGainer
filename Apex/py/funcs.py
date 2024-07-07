import pyautogui
from termcolor import colored

# Images Path Address
Main = "./images/main.png"
Error = "./images/error.png"
Esc = "./images/esc.png"
Esc2 = "./images/esc2.png"
Ready = "./images/ready.png"
Type = "./images/type.png"
Alive = "./images/alive.png"
Alive2 = "./images/alive2.png"
Reque = "./images/reque.png"
Ship = "./images/ship.png"
Ship2 = "./images/ship2.png"
Continue = "./images/continue.png"
Wraith = "./images/wraith.png"
Gibi = "./images/gibi.png"
Maxlevel = "./images/maxlevel.png"


# ____________________________________________________ Functions Seperator ____________________________________________________


def imagefunc(img, name="", variation=0.99):
  try:
    image = pyautogui.locateCenterOnScreen(img, confidence=variation)

    if image:
      print(colored(f"Image: {name} - Found At: {image}", 'blue', attrs=['bold']))
      return image
      
  except pyautogui.ImageNotFoundException:
    return 0


# ____________________________________________________ Functions Seperator ____________________________________________________


def getfunc():
  # Images Variables
  isMain = imagefunc(Main, 'MainMenu')
  isError = imagefunc(Error, 'Error/Info')
  isEsc = imagefunc(Esc, 'Esc Key')
  isEsc2 = imagefunc(Esc2, 'Esc2 Key')
  isReady = imagefunc(Ready, 'Ready Button')
  isType = imagefunc(Type, 'Game Type')
  isAlive = imagefunc(Alive, 'Alive')
  isAlive2 = imagefunc(Alive2, 'Alive2')
  isReque = imagefunc(Reque, 'Reque')
  isShip = imagefunc(Ship, 'Ship')
  isShip2 = imagefunc(Ship2, 'Ship2')
  isContinue = imagefunc(Continue, 'Continue Button')
  isWraith = imagefunc(Wraith, 'Wraith')
  isGibi = imagefunc(Gibi, 'Gibiraltor')
  isMaxlevel = imagefunc(Maxlevel, 'Max Level')

  return (
  isMain,
  isError,
  isEsc,
  isEsc2,
  isReady,
  isType,
  isAlive,
  isAlive2,
  isReque,
  isShip,
  isShip2,
  isContinue,
  isWraith,
  isGibi,
  isMaxlevel
  )

# ____________________________________________________ Functions Seperator ____________________________________________________
