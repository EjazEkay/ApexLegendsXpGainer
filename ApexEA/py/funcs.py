import pyautogui
from termcolor import colored

# Images Path Address
Plane = "./images/plane.png"
Incog = "./images/incog.png"
Home = "./images/home.png"
Back = "./images/back.png"
Reload = "./images/reload.png"
Ip = "./images/ip.png"

Mail = "./images/mail.png"
Details = "./images/details.png"
Email = "./images/email.png"

Dob = "./images/dob.png"
Cred = "./images/cred.png"
Verify = "./images/verify.png"
Agree = "./images/agree.png"
Finish = "./images/finish.png"
Profile = "./images/profile.png"
Techissue = "./images/techissue.png"
Captcha = "./images/captcha.png"
# Emailback = "./images/emailback.png"

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
  isPlane = imagefunc(Plane, 'AirPlane')
  isIncog = imagefunc(Incog, 'Incagnito')

  isHome = imagefunc(Home, 'Home')
  isBack = imagefunc(Back, 'Back')
  isReload = imagefunc(Reload, 'Relaod')
  isIp = imagefunc(Ip, 'IpAddress')

  isMail = imagefunc(Mail, 'MailTM')
  isDetail = imagefunc(Details, 'Details')
  isEmail = imagefunc(Email, 'Email', variation=0.9)

  isDob = imagefunc(Dob, 'DateofBirth')
  isCred = imagefunc(Cred, 'Credentials')
  isVerify = imagefunc(Verify, 'Verify', variation=0.9)
  isAgree = imagefunc(Agree, 'Agree')
  isFinish = imagefunc(Finish, 'Finish')
  isProfile = imagefunc(Profile, 'Profile')
  isTechissue = imagefunc(Techissue, 'Techissue')
  isCaptcha = imagefunc(Captcha, 'Techissue')
  # isEmailback = imagefunc(Emailback, 'Emailback')

  return (
    isPlane,
    isIncog,
    isHome,
    isBack,
    isReload,
    isMail,
    isDetail,
    isEmail,
    isDob,
    isCred,
    isVerify,
    isAgree,
    isFinish,
    isProfile,
    isTechissue,
    isIp,
    isCaptcha,
    # isEmailback
  )

# ____________________________________________________ Functions Seperator ____________________________________________________
