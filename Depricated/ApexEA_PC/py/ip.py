import requests
import configparser
import os

try:
  ip = requests.get('https://api.ipify.org').text
except requests.RequestException:
  ip = "0" 

config = configparser.ConfigParser()

file_path = os.path.join('..', 'settings.ini')

if os.path.exists(file_path):
  config.read(file_path)

config['Settings']['IP'] = ip
    
with open(file_path, 'w') as configfile:
  config.write(configfile)
