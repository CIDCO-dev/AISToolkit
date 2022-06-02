#!/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Install script for RTL_Dispatcher."
   echo
   echo "Syntax: install_AIS-Dispatcher.sh"
   echo
   echo "Command line exemple."
   echo "install_RTL-Dispatcher.sh -help"
   echo "install_RTL-Dispatcher.sh"
   
}


if [ "$1" = 'h' ] || [ "$1" = '-h' ] || [ "$1" = 'help' ] || [ "$1" = '-help' ]
then
  Help
  exit
else 
  echo "[+] rtl-ais has started"
  echo "[+] Installing aisdispatcher"
  sudo apt-get install -y aha
  cd ~/
  wget https://www.aishub.net/downloads/dispatcher/install_dispatcher
  chmod 755 install_dispatcher
  sudo ./install_dispatcher
  rm install_dispatcher
  exit
fi
