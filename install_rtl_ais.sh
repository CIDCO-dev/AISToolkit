#!/bin/bash

############################################################
# Help                                                     #
############################################################


Help()
{
   # Display Help
   echo "Install script for rtl-ais on a raspberry pi 3."
   echo
   echo "Syntax: install_rtl_ais.sh  [options]"
   echo "options:"
   echo "[help or h]      Print this Help."    
   echo "[rtl_ip]         ip address of the Raspberry pi (host)."
   echo "[rtl_port]       Port of the Raspberry pi (host)."
   echo "[DB_host]  	  Database Host."
   echo "[DB_user]	  Database user."
   echo "[DB_pswd]        Database password."
   echo "[DB_name]        Database name."
   echo
   echo "Command line exemple." 
   echo "install_rtl_ais.sh -help"
   echo "install_rtl_ais.sh rtl_ip rtl_port DB_host DB_user DB_pswd DB_name"
   echo "install_rtl_ais.sh '192.168.1.100' '10110' 'cidco.ca' 'ais_usr' 'ais_pswd' 'ais_db'"
}

if [ -z "$1" ] || [ "$1" = 'h' ] || [ "$1" = '-h' ] || [ "$1" = 'help' ] || [ "$1" = '-help' ]
then
  Help
  exit
else 
  rtl_ip=$1
  rtl_port=$2
  db_host=$3
  db_usr=$4
  db_pswd=$5
  db_name=$6
  if [ ! -z "$rtl_ip" ] && [ ! -z "$rtl_port" ] && [ ! -z "$db_host" ] && [ ! -z "$db_usr" ] && [ ! -z "$db_pswd" ] && [ ! -z "$db_name" ]
  then
    echo "<*> disable auto-update"
    sudo systemctl stop unattended-upgrades
    echo "[+] Updating repositories"
    sudo apt update | tee ~/log.txt
    echo "[+] Updating base system"
    sudo apt dist-upgrade -y | tee -a ~/log.txt
    echo "[+] Updating applications"
    sudo apt upgrade -y | tee -a ~/log.txt
    echo "[+] Installing rtl-ais packages..."
    sudo apt install -y librtlsdr-dev libusb-dev libpthread-stubs0-dev ncat make pkg-config build-essential | tee -a ~/log.txt
    
    echo "[+] Downloading rtl-ais"
    cd ~/
    git clone https://github.com/dgiardini/rtl-ais | tee -a ~/log.txt
    cd rtl-ais/
    make | tee -a log.txt
    cd ~/
    
    echo "[+] Adding service to launch rtl-ais on boot"
    sudo bash -c 'cat << EOF > /etc/systemd/system/rtl-ais.service
	[Unit]
	Description=Launch rtl-ais on boot.
	Before=networking.service
	[Service]
	Type=simple
	ExecStart=/home/ubuntu/rtl-ais/rtl_ais -n -T -h $rtl_ip -p $rtl_port 
	[Install]
	WantedBy=multi-user.target
	EOF'
    sudo chmod 755 /etc/systemd/system/rtl-ais.service
    sudo systemctl daemon-reload 
    sudo systemctl enable rtl-ais
    sudo systemctl start rtl-ais
    echo "[+] rtl-ais has started"
    
    echo "[+] Installing pyais packages"
    sudo apt-get install -y python3-pip 
    sudo pip3 install pyais mysql-connector-python shapely
    
    echo "[+] Adding service to launch python script to collect ais data on boot"
    sudo bash -c 'cat << EOF2 > /etc/systemd/system/pythonscript.service
	[Unit]
	Description=PythonScript
	Before=rtl-ais.service
	[Service]
	Type=simple
	ExecStart=/bin/python3 /home/ubuntu/AISToolkit/to_ais.py $db_host $db_usr $db_pswd $db_name $rtl_ip $rtl_port
	[Install]
	WantedBy=multi-user.target
	EOF2'
    sudo chmod 755 /etc/systemd/system/pythonscript.service
    sudo systemctl daemon-reload
    sudo systemctl enable pythonscript
    sudo systemctl start pythonscript
    echo "[+] pythonscript has started"
    echo "[+] INITIALIZATION COMPLETE !"        
    exit
else 
    Help
    exit
  fi
fi

