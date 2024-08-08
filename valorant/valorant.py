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
  print("########################################")
  print("#          Valorant Xp Gainer          #")
  print("#              Larry2018               #")
  print("########################################")
print_intro()

# ____________________________________________________ Images Paths ____________________________________________________

# Variables / Flags
default_delay = 1
before_swap_delay = .25

# ... Images ...
image_path = './images'

# ... Main Menu ...
play = f'{image_path}/play.png'
play_region = (50, 222, 245, 330)
start = f'{image_path}/start.png'
start_region = (770, 940, 1080, 1020)
alive = f'{image_path}/alive.png'
alive_region = (1280, 1000, 1380, 1050)
reque = f'{image_path}/reque.png'
reque_region = (770, 940, 1060, 1040)

# ... Others ...
maxlevel = f'{image_path}/maxlevel.png'
understand = f'{image_path}/understand.png'

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
  if (imagefunc(alive, 'ALIVE', alive_region, .65)):
    keyboard.press('w')
    time.sleep(1)
    keyboard.release('w')
    time.sleep(before_swap_delay)
    activate_window()
    time.sleep(default_delay)
    continue

  if not (imagefunc(maxlevel, 'MAXLEVEL', variation = .98)):
    if (isReque := imagefunc(reque, 'REQUE', reque_region)):
      pyautogui.moveTo(isReque)
      pyautogui.click()
      time.sleep(before_swap_delay)
      activate_window()
      time.sleep(default_delay)
      continue
    elif (isStart := imagefunc(start, 'START', start_region)):
      pyautogui.moveTo(900, 80)
      pyautogui.click()
      time.sleep(.125)
      pyautogui.moveTo(isStart)
      pyautogui.click()
      time.sleep(before_swap_delay)
      activate_window()
      time.sleep(default_delay)
      continue

  if (isPlay := imagefunc(play, 'PLAY', play_region, .85)):
    pyautogui.moveTo(isPlay)
    pyautogui.click()
    time.sleep(default_delay)
  elif (isUnderstand := imagefunc(understand, 'UNDERSTAND')):
    pyautogui.moveTo(isUnderstand)
    pyautogui.click()
    time.sleep(default_delay)

  activate_window()
  time.sleep(default_delay)

  # Elapsed Time
  elapsed_time = time.time() - start_time
  elapsed_minutes = elapsed_time // 60
  elapsed_seconds = elapsed_time % 60
  console.print(f'Total Time Elapsed: {int(elapsed_minutes)} minutes {int(elapsed_seconds)} seconds', style='light_green')