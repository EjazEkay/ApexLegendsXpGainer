import configparser
import funcs
import time
import os

# ____________________________________________________ [ Main Section ] ____________________________________________________

result = funcs.getfunc()

(
  isMain,
  isError,
  isEsc,
  isEsc2,
  isReady,
  isType,
  isAlive,
  isAlive2,
  isReque,
  isShip,
  isShip2,
  isContinue,
  isWraith,
  isGibi,
  isMaxlevel
) = result

config = configparser.ConfigParser()

config['Results'] = {
  'main' : isMain,
  'error' : isError,
  'esc' : isEsc,
  'esc2' : isEsc2,
  'ready' : isReady,
  'type' : isType,
  'alive' : isAlive,
  'alive2' : isAlive2,
  'reque' : isReque,
  'ship' : isShip,
  'ship2' : isShip2,
  'continue' : isContinue,
  'wraith' : isWraith,
  'gibi' : isGibi,
  'maxlevel' : isMaxlevel
}

file_path = os.path.join('..', 'config.ini')

with open(file_path, 'w') as configfile:
  config.write(configfile)

time.sleep(2)