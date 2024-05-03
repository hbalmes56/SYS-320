# write a linux bash script that obtains IOC from the given web page and save it to a file
# called IOC.txt

content=$(curl -s http://10.0.17.5/IOC.html)

ioc=$(echo "$content" | grep -oP '(?<=<td>).*?(?=</td>)' | sed -n '1~2p')

echo "$ioc" > IOC.txt

