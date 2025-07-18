#!/bin/sh
# Send an email to a list of email addresses with neomutt.
#
# How to use this script:
#
# 1. Create a list of email addresses.
# 2. Create a file with your email message.
# 3. Add the script to your path or call it directly.
# 4. Answer the questions and your email will be sent to all the addresses in your email file.
#
# This script basically loops through a list of email addresses and runs a
# command like this
# neomutt -s "Subject" jim@example.com -F ~/.config/mutt/accounts/bob\@example.com.muttrc < ~/Desktop/message.txt

files=( "$HOME/.config/mutt/"*"/"* )
MUTTRC=NULL

PS3='If you have multiple accounts select muttrc file to use, if not enter 0: '
select file in "${files[@]}"; do
    if [[ $REPLY == "0" ]]; then
        echo 'The default muttrc will be used.' >&2
        exit
    elif [[ -z $file ]]; then
        echo 'Invalid choice, try again.' >&2
    else
        echo 'You selected: ' $file
        MUTTRC=$file
        break
    fi
done

read -ep 'Please enter a subject line: ' SUBJECT
read -ep 'Please enter the path to the message file: ' MESSAGE
read -ep 'Please enter the path to the emails file: ' EMAIL_FILE
EMAILS=$(cat $EMAIL_FILE)
echo
echo "The following message will be sent"
echo
echo "Subject: $SUBJECT"
echo "Message:"
echo $(cat $MESSAGE)
echo
echo "Using muttrc file: $MUTTRC"
echo
echo "These email addresses will be emailed:"
echo "$EMAILS"
echo
read -p "Are you sure you want to send these messages? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  for EMAIL in $EMAILS
  do
    neomutt -n -e "source '$MUTTRC'" -d 2 -s "Test" -- "$EMAIL" < "$MESSAGE"
    echo "Sent email to: $EMAIL" "using muttrc file: $MUTTRC"
  done
fi
