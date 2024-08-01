import requests
import configparser
import os
import json
import random
import string

def fetch_domains():
  url = "https://api.mail.tm/domains"
  response = requests.get(url)
    
  if response.status_code == 200:
    data = response.json()
    return [domain['domain'] for domain in data['hydra:member']]
  else:
    print(f"Error fetching domains: {response.status_code}")
    return []

def generate_random_email(domain):
  username = ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
  return f"{username}@{domain}"

def create_mail_tm_account(email, password):
  url = "https://api.mail.tm/accounts"
  payload = json.dumps({
    "address": email,
    "password": password
  })
  headers = {
    'Content-Type': 'application/json'
  }
    
  response = requests.post(url, headers=headers, data=payload)
    
  if response.status_code == 201:
    return response.json()
  else:
    print(f"Error: {response.status_code}")
    return None

def save_to_settings(email, password):
  config = configparser.ConfigParser()
  file_path = os.path.join('..', 'settings.ini')

  if os.path.exists(file_path):
    config.read(file_path)
    
  if 'Settings' not in config.sections():
    config.add_section('Settings')
    
  config['Settings']['email'] = email
  config['Settings']['password'] = password

  with open(file_path, 'w') as configfile:
    config.write(configfile)

# Main script
password = "Milkymagic@0123"

domains = fetch_domains()
if domains:
  email = generate_random_email(random.choice(domains))
  account_info = create_mail_tm_account(email, password)

  if account_info:
    save_to_settings(email, password)
    print(f"Account created successfully! Email: {email}, Password: {password}")
  else:
    save_to_settings('0', '0')
    print("Failed to create account.")
else:
  save_to_settings('0', '0')
  print("No domains available.")
