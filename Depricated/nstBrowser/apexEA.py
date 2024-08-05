import pyautogui
import functions as func
import time
import random

# Images Path Address
Data = './images/data.png'
Login = './images/login.png'
Dob = './images/dob.png'
Cred = './images/cred.png'
Accept = './images/accept.png'
Verify = './images/verify.png'
Finish = './images/finish.png'
Error = './images/error.png'

# Variables
huaweiUrl = "http://192.168.8.1/html/home.html"
originUrl = "https://www.ea.com/en-gb/register"
userName = "ihsansultan0123@gmail.com"
userPassword = "rqgt sabb phvp dfjv "

# Flags
isDataFlag = False
isDobFlag = False
isCredFlag = False
isAcceptFlag = False
isVerifyFlag = False
isFinishFlag = False

alert = 0

while True:
  if(func.profile_open()):
    func.activate_win()
  else:
    pyautogui.alert("NstBrowser / No Profiles Left / Profiles.txt File missing Error. Fix & Restart Script to make it work properly")
  time.sleep(2)
  pyautogui.hotkey('ctrl', 't')
  pyautogui.typewrite(huaweiUrl)
  pyautogui.press('enter')

  while True:
    isData = func.imagefunc(Data, "Data Image")
    if isData and not isDataFlag:
      pyautogui.click(isData)
      while True:
        isLogin = func.imagefunc(Login, 'Login Image')
        if isLogin:
          pyautogui.typewrite('admin', interval=.125)
          pyautogui.press('tab')
          pyautogui.typewrite('Milkymagic@0123', interval=.125)
          pyautogui.click(isLogin)
          time.sleep(6)
          pyautogui.click(isData)
          time.sleep(12)
          pyautogui.hotkey('ctrl', 't')
          pyautogui.typewrite(originUrl)
          pyautogui.press('enter')
          isDataFlag = True
          isDobFlag = True
          break

    isDob = func.imagefunc(Dob, "Date of Birth Image")
    if isDob and isDobFlag:
      for _ in range(8):
        pyautogui.press('tab')
        time.sleep(.25)
      for _ in range(7):
        pyautogui.press('down')
        time.sleep(.10)
      pyautogui.press('tab')
      for _ in range(2):
        pyautogui.press('down')
        time.sleep(.10)
      pyautogui.press('tab')
      for _ in range(23):
        pyautogui.press('down')
        time.sleep(.10)
      pyautogui.press('tab')
      pyautogui.press('enter')
      isDobFlag = False
      isCredFlag = True

    isCred = func.imagefunc(Cred, "Credentials Image")
    if isCred and isCredFlag:
      for _ in range(2):
        pyautogui.press('tab')
      email = func.get_email()
      originId = func.get_originId()
      password = "Disneyland@0123"
      print(email, originId, password)
      pyautogui.typewrite(email, interval=.125)
      pyautogui.press('tab')
      pyautogui.typewrite(originId, interval=.25)
      while True:
        isError = func.imagefunc(Error, "Invalid Origin Id Image")
        if not isError:
          break
        else:
          pyautogui.alert('Invalid Origin Id fix issue to continue')
      time.sleep(3)
      pyautogui.press('tab')
      pyautogui.typewrite(password, interval=.125)
      for _ in range(2):
        pyautogui.press('tab')
      pyautogui.press('enter')
      isAcceptFlag = True
      isCredFlag = False

    isAccept = func.imagefunc(Accept, "Accept Image")
    if isAccept and isAcceptFlag:
      pyautogui.click(isAccept)
      for _ in range(3):
        pyautogui.press('tab')
        time.sleep(.25)
      pyautogui.press('enter')
      isVerifyFlag = True
      isAcceptFlag = False

    isVerify = func.imagefunc(Verify, "Verify Image")
    if isVerify and isVerifyFlag:
      while True:
        time.sleep(3)
        code = func.get_code(userName, userPassword)
        if code is not None:
          pyautogui.typewrite(code, interval=.125)
          pyautogui.press('tab')
          pyautogui.press('enter')
          break
        else:
          time.sleep(2)
      isFinishFlag = True
      isVerifyFlag = False

    isFinish = func.imagefunc(Finish, "Finish Image")
    if isFinish and isFinishFlag:
      pyautogui.click(isFinish)
      time.sleep(5)
      pyautogui.hotkey('alt', 'f4')
      func.save_to_excel(email, password, originId)
      # Flag Updation
      isDataFlag = False
      isFinishFlag = False
      break

  alert += 1
  if alert >= 10:
    pyautogui.alert("Alert: 10 Accounts has been created")
    alert = 0
  time.sleep(2)