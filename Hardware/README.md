# AIS Tool Kit Antenna DIY
## Building the dipolar antenna

### 1. First of all, why choosing a dipolar antenna ?

This type of antenna is the simplest to be made from a theoretical point of view, consisting only of two conductors of egal lengths oriented end-to-end in opposite direction, it can be made anywhere. It is also allows important to note that it's very convenient when deciding of the total lenght of the antenna.

### 2. Parts list and purposes

Ordered online : 
> Raspberry pi 3 with sd card  
&nbsp;&nbsp;&nbsp;&nbsp;- The brain of the project. Used to automate the proccess of aquiring data. The software was installed as a service to be launched when booted and is always running.   

> Nooelec NESDR Mini 2+ TCXO RTL-SDR & ADS-B  
&nbsp;&nbsp;&nbsp;&nbsp;- low-cost wide-band software defined radio.

> Nooelec Lana Module Lana  
&nbsp;&nbsp;&nbsp;&nbsp;- Low noise amplifier (lna)

> Lightning Arrestor N female to N female 

> Female N jack panel mount connector

From the hardware store : 

> cable N male to N male 75 ft

> cable N male to sma male 10 ft

> cable SMA male to SMA male 6 in 

> Electrical coper wire 14gauge 3 ft

> 5 ft 2 inche pipe for central vacuum

> 3 cap for 2 inche pipe for central vacuum

> T for 2 inche pipe for central vacuum

> saw ****

### 3. Steps to build the antenna
Now that you have all the parts, it's time to build your antenna !

#### 3.1 Strip off the threads
First, you need to strip off the electrical copper wire (14 gauge) by taking off the insulator. We only needed to buy a 3 feet wire because by striping it you have now 3 conductor !  
 
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img1.png)

#### 3.2 straighten the conductors and cut for the desired lenght
Using the following formula, we can calculate the total wavelenght of the radio signal we are tring to capture :  
λ = v / f (wavelenght = wave speed/frequency)   
* AIS signals are on the 161.975 MHz and 162.025 MHz frequencies :  f is approximatively 162 MHz.  
* The speed of light is 299 792 458 m/s.  
```
λ = 299 792 458 / 162 *10^6 = 1.850 m for the TOTAL wave lenght.	
```
  
To have optimal results, we want our dipolar antenna to represents half the lenght of the radio signal lenght. Therefore, exactly 1/4 of λ.  
Finally, each of the two conductors (branches) of our antenna needs to be : 
```
λ/4 = 1.85/4 = 0.462m = 46.2cm	
```
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img2%23.png)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img3%23.png)

#### 3.3 Isolating the conductors with an hard shell (central vacuum pipe)

For this part, we want to start building the hard shell of our antenna since it will go outside.   
A picture speaks a thousand words, this is what it's going to look like : 
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img4.png)
So first, we cut the central vacuum pipes into desired lenghts. Measure 46.5 cm and use a pen to mark the pipe, then we used a saw to cut the pipe. 
It should look like this, times two.  
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img5.png)  

Now that you have both hard shells, you glue the conductor inside of it. It is recommended to scrape with sand paper the places where it is going to be glued (helps the glue adhering). For instance, inside of the vacuum pipes and on both extremeties.  
The pipes are now ready to contain de conductors, and you'll want them to exceed a little bit for the parts that are going to in the middle (in the T connector).  
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_134439.jpg)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_135106.jpg)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_135118.jpg)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img9%23.png)
Once the conductors are glued in the pipes, you can now glue the pipes in the T-connector and also the caps on the extremities. **** Yavait aussi un trou de percer à une des extrémités messemble***    

#### 3.4 Last milestone, the T-Connector 

As you saw previously, there is going to be a cap on the T-connector to cover both conductors, but this cap is going to have on it the female N jack panel mount connector.  
But first, we need to use our third conductor from the 14 gauge copper electrical wire to connect it to the male part of the female N jack panel mount connector. So one conductor welded to the mount connector and the other one welded to the "ground".  

It should look like this : 

![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_142037.jpg)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_142042.jpg)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_142047.jpg)
 Now we can cut a hole in the 2-in cap to fit the female N jack panel mount connector and once in place you need to screw it.  
 
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img13.png)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_143209.jpg)
The inside, should look like this now, but we also added some silicon to prevents the screws from rusting.
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_143214.jpg)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220531_143400.jpg)
Now the conductor going out needs to be nicely separated in two, like this :  

![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img17%23%23.png)
And you'll need some heat shrink tubes to insulate them. 
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img18%40%40%40.png)

Now, you can safely weld them inside our T-connector
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img20.png)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220601_091934.jpg)
Finally, you can close the final cap and glue it(also use a sand paper to be sure of having a good adhesion)  
AND **TADAAAAAA** !

![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/dbb3dfff873a758691bc3026c31fcba4c73a9ab9/Hardware/Antenn-DIY/images/20220601_092050.jpg)
![alt text](https://raw.githubusercontent.com/Jacobb13/AISToolkit/main/Hardware/Antenn-DIY/images/img22.png)
