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

echo "[+] Installing rtl-ais packages..."
sudo apt install -y librtlsdr-dev libusb-dev libpthread-stubs0-dev ncat make pkg-config build-essential | tee -a log.txt

echo "[+] Cloning rtl-ais git repository"
cd /home/ubuntu
git clone https://github.com/dgiardini/rtl-ais | tee -a log.txt
cd /home/ubuntu/rtl-ais

echo "[+] Building..."
make | tee -a log.txt
cd ..

echo "[+] Adding service to launch rtl-ais on boot"
sudo bash -c 'cat << EOF > /etc/systemd/system/rtl-ais.service
[Unit]
Description=Launch rtl-ais on boot.
# After=gpsd.service hwrtc.service pt a changer pour le faire launch apres le service reseau
[Service]
Type=simple
ExecStart=/home/ubuntu/AISToolKit/launch.sh
[Install]
WantedBy=multi-user.target
EOF'

sudo chmod 755 /etc/systemd/system/rtl-ais.service
sudo systemctl daemon-reload 
sudo systemctl enable rtl-ais
sudo systemctl start rtl-ais

echo "[+] Installing aisdispatcher package"

sudo apt-get install -y aha

echo "[+] Installing aisdispatcher"
wget https://www.aishub.net/downloads/aisdispatcher_arm_glibc.tar.gz
tar -xvzf aisdispatcher_arm_glibc.tar.gz
sudo cp aisdispatcher_arm_glibc/aisdispatcher /usr/local/bin
rm -r aisdispatcher_arm_glibc*

echo "[+] Adding service to launch aisdispatcher on boot"
sudo bash -c 'cat << EOF2 > /etc/systemd/system/aisdispatcher.service
 [Unit]
Description=AISdispatcher
After=syslog.target network-online.target

[Service]
Type=simple
User=pi
ExecStart=/usr/local/bin/aisdispatcher -u -h localhost -p 10110 -H localhost:10111 
Restart=always
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target
EOF2'

sudo chmod 755 /etc/systemd/system/aisdispatcher.service
sudo systemctl daemon-reload
sudo systemctl enable aisdispatcher
sudo systemctl start aisdispatcher


