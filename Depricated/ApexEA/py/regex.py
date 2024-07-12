import re

def extractEmail(text):
  match = re.search(r'(?<=in as:)[\s\S]*?(?=password:)', text, re.IGNORECASE)
  if match:
    email = re.search(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', match.group(0))
    return email.group(0) if email else 0
  return 0

def extractPassword(text):
  match = re.search(r'(?<=password:)[\s\S]*?(?=Create an)', text, re.IGNORECASE)
  if match:
    password = match.group(0).strip()
    return password if password else 0
  return 0

def extractCode(text):
  match = re.search(r'Code is:\s*(\d{6})', text, re.IGNORECASE)
  if match:
    return match.group(1)
  return 0

def extractIp(text):
  ipv4_match = re.findall(r'\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b', text)
  return ipv4_match if ipv4_match else 0
