
file1="report.txt"
file2="/var/www/html/report.html"

echo "<html><body><table border='1' cellspacing='0' cellpadding='5'>" > $file2

while IFS= read -r line
 do
  echo "<tr><td>$line</td></tr>" >> $file2
 done < "$file1"

echo "</table></body></html>" >> $file2
