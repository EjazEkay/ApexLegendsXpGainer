import configparser
import funcs
import time
import os

# ____________________________________________________ [ Main Section ] ____________________________________________________

result = funcs.getfunc()

(
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
  isSubmit
) = result

config = configparser.ConfigParser()

config['Results'] = {
  'data': isData,
  'login': isLogin,
  'dataoff': isData_Off,
  'search': isSearch,
  'dob': isDob,
  'cred': isCred,
  'agree': isAgree,
  'code': isCode,
  'tech': isTech,
  'finish': isFinish,
  'addemail': isAddemail,
  'verify': isVerify,
  'verifybtn': isVerifybtn,
  'continue': isContinue,
  'submit': isSubmit
}

file_path = os.path.join('..', 'config.ini')

with open(file_path, 'w') as configfile:
  config.write(configfile)

time.sleep(2)