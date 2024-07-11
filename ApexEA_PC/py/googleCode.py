import imaplib
import email
import re
import configparser
import os

def extract_code(subject):
    pattern = r'Code is: (\d{6})'
    match = re.search(pattern, subject)
    return match.group(1) if match else None

username = "ihsansultan0123@gmail.com"
password = "rqgt sabb phvp dfjv "

imap = imaplib.IMAP4_SSL("imap.gmail.com")
imap.login(username, password)
imap.select("INBOX")

status, data = imap.search(None, "UNSEEN")
latest_email_id = data[0].split()[-1] if data[0] else None

if latest_email_id:
    status, data = imap.fetch(latest_email_id, "(RFC822)")
    raw_email = data[0][1]
    email_message = email.message_from_bytes(raw_email)
    subject = email_message["Subject"]

    extracted_code = extract_code(subject)
    config = configparser.ConfigParser()
    file_path = os.path.join('..', 'settings.ini')

    if os.path.exists(file_path):
        config.read(file_path)

    config['Settings']['gmailCode'] = extracted_code if extracted_code else '0'

    with open(file_path, 'w') as configfile:
        config.write(configfile)

imap.close()
imap.logout()
