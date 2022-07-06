
"""
# Copyright 2019 © Centre Interdisciplinaire de développement en Cartographie des Océans (CIDCO), Tous droits réservés

@Dominic_Gonthier

"""
import pyais
from pyais import decode
import socket
import mysql.connector
from shapely import geometry
from datetime import datetime
import time
from pyais import FileReaderStream
from pyais.stream import UDPReceiver
import sys
import os

"""
Fonction a utiliser directement avec du code
Par exemple, message= b"!AIVDM,2,1,0,B,54eGOWP00000<Hg?3?8<pn0EHtiE@Ttr2222220i20K655IAe3lRCCmD,0*6F"
"""
def decoder (message):
    decoded = decode(*message)
    to_DB(decoded)

"""
Fonction a utiliser avec un message décodé
La fonction extrait chaque valeur du message et la pousse dans la base de données sélectionné précédemment.
"""
def to_DB(arg_host, arg_user, arg_password, arg_database,msg_decode):
    db = mysql.connector.connect(
        host=arg_host,
        user=arg_user,
        password=arg_password,
        database=arg_database
    )
    cursor = db.cursor()
    table = """
        CREATE TABLE IF NOT EXISTS `raw_data` (
        `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
        `timestamp` datetime  NOT NULL,
        `msg_type` int ,`on_repeat` int ,`mmsi` int NOT NULL,`ais_version` int ,`imo` int  ,`callsign` varchar(30)   ,`shipname` varchar(50)   ,`ship_type` int  ,`to_bow` int   ,
        `to_stern` int  ,`to_port` int  ,`to_starboard` int ,`epfd` int ,`month` int ,`day` int  ,`hour` int  ,`minute` int  ,`draught` float ,`destination` varchar(50) ,
        `dte` int  ,`ship_status` varchar(30), `turn` int,`speed` float,`accuracy` int(1),`longitude` double ,`latitude` double ,`course` float,`heading` int,`sec` int,  
        `maneuver` int,  `spare_1` varchar(30),`raim` int(1),`radio` int
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT ='';
        """
    cursor.execute(table)
    data = msg_decode.asdict()
    timestamp=datetime.fromtimestamp(time.time())
    data["reçu_a"]=timestamp

    for key, value in data.items():
        if value == False:
            data[key] = 0
        if value == True:
            data[key] = 1

    try:
        st=str(data['status'])

        if st.find("UnderWayUsingEngine")!=-1 or st.find("0")!=-1:
            ship_status="UnderWayUsingEngine"
        if st.find("AtAnchor") != -1 or st.find("1") != -1:
            ship_status = "AtAnchor"
        if st.find("NotUnderCommand") != -1 or st.find("2") != -1:
            ship_status = "NotUnderCommand"
        if st.find("RestrictedManoeuverability") != -1 or st.find("3") != -1:
            ship_status = "RestrictedManoeuverability"
        if st.find("ConstrainedByHerDraught") != -1 or st.find("4") != -1:
            ship_status = "ConstrainedByHerDraught"
        if st.find("Moored") != -1 or st.find("5") != -1:
            ship_status = "Moored"
        if st.find("Aground") != -1 or st.find("6") != -1:
            ship_status = "Aground"
        if st.find("EngagedInFishing") != -1 or st.find("7") != -1:
            ship_status = "EngagedInFishing"
        if st.find("UnderWaySailing") != -1 or st.find("8") != -1:
            ship_status = "UnderWaySailing"
        if st.find("AISSARTActive") != -1 or st.find("14") != -1:
            ship_status = "AISSARTActive"
        if st.find("Undefined") != -1 or st.find("15") != -1:
            ship_status = "Undefined"
    except:
        ship_status=""
    try:
        on_repeat=data['repeat']
    except:
        on_repeat = None
    try:
        data['sec']=data['second']
    except:
        pass
    try:
        reçu_a= data['reçu_a']
    except:
        reçu_a= None
    try:
        msg_type= data['msg_type']
    except:
        msg_type= None
    try:
        mmsi = data['mmsi']
    except:
        mmsi = None
    try:
        ais_version= data['ais_version']
    except:
        ais_version= None
    try:
        imo= data['imo']
    except:
        imo= None
    try:
        callsign = data['callsign']
    except:
        callsign = None
    try:
        shipname = data['shipname']
    except:
        shipname = None
    try:
        ship_type = data['ship_type']
    except:
        ship_type = None
    try:
        to_bow = data['to_bow']
    except:
        to_bow = None
    try:
        to_stern= data['to_stern']
    except:
        to_stern= None
    try:
        to_port= data['to_port']
    except:
        to_port= None
    try:
        to_starboard = data['to_starboard']
    except:
        to_starboard = None
    try:
        epfd = data['epfd']
    except:
        epfd = None
    try:
        month= data['month']
    except:
        month= None
    try:
        day = data['day']
    except:
        day = None
    try:
        hour = data['hour']
    except:
        hour = None
    try:
        minute= data['minute']
    except:
        minute= None
    try:
        draught = data['draught']
    except:
        draught = None
    try:
        destination = data['destination']
    except:
        destination = None
    try:
        dte= data['dte']
    except:
        dte= None
    try:
        sec = data['sec']
    except:
        sec = None
    try:
        maneuver = data['maneuver']
    except:
        maneuver = None
    try:
        spare_1= data['spare_1']
    except:
        spare_1= None
    try:
        raim = data['raim']
    except:
        raim = None
    try:
        radio = data['radio']
    except:
        radio = None
    try:
        turn = data['turn']
    except:
        turn = None
    try:
        speed = data['speed']
    except:
        speed = None
    try:
        accuracy = data['accuracy']
    except:
        accuracy = None
    try:
        lon = data['lon']
    except:
        lon = None
    try:
        lat = data['lat']
    except:
        lat = None
    try:
        course = data['course']
    except:
        course = None
    try:
        heading = data['heading']
    except:
        heading = None

    values= (reçu_a,msg_type, on_repeat, mmsi, ais_version, imo, callsign, shipname, ship_type, to_bow,
             to_stern, to_port, to_starboard, epfd, month, day, hour, minute, draught, destination, dte,
             turn,speed,accuracy, lon, lat, course, heading, sec, maneuver, spare_1, raim, radio,ship_status)

    query_ais = """INSERT INTO `raw_data`
    (timestamp ,msg_type, on_repeat, mmsi, ais_version, imo, callsign, shipname, ship_type, to_bow,
    to_stern, to_port, to_starboard, epfd, month, day, hour, minute, draught, destination, dte, 
    turn,speed,accuracy, longitude, latitude, course, heading, sec, maneuver, spare_1, raim, radio,ship_status)
    VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""
    cursor.execute(query_ais, values)
    cursor.close()
    db.commit()
    db.close()

def decodeFromFile(arg_host, arg_user, arg_password, arg_database, arg_filename):
    for msg in FileReaderStream(arg_filename):
        msg_decoded = msg.decode()
        to_DB(arg_host, arg_user, arg_password, arg_database,msg_decoded)
        # closing()

def listenPort(arg_host, arg_user, arg_password, arg_database,url,port):
    for msg in UDPReceiver(url,  int(port)):
       # print(msg)
        print(msg.decode())
        msg_decoded = msg.decode()
        try:
            to_DB(arg_host, arg_user, arg_password, arg_database,msg_decoded)
        except:
            pass



def loar_arg():
    # Detect and load the arguments
    if sys.argv[1] == "-h":
        help()
    elif sys.argv[1] == "-help":
        help()
    else:
        arg_host = sys.argv[1]
        arg_user = sys.argv[2]
        arg_password = sys.argv[3]
        arg_database = sys.argv[4]
        arg_url = sys.argv[5]
        arg_port = sys.argv[6]

        listenPort(arg_host, arg_user, arg_password, arg_database, arg_url, arg_port)


def help():
    # Display Help
    os.system('cls')  # clear screen for windows
    # os.system('clear')  # clear screen for linux and mac
    print("Help")
    print("")
    print("Syntax: python to_ais.py [options]")
    print("")
    print("Options:")
    print("")
    print("help or h          Print Help Page")
    print("[Host]             Hostname or IP of the Database Server")
    print("[User]             User name to access to the Database")
    print("[Password]         Password to access to the Database")
    print("[DB_name]          Name of the Database")
    print("[url]              File url to connect if listenFromPort")
    print("[port]             File port to connect if listenFromPort")
    print("")
    print("Command line exemple.")
    print("python3 to_ais.py -help")
    print("python3 to_ais.py server_hostname user_name user_pass database_name url_to_connect port")
    print("python3 to_ais.py 192.168.1.100 user_test pass1234 data_test 127.0.0.1 10110")
    print("python3 to_ais.py cidco.ca user_test pass1234 data_test 127.0.0.1 10110")
    print("")
    print("")
    print("")


if len(sys.argv) == 7:
        loar_arg()
    # except KeyboardInterrupt:
    #     print("Caught keyboard interrupt, exiting")
    # except ConnectionResetError:
    #     print("Connection interrupt, exiting")
else:
    print (len(sys.argv))
    help()  # not the right amount of argument

