import configparser
import funcs
import time
import os

# ____________________________________________________ [ Main Section ] ____________________________________________________

result = funcs.getfunc()

(
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
  isCaptcha
  # isEmailback
) = result

config = configparser.ConfigParser()

config['Results'] = {
  'airplane': isPlane,
  'incagnito': isIncog,
  'home': isHome,
  'back': isBack,
  'reload': isReload,
  'mail': isMail,
  'details': isDetail,
  'email': isEmail,
  'date': isDob,
  'credential': isCred,
  'verify': isVerify,
  'agree': isAgree,
  'finish': isFinish,
  'profile': isProfile,
  'technical': isTechissue,
  'ip': isIp,
  'captcha': isCaptcha,
  # 'emailback': isEmailback
}

file_path = os.path.join('..', 'config.ini')

with open(file_path, 'w') as configfile:
  config.write(configfile)

time.sleep(2)