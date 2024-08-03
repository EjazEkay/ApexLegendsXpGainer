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

keyboard = Controller()

while True:
  result = my.getfunc()
  ( isMain, isError, isEsc, isEsc2, isEsc3, isReady, isAlive, isAlive2, isReque, isShip, isContinue, isContinue2, isWraith, isGibi, isPathy, isMaxlevel, isCheckMainMenu, isCheckMixTape ) = result

  if isCheckMainMenu:
    if isMain:
      keyboard.press(Key.space)
      keyboard.release(Key.space)
      time.sleep(0.5)

    if isError:
      keyboard.press(Key.esc)
      keyboard.release(Key.esc)
      time.sleep(0.5)

  if isReady and not isMaxlevel:
    if isCheckMixTape:
      keyboard.press(Key.esc)
      keyboard.release(Key.esc)
      time.sleep(0.5)
      keyboard.press(Key.esc)
      keyboard.release(Key.esc)
      time.sleep(0.5)
      pyautogui.moveTo(isReady)
      time.sleep(.25)
      pyautogui.click()
      time.sleep(1)

    if not isCheckMixTape:
      pyautogui.moveTo(200, 800)
      time.sleep(.1)
      pyautogui.click()
      time.sleep(1)
      pyautogui.moveTo(1000, 600)
      time.sleep(.1)
      pyautogui.click()
      time.sleep(.1)

  if (isEsc or isEsc2 or isEsc3) and not (isCheckMainMenu or isAlive or isAlive2 or isReque):
    keyboard.press(Key.esc)
    keyboard.release(Key.esc)
    time.sleep(0.5)

  if isReque:
    keyboard.press('1')
    keyboard.release('1')
    time.sleep(0.5)

  if isAlive or isAlive2:
    keyboard.press('w')
    time.sleep(2.5)
    keyboard.release('w')
    time.sleep(0.5)

  if isShip:
    pyautogui.moveTo(isShip)
    keyboard.press(Key.space)
    keyboard.release(Key.space)
    time.sleep(1)

  if isContinue or isContinue2:
    pyautogui.moveTo(250, 950)
    for _ in range(3):
      keyboard.press(Key.space)
      keyboard.release(Key.space)
      time.sleep(0.5)

  if (isWraith or isGibi or isPathy) and not (isAlive or isAlive2 or isShip or isReady or isContinue or isEsc or isEsc3 or isCheckMainMenu or isCheckMixTape):
    pyautogui.moveTo(isPathy)
    keyboard.press(Key.space)
    keyboard.release(Key.space)
    pyautogui.moveTo(isWraith)
    keyboard.press(Key.space)
    keyboard.release(Key.space)
    pyautogui.moveTo(isGibi)
    keyboard.press(Key.space)
    keyboard.release(Key.space)
    time.sleep(0.5)
  
  time.sleep(1)
  my.activate_window()

  time.sleep(2)