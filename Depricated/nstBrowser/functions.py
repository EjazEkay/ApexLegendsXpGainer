import os
import re
import email
import random
import string
import imaplib
import datetime
import requests
import pyautogui
import subprocess
import pandas as pd

def fetch_profile_ids(url):
  # url = "http://localhost:8848/api/agent/profile/list?page=1&pageSize=100&groupId=1f3c25e3-5fdc-4165-95bb-8cf6f0ca613d"
  headers = {
    'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
    'x-api-key': 'f32b6812-2ba8-4b45-bc06-f264b7689332'
  }
  response = requests.get(url, headers=headers)
  data = response.json()
  profile_ids = [item['profileId'] for item in data.get('data', {}).get('docs', [])]

  with open('./data/profiles.txt', 'a') as f:
    for pid in profile_ids:
      f.write(f"{pid}\n")

def profile_open():
  try:
    with open('./data/profiles.txt', 'r+') as f:
      lines = f.readlines()
      if not lines:
        print("No profiles available.")
        return False
      profile_id = lines[0].strip()

      url = f"http://localhost:8848/api/agent/devtool/launch/{profile_id}"
      headers = {
        'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
        'x-api-key': 'f32b6812-2ba8-4b45-bc06-f264b7689332'
      }
      response = requests.get(url, headers=headers)

      if response.status_code == 200:
        f.seek(0)
        f.writelines(lines[1:])
        f.truncate()
        with open('./data/profiles_used.txt', 'a') as used_file:
          used_file.write(f"{profile_id}\n")
        return True
      else:
        print(f"Failed to open profile {profile_id}: {response.status_code}")
        return False
      
  except Exception as e:
    print(f"An error occurred: {e}")
    return False

def activate_win():
  winSwap = r'./ahk/winActivate.exe'
  subprocess.run([winSwap], check=True)

def imagefunc(img, name="", variation=0.95):
  try:
    image = pyautogui.locateCenterOnScreen(img, confidence=variation)

    if image:
      print(f"Image: {name} - Found At: {image}")
      return image
      
  except pyautogui.ImageNotFoundException:
    return 0

def get_email():
  if not os.path.exists('./data/emails.txt'):
    print("emails.txt does not exist.")
    return None

  with open('./data/emails.txt', 'r') as f:
    lines = f.readlines()
  
  if not lines:
    print("No emails available.")
    return None
  
  email = lines[0].strip()

  with open('./data/emails.txt', 'w') as f:
    f.writelines(lines[1:])
  
  with open('./data/emails_used.txt', 'a') as f:
    f.write(f"{email}\n")

  return email

def get_originId():
  letters_length = random.randint(7, 8)
  letters = ''.join(random.choices(string.ascii_lowercase, k=letters_length))
  digits = ''.join(random.choices(string.digits, k=2))
  origin_id = letters + digits
  return origin_id

def extract_code(subject):
  pattern = r'Code is: (\d{6})'
  match = re.search(pattern, subject)
  return match.group(1) if match else None

def get_code(username, password):
  imap = imaplib.IMAP4_SSL("imap.gmail.com")
  imap.login(username, password)
  imap.select("INBOX")

  status, data = imap.search(None, "UNSEEN")
  latest_email_id = data[0].split()[-1] if data[0] else None

  code = None
  if latest_email_id:
    status, data = imap.fetch(latest_email_id, "(RFC822)")
    raw_email = data[0][1]
    email_message = email.message_from_bytes(raw_email)
    subject = email_message["Subject"]

    code = extract_code(subject)

  imap.close()
  imap.logout()

  return code

def fetch_ip():
  response = requests.get("https://ipinfo.io/json")
  data = response.json()
  return data.get("ip", "Unknown IP")

def save_to_excel(email, password, originId):
  ip = fetch_ip()
  data = [email, password, originId, ip, datetime.datetime.now()]
  file_name = './data/details.xlsx'

  try:
    df = pd.read_excel(file_name)
    df.loc[len(df)] = data
    df.to_excel(file_name, index=False)
  except FileNotFoundError:
    df = pd.DataFrame([data], columns=['email', 'password', 'originId', 'IP', 'date of creation'])
    df.to_excel(file_name, index=False)
    