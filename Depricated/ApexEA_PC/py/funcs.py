import pyautogui

# Images Path Address
Data = "./images/data.png"
Login = "./images/login.png"
Data_Off = "./images/data_off.png"
Search = "./images/search.png"
Dob = "./images/dob.png"
Cred = "./images/cred.png"
Agree = "./images/agree.png"
Code = "./images/code.png"
Tech = "./images/tech.png"
Finish = "./images/finish.png"

Addemail = "./images/addemail.png"
Verify = "./images/verify.png"
Verifybtn = "./images/verifybtn.png"
Continue = "./images/continue.png"
Submit = "./images/submit.png"

Captcha = "./images/captcha.png"
Create = "./images/create.png"


# ____________________________________________________ Functions Seperator ____________________________________________________


def imagefunc(img, name="", variation=0.99):
  try:
    image = pyautogui.locateCenterOnScreen(img, confidence=variation)

    if image:
      print(f"Image: {name} - Found At: {image}")
      return image
      
  except pyautogui.ImageNotFoundException:
    return 0


# ____________________________________________________ Functions Seperator ____________________________________________________


def getfunc():
  # Images Variables
  isData = imagefunc(Data, "Data Enabled")
  isLogin = imagefunc(Login, "Data Login")
  isData_Off = imagefunc(Data_Off, "Data Disabled")
  isSearch = imagefunc(Search, "Sandbox Search")
  isDob = imagefunc(Dob, "EA Date of Birth")
  isCred = imagefunc(Cred, "EA Credentials")
  isAgree = imagefunc(Agree, "EA I Agree Page")
  isCode = imagefunc(Code, "EA Code Page")
  isTech = imagefunc(Tech, "EA Technical Issue")
  isFinish = imagefunc(Finish, "EA Finish Step")

  isAddemail = imagefunc(Addemail, "EA Secondary Email")
  isVerify = imagefunc(Verify, "Verify Current Email")
  isVerifybtn = imagefunc(Verifybtn, "Verify Now")
  isContinue = imagefunc(Continue, "Continue This Gmail Address")
  isSubmit = imagefunc(Submit, "Submit Code")

  isCaptcha = imagefunc(Captcha, "Captcha Found")
  isCreate = imagefunc(Create, "Create Img Found")

  return (
    isData,
    isLogin,
    isData_Off,
    isSearch,
    isDob,
    isCred,
    isAgree,
    isCode,
    isTech,
    isFinish,
    isAddemail,
    isVerify,
    isVerifybtn,
    isContinue,
    isSubmit,
    isCaptcha,
    isCreate
  )

# ____________________________________________________ Functions Seperator ____________________________________________________
