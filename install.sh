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
sudo apt install -y librtlsdr-dev libusb-dev libpthread-stubs0-dev ncat

echo "[+] Cloning git repository"
git clone https://github.com/dgiardini/rtl-ais

cd home/Ubuntu/rtl-ais
make

