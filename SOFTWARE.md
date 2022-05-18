# AIS SOFTWARE DECODER

## Connecting to the ais channels and receiving data

### 1. First solution : [rtl_ais](https://github.com/dgiardini/rtl-ais)

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

On a first terminal : 

```
	 ./rtl_ais -n -T
```	 

On a second : 

```
	nc 127.0.0.1 10110
```


### 2. Second solution : AIS-Catcher


* INSTALLATION : Click [here](https://github.com/jvde-github/AIS-catcher)

* ADVANTAGE : 
	- Simple to use, only one terminal needed, might be longer to install
	
* HOW TO USE : 

```
	AIS-catcher -v -u 127.0.0.1 10110
```
Output example : 


	[AIS engine v0.35]:                      1 msgs at 0 msg/s
	!AIVDM,1,1,,B,34eO>R5000s6GPBKgESRjl=f0000,0*44 ( MSG: 3, REPEAT: 0, MMSI: 316133000)
	[AIS engine v0.35]:                      2 msgs at 0.2 msg/s





