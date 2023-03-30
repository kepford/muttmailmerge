#!/bin/sh

files=( "$HOME/.config/mutt/"*"/"* )

PS3='If you have multiple accounts select muttrc file to use, if not enter 0: '
select file in "${files[@]}"; do
    if [[ $REPLY == "0" ]]; then
        echo 'The default muttrc will be used.' >&2
        exit
    elif [[ -z $file ]]; then
        echo 'Invalid choice, try again.' >&2
    else
        echo 'You selected: ' $file
        break
    fi
done
