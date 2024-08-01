import requests
import os

webhookUrl = "https://discord.com/api/webhooks/1259557473891913778/yRpa6KmItdG-tPr7wprC-SJCKVKehF4wjOyJb369zmk5CU12RZ4HMcQZMtDgMfY0Jslo"
file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../data/discord.txt'))

with open(file_path, 'r') as file:
    content = file.read()

message = content.replace('\\n', '\n')

def post_to_discord(message, url):
  payload = {"content": message}
  headers = {"Content-Type": "application/json"}
    
  try:
    response = requests.post(url, json=payload, headers=headers)
        
    if response.status_code != 204:
      raise Exception(f"Error: Unexpected error, Status code: {response.status_code}")
    
  except Exception as error:
    print(f"Error sending message to Discord:\n{error}")

post_to_discord(message, webhookUrl)