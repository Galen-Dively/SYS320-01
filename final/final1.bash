#!/bin/bash

curl -s http://10.0.17.6/IOC.html | grep -oP '(?<=<td>)[^<]+' | awk 'NR%2==1' > IOC.txt
cat IOC.txt
