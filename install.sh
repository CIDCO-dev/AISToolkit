#!/bin/sh

#installation script

echo "<*> disable auto-update"
sudo systemctl stop unattended-upgrades

echo "[+] Updating repositories"
sudo apt update | tee log.txt

echo "[+] Updating base system"
sudo apt dist-upgrade -y | tee -a log.txt

echo "[+] Updating applications"
sudo apt upgrade -y | tee -a log.txt

echo "[+] Installing packages..."
sudo apt install -y librtlsdr-dev libusb-dev libpthread-stubs0-dev ncat make pkg-config build-essential | tee -a log.txt

echo "[+] Cloning git repository"
cd /home/ubuntu
git clone https://github.com/dgiardini/rtl-ais | tee -a log.txt
cd /home/ubuntu/rtl-ais

echo "[+] Building..."
make | tee -a log.txt
cd ..
