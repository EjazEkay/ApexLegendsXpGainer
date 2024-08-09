# Standard Library Imports
import os
import time
import subprocess
import configparser

# Third-Party Imports
import pyautogui
from rich.console import Console
from pynput.keyboard import Key, Controller

console = Console()
keyboard = Controller()
# pyautogui.FAILSAFE = False # Enable it if you get Error of "FAILSAFE" multiple times when bot is running

# ____________________________________________________ Intro ____________________________________________________

def print_intro():
  print("#########################################")
  print("#         ApexLegends Xp Gainer         #")
  print("#               Larry2018               #")
  print("#########################################")
print_intro()

# ____________________________________________________ Images Paths ____________________________________________________

# Variables / Flags
default_delay = 1 # Bot Delay between every next search / window swap

# --- Images ---
image_path = './images'

# --- Main Menu ---
main_menu = f'{image_path}/mainmenu.png'
main_menu_region = (1600, 960, 1830, 1030)
main_continue = f'{image_path}/maincontinue.png'
main_continue_region = (280, 270, 540, 375)
main_err = f'{image_path}/mainerr.png'
main_err_region = (0, 300, 400, 770)

# --- Others ---
esc_key = f'{image_path}/esckey.png'
esc_key2 = f'{image_path}/esckey2.png'
esc_key3 = f'{image_path}/esckey3.png'
esc_key4 = f'{image_path}/esckey4.png'
space_key = f'{image_path}/spacekey.png'
maxlevel = f'{image_path}/maxlevel.png'
maxlevel_region = (650, 100, 760, 220)
ready = f'{image_path}/ready.png'
ready_region = (40, 900, 420, 1040)
mode = f'{image_path}/mode.png'
mode_region = (0, 660, 400, 900)
wraith = f'{image_path}/wraith.png'
gibi = f'{image_path}/gibi.png'
lifeline = f'{image_path}/lifeline.png'
alive = f'{image_path}/alive.png'
alive_region = (440, 950, 600, 1040)
reque = f'{image_path}/reque.png'
reque_region = (1450, 30, 1580, 70)
ship = f'{image_path}/ship.png'

# ____________________________________________________ Functions Section ____________________________________________________

def imagefunc(img, name="", region=None, variation=0.9):
  start_time = time.time()
  try:
    image = pyautogui.locateCenterOnScreen(img, grayscale=True, confidence=variation, region=region)
    elapsed_time = time.time() - start_time

    if image:
      print(f"Found At: [ {image} ] - Image: {name}")
      print(f"Time taken: {elapsed_time:.2f} seconds")
      return image

  except Exception as e:
    return 0

def activate_window():
  winSwap = r'../common/winSwap.exe'
  subprocess.run([winSwap], check=True)

def update_config(max_screens):
  file_path = '../common/config.ini'

  if os.path.exists(file_path):
    os.remove(file_path)

  config = configparser.ConfigParser()
  config.add_section('Results')
  config.set('Results', 'current_screen', '1')
  config.set('Results', 'max_screens', str(max_screens))

  with open(file_path, 'w') as configfile:
    config.write(configfile, space_around_delimiters=False)
   
# ____________________________________________________ Main Section ____________________________________________________

while True:
  try:
    max_screens = int(input("Enter max screens (1-10) - [0 For Single Screen]: "))
    if 0 <= max_screens <= 10:
      break
    else:
      print("Please enter a number between (1-10) or 0")
  except ValueError:
    print("Invalid input. Please enter an integer.")

update_config(max_screens)
pyautogui.alert('Start The Bot!\nNote: i havent checked that the single screen is safe to use or not, use it on your own risk')
start_time = time.time()

