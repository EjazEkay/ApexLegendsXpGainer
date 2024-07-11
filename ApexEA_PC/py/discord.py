import requests
import os

webhookUrl = "https://discord.com/api/webhooks/1258986608711962685/S5xGk84f__B9NVHEeYaP779XCc-wgsOLFv4jPm7dek33kGH1Mwa9RTK43fwoTrEfVqts"
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