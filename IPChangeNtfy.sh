#!/bin/bash

# Script to check if the public IP has changed, and send a push notification if
# if has using ntfy.sh. 

# To use, edit line 21 and put your topic ID after ntfy.sh/ then
# run this script every few minutes with cron.

# Requires write access to local directory to save current IP, change lines 
# 13 & 22 if you want to save elsewhere.

# Read in whatever the saved IP is from ./PubIP
OLD="$(cat PubIP)"

# Check for the current IP using icanhazip.com
CUR="$(curl icanhazip.com)"

# Compare them, if not equal, send the push notification and update ./PubIP
if [ "$CUR" != "$OLD" ]; then
        NTFY="$(hostname -f) says her old public IP was $OLD and her new one is $CUR"
        curl -s -H "Title: IP Change" -d "$NTFY" ntfy.sh/PUT-YOUR-TOPIC-ID-HERE > /dev/null
        echo "$CUR" > PubIP
fi