while True:
  isMain_menu = imagefunc(main_menu, 'MainMenu Image', main_menu_region)
  if isMain_menu:
    if imagefunc(main_continue, 'MainMenu Continue Button', main_continue_region):
      keyboard.press(Key.space)
      keyboard.release(Key.space)
    if imagefunc(main_err, 'MainMenu Error/Info', main_err_region, .85):
      keyboard.press(Key.esc)
      keyboard.release(Key.esc)
      time.sleep(default_delay)
      if imagefunc(main_continue, 'MainMenu Continue Button', main_continue_region):
        keyboard.press(Key.space)
        keyboard.release(Key.space)
    activate_window()
    time.sleep(default_delay)
    continue
  
  isEsckey = imagefunc(esc_key, 'Escape Key Found!', (0, 0, 1700, 1079))
  isEsckey2 = imagefunc(esc_key2, 'Escape Key2 Found!', (0, 0, 1700, 1079), variation=.85)
  isEsckey3 = imagefunc(esc_key3, 'Escape Key Found!')
  isEsckey4 = imagefunc(esc_key4, 'Escape Key Found!')
  if (isEsckey or isEsckey2 or isEsckey3 or isEsckey4) and not isMain_menu:
    keyboard.press(Key.esc)
    keyboard.release(Key.esc)
    time.sleep(1)

  if (isReady := imagefunc(ready, 'Ready Button', ready_region)):
    isMaxlevel = imagefunc(maxlevel, 'Max Level', maxlevel_region)
    if not isMaxlevel:
      isMode = imagefunc(mode, 'Mode Button', mode_region, .85)
      if not isMode:
        for _ in range(2):
          keyboard.press(Key.esc)
          keyboard.release(Key.esc)
          time.sleep(0.5)
        pyautogui.moveTo(isReady)
        time.sleep(.2)
        pyautogui.click()
        time.sleep(default_delay)
        activate_window()
        time.sleep(default_delay)
        continue
      else:
        pyautogui.moveTo(200, 800)
        pyautogui.click()
        time.sleep(1)
        pyautogui.moveTo(1000, 600)
        pyautogui.click()
        time.sleep(1)
        pyautogui.moveTo(isReady)
        time.sleep(.2)
        pyautogui.click()
        time.sleep(default_delay)
        activate_window()
        time.sleep(default_delay)
        continue

  if (imagefunc(space_key, 'Space Key Found!') and not (isEsckey or isEsckey2 or isEsckey3 or isEsckey4)):
    pyautogui.moveTo(250, 950)
    for _ in range(2):
      keyboard.press(Key.space)
      keyboard.release(Key.space)
      time.sleep(0.2)
    time.sleep(1)
    activate_window()
    time.sleep(default_delay)
    continue

  if (isGibi := imagefunc(gibi, 'Gibi Found')):
    pyautogui.moveTo(isGibi)
    keyboard.press(Key.space)
    keyboard.release(Key.space)
  elif (isWraith := imagefunc(wraith, 'Wraith Found')):
    pyautogui.moveTo(isWraith)
    keyboard.press(Key.space)
    keyboard.release(Key.space)
  elif (isLifeline := imagefunc(lifeline, 'Lifeline Found')):
    pyautogui.moveTo(isLifeline)
    keyboard.press(Key.space)
    keyboard.release(Key.space)

  if imagefunc(alive, 'Alive inGame', alive_region):
    keyboard.press('w')
    time.sleep(1)
    keyboard.release('w')
    time.sleep(.2)
    activate_window()
    time.sleep(default_delay)
    continue

  if imagefunc(reque, 'Reque Button', reque_region):
    keyboard.press('1')
    keyboard.release('1')
    time.sleep(0.2)
    activate_window()
    time.sleep(default_delay)
    continue

  if (isShip := imagefunc(ship, 'Ship Found', variation=.8)):
    pyautogui.moveTo(isShip)
    keyboard.press(Key.space)
    keyboard.release(Key.space)
    time.sleep(.2)
    activate_window()
    time.sleep(default_delay)
    continue

  activate_window()
  time.sleep(default_delay)

  # Elapsed Time
  elapsed_time = time.time() - start_time
  elapsed_minutes = elapsed_time // 60
  elapsed_seconds = elapsed_time % 60
  console.print(f'Total Time Elapsed: {int(elapsed_minutes)} minutes {int(elapsed_seconds)} seconds', style='light_green')
