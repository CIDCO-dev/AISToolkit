# Software pour décoder AIS 


Antenna :  ~368 cm

1. First solution : [rtl_ais](https://github.com/dgiardini/rtl-ais)

> rtl-ais is a simple command-line utility that does the complex job of interfacing with an RTL-SDR dongle and decoding AIS data, providing it on as the standard NMEA-0183 format.

* INSTALLATION  :
```
	sudo apt-get install librtlsdr-dev
	sudo apt-get install libusb-dev
	git clone https://github.com/dgiardini/rtl-ais
	cd rtl-ais
	make
	./rtl_ais
```

* HOW TO USE : 
```

On a first terminal : 

	 ./rtl_ais -n -T
	 
On a second : 

	nc 127.0.0.1 10110
```

2. Second solution : [AIS-Catcher](https://github.com/jvde-github/AIS-catcher)


* INSTALLATION : voir le lien ci-dessus pour les instructions  :grin:

* Avantages : 
	- Plus simple à utiliser, une seule ligne pour le lancer et une seule fenêtre cmd nécessaire
	
* UTILISATION : 

	AIS-catcher -v -u 127.0.0.1 10110

Exemple de sortie : 


	[AIS engine v0.35]:                      1 msgs at 0 msg/s
	!AIVDM,1,1,,B,34eO>R5000s6GPBKgESRjl=f0000,0*44 ( MSG: 3, REPEAT: 0, MMSI: 316133000)
	[AIS engine v0.35]:                      2 msgs at 0.2 msg/s




