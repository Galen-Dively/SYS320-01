#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
    logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
    dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
    echo "$dateAndUser"
}

function getFailedLogins(){
    logline=$(cat "$authfile" | grep "Failed password")
    dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,3,9,11)
    echo "$dateAndUser"
}

# Sending logins as email
echo "To: galen.dively@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp galen.dively@mymail.champlain.edu

# Todo - 2: Send failed logins as email
echo "To: galen.dively@mymail.champlain.edu" > failedemailform.txt
echo "Subject: Failed Logins" >> failedemailform.txt
echo "" >> failedemailform.txt
getFailedLogins >> failedemailform.txt
cat failedemailform.txt | ssmtp galen.dively@mymail.champlain.edu
