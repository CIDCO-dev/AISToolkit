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
ExecStart=/home/ubuntu/AISToolkit/launch.sh
[Install]
WantedBy=multi-user.target
EOF'

sudo chmod 755 /etc/systemd/system/rtl-ais.service
sudo systemctl daemon-reload 
sudo systemctl enable rtl-ais
sudo systemctl start rtl-ais

echo "[+] rtl-ais has started"
echo "[+] Installing aisdispatcher"

sudo apt-get install -y aha
cd /home/ubuntu
wget https://www.aishub.net/downloads/dispatcher/install_dispatcher
chmod 755 install_dispatcher
sudo ./install_dispatcher

#echo "[+] Adding service to launch aisdispatcher on boot"
#sudo bash -c 'cat << EOF2 > /etc/systemd/system/aisdispatcher.service
#[Unit]
#Description=aisdispatcher
#After=rtl-ais.service syslog.target network-online.target
#[Service]
#Type=simple
#ExecStart=/home/ais/bin/aisdispatcher -u -h localhost -p 10110 -H localhost:10111 
#[Install]
#WantedBy=multi-user.target
#EOF2'
#.

sudo chmod 755 /etc/systemd/system/aisdispatcher.service
sudo systemctl daemon-reload
sudo systemctl enable aisdispatcher
sudo systemctl start aisdispatcher
echo "[+] aisdispatcher has started" 
echo "[+] Installing pyais packages"

sudo apt-get install -y python3-pip 
sudo pip3 install pyais




