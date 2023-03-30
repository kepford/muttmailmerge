# Mutt Mail Merge

Send an email to a list of email addresses with neomutt.

## How to use this script:

1. Create a list of email addresses.
2. Create a file with your email message.
3. Add the script to your path or call it directly.
4. Answer the questions and your email will be sent to all the addresses in your email file.

## How does it work

This script basically loops through a list of email addresses and runs a command like this.

`neomutt -s "Subject" jim@example.com -F ~/.config/mutt/accounts/bob\@example.com.muttrc < ~/Desktop/message.txt`
