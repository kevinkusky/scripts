import imaplib
import email
from email.utils import parsedate_to_datetime
from datetime import datetime, timedelta

def clean_email():
    # First connect to email address
    mail = imaplib.IMAP4_SSL("imap.gmail.com")
    mail.login("", "")

    # Select
    mail.select('inbox')

    result, data = mail.search(None, "ALL")
    email_ids = data[0].split()

    approved_senders = [
        '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '',
    ]
    now = datetime.now()

    for id in email_ids:
        r, d = mail.fetch(id, "(RFC822)")
        raw_email = d[0][1].decode("utf-8")
        message = email.message_from_string(raw_email)
        e_date = parsedate_to_datetime(message["Date"])
        if (now - e_date) and (message["From"] not in approved_senders):
            pass

    mail.expunge()
    mail.close()
    mail.logout()

if __name__ == "__main__":
    clean_email()
    