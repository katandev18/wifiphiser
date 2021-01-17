#!/bin/bash
python3 logo.py
linux64(){
printf "\033[33m[\033[31m!\033[33m] \033[0mInstalling wifiphiser\n"
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install wget git python3 php curl bash -y > /dev/null
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
rm -rf ngrok-stable-linux-amd64.zip
chmod +x wifiphiser.sh
printf "\033[33m[\033[32m+\033[0m] \033[0mSuccessfully installed.\n"
}

linux32(){
printf "\033[33m[\033[31m!\033[33m] \033[0mInstalling wifiphiser\n"
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get instal wget php curl bash git python3 -y > /dev/null 2>&1
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
rm -rf ngrok-stable-linux-386.zip
chmod +x wifiphiser.sh
printf "\033[0m[\033[32m+\033[0m] Successfully installed.\n"
}

linuxarm(){
printf "\033[33m[\033[31m!\033[0m] \033[0mInstalling wifiphiser\n"
pkg update -y > /dev/null 2>&1
pkg install git python curl wget bash -y > /dev/null 2>&1
arch=$(uname -m | grep 'arm' | head -n1)
arch2=$(uname -m | grep 'Android' | head -n1)
arch3=$(uname -m | grep 'arm64' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]]; then
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
rm -rf ngrok-stable-linux-arm.zip
printf "\033[0m[\033[32m+\033[0m] Successfully installed.\n"
elif [[ $arch3 == *'arm64'* ]]; then
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-arm64.zip > /dev/null 2>&1
rm -rf ngrok-stable-linux-arm64.zip
printf "\033[0m[\033[32m+\033[0m] Successfully installed.\n"
fi
}

if [[ $1 == "linux64" ]]; then
linux64
elif [[ $1 == "linux32" ]]; then
linux32
elif [[ $1 == "linuxarm" ]]; then
linuxarm
else
printf "\n"
printf "\033[0mOS type: \033[32m"; dpkg --print-architecture
printf "\033[0mInstalling arguments:\n"
printf "\n"
printf "\033[0m     linux64       \033[36minstalling for linux64\n"
printf "\033[0m     linux32       \033[36minstalling for linux32\n"
printf "\033[0m     linuxarm      \033[36minstalling for linuxarm\n"
printf "\n"
fi
