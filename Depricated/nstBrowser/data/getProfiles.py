import requests

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


groupId = 'f8591ad5-8417-4409-9aea-d3e40db4c94d'
url = f'http://localhost:8848/api/agent/profile/list?page=1&pageSize=100&groupId={groupId}'
fetch_profile_ids(url)
