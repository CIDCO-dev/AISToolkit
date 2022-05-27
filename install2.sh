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
sudo apt install -y librtlsdr-dev libusb-dev libpthread-stubs0-dev ncat make pkg-config build-essential cmake | tee -a log.txt

echo "[+] Cloning AIS-catcher git repository"
cd /home/ubuntu
git clone https://github.com/jvde-github/AIS-catcher.git | tee -a log.txt
cd AIS-catcher
mkdir build
cd build
cmake ..

echo "[+] Building..."
make
sudo make install


#echo "[+] Adding service to launch rtl-ais on boot"
#sudo bash -c 'cat << EOF > /etc/systemd/system/rtl-ais.service
#[Unit]
#Description=Launch rtl-ais on boot.
# After=gpsd.service hwrtc.service pt a changer pour le faire launch apres le service reseau
#[Service]
#Type=simple
#ExecStart=/home/ubuntu/AISToolkit/launch.sh
#[Install]
#WantedBy=multi-user.target
#EOF'

#sudo chmod 755 /etc/systemd/system/rtl-ais.service
#sudo systemctl daemon-reload 
#sudo systemctl enable rtl-ais
#sudo systemctl start rtl-ais

echo "[+] Adding service to launch AIS-catcher on boot"
sudo bash -c 'cat << EOF > /etc/systemd/system/AIS-catcher.service
[Unit]
Description=Launch AIS-catcher on boot.
[Service]
Type=simple
ExecStart="/usr/local/bin/AIS-catcher -v -u 127.0.0.1 10110"
[Install]

WantedBy=multi-user.target
EOF'
sudo chmod 755 /etc/systemd/system/AIS-catcher.service
sudo systemctl daemon-reload 
sudo systemctl enable AIS-catcher
sudo systemctl start AIS-catcher

echo "[+] AIS-catcher has started"
echo "[+] Installing aisdispatcher"

sudo apt-get install -y aha
cd /home/ubuntu
wget https://www.aishub.net/downloads/dispatcher/install_dispatcher
chmod 755 install_dispatcher
sudo ./install_dispatcher

echo "[+] Adding service to launch aisdispatcher on boot"
sudo bash -c 'cat << EOF2 > /etc/systemd/system/aisdispatcher.service
[Unit]
Description=aisdispatcher
After=AIS-catcher.service
[Service]
Type=simple
ExecStart="/home/ais/bin/aisdispatcher_armv8_a72 -m udp-server -d 144.76.105.244:2328 -h 127.0.0.1 -p 10110 -s 192.168.1.177" 
[Install]
WantedBy=multi-user.target
EOF2'


sudo chmod 755 /etc/systemd/system/aisdispatcher.service
sudo systemctl daemon-reload
sudo systemctl enable aisdispatcher
sudo systemctl start aisdispatcher
echo "[+] aisdispatcher has started" 

echo "[+] Installing pyais packages"
sudo apt-get install -y python3-pip 
sudo pip3 install pyais mysql-connector-python shapely

echo "[+] Adding service to launch python script to collect ais data on boot"
sudo bash -c 'cat << EOF3 > /etc/systemd/system/pythonscript.service
[Unit]
Description=PythonScript
After=aisdispatcher.service
[Service]
Type=simple
ExecStart="/home/ubuntu/AISToolkit python3 to_ais.py cidco.ca aisuser AisOuananiche314151! ais 127.0.0.1 10110" 
[Install]
WantedBy=multi-user.target
EOF3'

sudo chmod 755 /etc/systemd/system/pythonscript.service
sudo systemctl daemon-reload
sudo systemctl enable pythonscript
sudo systemctl start pythonscript

echo "[+] pythonscript has started" 
echo "[+] INITIALIZATION COMPLETE !"

