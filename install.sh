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

echo "[+] Adding rtl-ais on boot"
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
sudo systemctl enable rtl-ais
echo "sudo systemctl start rtl-ais"
