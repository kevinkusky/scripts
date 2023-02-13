import os
import time
import imaplib
import email

def clean_email():
    # Connect to the Gmail IMAP server, sign in and select inbox
    mail = imaplib.IMAP4_SSL("imap.gmail.com")
    mail.login(<your_gmail_address>, <your_gmail_password>)
    mail.select("inbox")

    # Create list of email IDs from all emails older than 30 days
    result, data = mail.search(None, '(BEFORE 7-Jan-2023)')
    email_ids = data[0].split()

    # Keep a list of senders whose emails you want to keep
    approved_senders = [
        'nadiadigregorio11@gmail.com', 'joekarlsson@substack.com', 'rw@peterc.org', 'kevinkusky@gmail.com',
        'james@nexhealth.com', 'locomotionnewyork@gmail.com', 'appacademy.io', 'coursera.org', 'heroku.com',
    ]

    # Iterate over all email IDs
    for email_id in email_ids:
        # Fetch the email message
        result, data = mail.fetch(email_id, "(RFC822)")
        email_message = email.message_from_bytes(data[0][1])

        # Check if the email is from an approved sender
        keep_email = False
        for sender in approved_senders:
            if sender in email_message["From"]:
                keep_email = True
                break

        # If the email is not from an approved sender, delete it
        if not keep_email:
            mail.store(email_id, "+FLAGS", "\\Deleted")

    # Close and logout of the Gmail account
    mail.close()
    mail.logout()

if __name__ == "__main__":
    clean_email()
