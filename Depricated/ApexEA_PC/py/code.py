import os
import re
import requests
from configparser import ConfigParser

def read_config(file_path):
  config=ConfigParser()
  config.read(file_path)
  return config

def authenticate(email,password):
  auth_url='https://api.mail.tm/token'
  response=requests.post(auth_url,json={"address":email,"password":password})
  if response.status_code==200:return response.json()['token']
  else:raise Exception(f"Authentication failed: {response.status_code}-{response.text}")

def fetch_unseen_messages(token):
  messages_url='https://api.mail.tm/messages'
  headers={'Authorization':f'Bearer {token}','Accept':'application/json'}
  params={'seen':'false'}
  response=requests.get(messages_url,headers=headers,params=params)
  if response.status_code==200:return response.json()
  else:raise Exception(f"Failed to retrieve messages: {response.status_code}-{response.text}")

def mark_messages_seen(token,message_ids):
  messages_url='https://api.mail.tm/messages'
  headers={'Authorization':f'Bearer {token}','Content-Type':'application/merge-patch+json'}
  for message_id in message_ids:
    patch_url=f'{messages_url}/{message_id}'
    patch_data={'seen':True}
    response=requests.patch(patch_url,headers=headers,json=patch_data)
    if response.status_code==200:print(f"Message {message_id} marked as seen successfully.")
    elif response.status_code==204:print(f"Message {message_id} is already marked as seen.")
    else:print(f"Failed to mark message {message_id} as seen: {response.status_code}-{response.text}")

def extract_code(subject):
  pattern=r'Code is: (\d{6})'
  match=re.search(pattern,subject)
  if match:return match.group(1)
  else:return None

def save_code_to_settings(file_path,code):
  config=ConfigParser()
  config.read(file_path)
  if'Settings'not in config:config['Settings']={}
  config.set('Settings','Code',str(code))
  with open(file_path,'w')as configfile:config.write(configfile)

if __name__=="__main__":
  file_path=os.path.join('..','settings.ini')
  try:
    config=read_config(file_path)
    email=config.get('Settings','email')
    password=config.get('Settings','password')
    token=authenticate(email,password)
    messages=fetch_unseen_messages(token)
    message_ids=[]
    extracted_code='0'
    for message in messages:
      if not message['seen']:
        subject=message['subject']
        code=extract_code(subject)
        if code:extracted_code=code
        message_ids.append(message['id'])
    save_code_to_settings(file_path,extracted_code)
    mark_messages_seen(token,message_ids)
  except Exception as e:print(f"Error: {e}")
