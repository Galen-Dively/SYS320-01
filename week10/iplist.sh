#!/bin/bash

[ $# -lt 1 ] && echo "Usuage: $0 <Prefix>" && exit 1

prefix=$1



[ ${#prefix} -lt  5 ] && \
printf "prefix length is too short" && \
exit 1

for i in {1..254}
do
	# echo $prefix.$i
	ping -c 1 $prefix.$i | grep "bytes from" | \
	grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}"
done
