#!/bin/bash
LOGFILE="/home/champuser/SYS320-01/week15/fileaccesslog.txt"
# Log the access event
echo "File was accessed $(date '+%a %b %d %I:%M:%S %p %Z %Y')" >> "$LOGFILE"
# Email the log contents via ssmtp
{
    echo "To: galen.dively@mymail.champlain.edu"
    echo "From: galen.dively@mymail.champlain.edu"
    echo "Subject: File Access Log"
    echo ""
    cat "$LOGFILE"
} | /usr/sbin/ssmtp galen.dively@mymail.champlain.edu
