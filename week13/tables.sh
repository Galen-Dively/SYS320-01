#!/bin/bash

url="http://10.0.17.6/Assignment.html"
raw_html=$(curl -s "$url")

temperature_rows=$(xmlstarlet format --html --recover 2>/dev/null <<< "$raw_html" | xmlstarlet sel -T -t \
	-m "(//table)[1]//tr[position()>1]" \
	-v "normalize-space(td[1])" -o "|" \
	-v "normalize-space(td[2])" -n)

pressure_rows=$(xmlstarlet format --html --recover 2>/dev/null <<< "$raw_html" | xmlstarlet sel -T -t \
	-m "(//table)[2]//tr[position()>1]" \
	-v "normalize-space(td[1])" -o "|" \
	-v "normalize-space(td[2])" -n)

paste <(echo "$pressure_rows") <(echo "$temperature_rows") | awk -F'\t' '
{
	split($1, pressure, /\|/)
	split($2, temperature, /\|/)
	print pressure[1], temperature[1], temperature[2]
}
