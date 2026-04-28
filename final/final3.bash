#!/bin/bash

report="report.txt"
output="/var/www/html/report.html"

echo "<html><body><table border='1'>" > "$output"
echo "<tr><th>IP</th><th>Date/Time</th><th>Page</th></tr>" >> "$output"

while read -r ip datetime page; do
    echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>" >> "$output"
done < "$report"

echo "</table></body></html>" >> "$output"

echo "Report available at http://localhost/report.html"
