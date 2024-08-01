#      _    ____  _______  __  _     _____ ____ _____ _   _ ____  ____  
#     / \  |  _ \| ____\ \/ / | |   | ____/ ___| ____| \ | |  _ \/ ___| 
#    / _ \ | |_) |  _|  \  /  | |   |  _|| |  _|  _| |  \| | | | \___ \ 
#   / ___ \|  __/| |___ /  \  | |___| |__| |_| | |___| |\  | |_| |___) |
#  /_/   \_\_|   |_____/_/\_\ |_____|_____\____|_____|_| \_|____/|____/ 

# ____________________________________________________ [ Imports Section ] ____________________________________________________

import time

import pyautogui
from pynput.keyboard import Key, Controller

import funcs as my

# ____________________________________________________ [ Main Section ] ____________________________________________________

MaxScreens = my.get_max_screens()
CurrentScreen = 1
keyboard = Controller()

while True:
  result = my.getfunc()
  ( isMain, isError, isEsc, isEsc2, isReady, isAlive, isAlive2, isReque, isShip, isShip2, isContinue, isWraith, isGibi, isMaxlevel, isCheckMainMenu, isCheckMixTape ) = result

  if isCheckMainMenu:
    if isMain:
      keyboard.press(Key.space)
      keyboard.release(Key.space)

    if isError:
      keyboard.press(Key.esc)
      keyboard.release(Key.esc)

  if isReady and not isMaxlevel:
    if isCheckMixTape:
      pyautogui.moveTo(isReady)
      time.sleep(.25)
      pyautogui.click()

    if not isCheckMixTape:
      pyautogui.moveTo(200, 800)
      time.sleep(.1)
      pyautogui.click()
      time.sleep(1)
      pyautogui.moveTo(1000, 600)
      time.sleep(.1)
      pyautogui.click()
      time.sleep(.1)

  if (isEsc or isEsc2) and not (isCheckMainMenu or isAlive or isAlive2 or isReque):
    keyboard.press(Key.esc)
    keyboard.release(Key.esc)

  if isReque:
    keyboard.press('1')
    keyboard.release('1')

  if isAlive or isAlive2:
    keyboard.press('w')
    time.sleep(2.5)
    keyboard.release('w')

  if isShip or isShip2:
    pyautogui.click(isShip)
    pyautogui.click(isShip2)

  if isContinue:
    for _ in range(4):
      keyboard.press(Key.space)
      keyboard.release(Key.space)
      time.sleep(0.5)

  if (isWraith or isGibi) and not ((isAlive or isAlive2) and (isShip or isShip2)):
    pyautogui.click(isWraith)
    pyautogui.click(isGibi)
  
  CurrentScreen = my.activate_window(CurrentScreen, MaxScreens)

  time.sleep(2)