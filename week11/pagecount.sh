#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function pageCount() {
	accessedPages=$(cat $file | cut -d" " -f7 | grep / | sort | uniq -c) 
}


pageCount

echo "$accessedPages"

