import pyautogui
import functions as func
import time

Data = './images/data.png'
Login = './images/login.png'
Dob = './images/dob.png'
Cred = './images/cred.png'
Accept = './images/accept.png'
Verify = './images/verify.png'
Finish = './images/finish.png'

time.sleep(6)

email = func.get_email()
originId = func.get_originId()
password = "Disneyland@0123"

print(email, originId, password)