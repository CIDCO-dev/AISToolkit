#!/bin/bash

############################################################
# Help                                                     #
############################################################


Help()
{
   # Display Help
   echo "Install script for ais_catcher on a raspberry pi 3."
   echo
   echo "Syntax: install_ais_catcher.sh  [options]"
   echo "options:"
   echo "[help or h]        Print this Help."    
   echo "[ais_ip]           ip address of the Raspberry pi (host)."
   echo "[ais_port]         Port of the Raspberry pi (host)."
   echo "[DB_host]  	    Database Host."
   echo "[DB_user]	    Database user."
   echo "[DB_pswd]          Database password."
   echo "[DB_name]          Database name."
   echo "[dispatcher_ip]    Dispatcher server ip"
   echo "[dispatcher_port]  Dispatcher port "
   echo
   echo "Command line exemple." 
   echo "install_rtl_ais.sh -help"
   echo "install_rtl_ais.sh rtl_ip rtl_port DB_host DB_user DB_pswd DB_name dispatcher_ip dispatcher_port"
   echo "install_rtl_ais.sh '192.168.1.100' '2233' 'cidco.ca' 'ais_usr' 'ais_pswd' 'ais_db' '192.168.1.101' '2233'"
}

if [ -z "$1" ] || [ "$1" = 'h' ] || [ "$1" = '-h' ] || [ "$1" = 'help' ] || [ "$1" = '-help' ]
then
  Help
  exit

else 
  ais_ip=$1
  ais_port=$2
  db_host=$3
  db_usr=$4
  db_pswd=$5
  db_name=$6
  dispatcher_ip=$7
  dispatcher_port=$8

  if [ ! -z "$ais_ip" ] && [ ! -z "$ais_port" ] && [ ! -z "$db_host" ] && [ ! -z "$db_usr" ] && [ ! -z "$db_pswd" ] && [ ! -z "$db_name" ] && [ ! -z "$dispatcher_ip" ] && [ ! -z "$dispatcher_port" ]
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
    sudo apt install -y librtlsdr-dev libusb-dev libpthread-stubs0-dev ncat make pkg-config build-essential cmake | tee -a ~/log.txt
    echo "[+] Cloning AIS-catcher git repository"
    cd /home/ubuntu
    git clone https://github.com/jvde-github/AIS-catcher.git | tee -a ~/log.txt
    cd AIS-catcher
    mkdir build
    cd build
    cmake ..
    echo "[+] Building..."
    make
    sudo make install
    
    echo "[+] Adding service to launch AIS-catcher on boot"
    sudo bash -c 'cat << EOF > /etc/systemd/system/AIS-catcher.service
    [Unit]
    Description=Launch AIS-catcher on boot.
    [Service]
    Type=simple
    ExecStart="/usr/local/bin/AIS-catcher -v -u $ais_ip $ais_port -u $dispatcher_ip $dispatcher_port"
    [Install]
    WantedBy=multi-user.target
    EOF'
    sudo chmod 755 /etc/systemd/system/AIS-catcher.service
    sudo systemctl daemon-reload 
    sudo systemctl enable AIS-catcher
    sudo systemctl start AIS-catcher
    echo "[+] AIS-catcher has started"
    echo "[+] Installing aisdispatcher"
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
	ExecStart=/bin/python3 /home/ubuntu/AISToolkit/to_ais.py $db_host $db_usr $db_pswd $db_name $ais_ip $ais_port 
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

