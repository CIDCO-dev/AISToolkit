# AIS Tool Kit Antenna DIY
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/1.FullAssembled.png?raw=true" alt="Fully assembled antenna">

## Building the dipolar antenna

### 1. First of all, why choosing a dipolar antenna ?

This type of antenna is the simplest to be made from a theoretical point of view, consisting only of two conductors of egal lengths oriented end-to-end in opposite direction, it can be made anywhere. It is also allows important to note that it's very convenient when deciding of the total lenght of the antenna.

### 2. Parts list and purposes

Prerequisites :  

> Raspberry pi 3 with sd card  

> Nooelec NESDR Mini 2+ TCXO RTL-SDR & ADS-B  
&nbsp;&nbsp;&nbsp;&nbsp;- low-cost wide-band software defined radio.

> Nooelec Module Lana  
&nbsp;&nbsp;&nbsp;&nbsp;- Low noise amplifier (lna)

> Lightning Arrestor N female to N female 

> cable N male to N male 75 ft

> cable N male to sma male 10 ft

> cable SMA male to SMA male 6 in 

> Drill and drilling bits

> Bow saw

> Sand paper

> 4 screws & bolts

> PVC glue

> Hot glue

> Silicone


Antenna parts :  

> Cable RG-174 6-inches

> Electrical coper wire 14 gauge 3 ft

> 5 ft 2 inche pipe for central vacuum

> 3 cap for 2 inche pipe for central vacuum

> T for 2 inche pipe for central vacuum

> Female N jack panel mount connector



### 3. Steps to build the antenna 
#### 3.1 Strip off the threads
First, you need to strip off the electrical copper wire (14 gauge) by taking off the insulator. We only needed to buy a 3 feet wire because by striping it you have now 3 conductors !  
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/2.StrippedCopperWires.png?raw=true" alt="Stripped copper wires"> 


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
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/3.MeasuredLenghtOfWire.png" alt="Measured lenght of wires">
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/4.ZoomOnMeasuredLenght.png?raw=true" alt="Zoom on measured lenght">

#### 3.3 Isolating the conductors with an hard shell (central vacuum pipe)

For this part, we want to start building the hard shell of our antenna since it will go outside. So first, we cut the central vacuum pipes into desired lenghts. Measure 46.5 cm and use a pen to mark the pipe, then using an hand saw, cut the pipe. 
It should look like this, times two.  

<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/5.MeasuredLenghtOfShell.png?raw=true" alt="Measured lenght of hard shell">  

Now that you have both hard shells, you glue the conductor inside of it. It is recommended to scrape with sand paper the places where it is going to be glued (helps the glue adhering). For instance, inside of the vacuum pipes and on both extremeties.  
The pipes are now ready to contain the conductors, and you'll want them to exceed a little bit (approximatively 1.5cm) for the parts that are going to be in the middle. (the T connector).  

<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/6.MeasuredLenghtOfConductorInShell.jpg?raw=true" alt="Measured lenght of conductors in the shell" width="325" height="350"> <img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/7.insideViewOfConductorInShell.jpg" alt="Inside view of conductors in the shell" width="325" height="350"> <img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/8.AnotherInsideView.jpg?raw=true" alt="An additional view of the inside of the shell" width="325" height="350">  

<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/9.insideT-connector.jpg" alt="Inside T connector" width=50% height=50%>  
 
Once the conductors are glued in the pipes, you can now glue the pipes in the T-connector and also the caps on the extremities.   

#### 3.4 Last milestone, the T-Connector 

As you saw previously, there is going to be a cap on the T-connector to cover both conductors, but this cap is going to have on it the female N jack panel mount connector.  
But first, we need to use our RG-174 cable to connect it to the male part of the female N jack panel mount connector. So one conductor welded to the mount connector and the other one welded to the "ground".  

It should look like this :  
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/10.Male-N-jack.jpg" alt="Male N Jack" width="300" height="300">
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/11.Male-N-jack2ndView.jpg" alt="Male N Jack 2nd view" width="300" height="300">
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/12.Male-N-Jack-3rd-View.jpg" alt="3rd view of male N Jack" width="300" height="300">   
You can cut a hole in the 2-in cap to fit the female N jack panel mount connector and once in place you need to screw it.
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/13.Female-N-jack-on-second-cap.jpg" alt="Female N Jack" width="300" height="300">    
The inside, should look like this now, but we also added some silicon to prevents the screws from rusting.
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/14.Underneath-female-N-Jack-silicone.jpg" alt="underneath the female N Jack" width="400" height="400">  
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/15.Underneath-female-N-Jack-more-silicone.jpg" alt="2nd view underneath female N Jack" width="400" height="400">

The conductor going out needs to be nicely separated in two, like this, and you'll need some heat shrink tubes to insulate them :  
Also, you can use some of the leftover PVC pipe (vacuum pipe) and cut a 2" long tube that you're going to glue to the cap.  
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/16.Conductors-going-out-of-the-female-N-jack.jpg" alt="conductors going out of the female N Jack " width="400" height="400"> <img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/17.Zoom-On-the-conductor-going-out-of-the-female-N-Jack.jpg" alt="Zoom on the conductors goign out of the female n jack" width="400" height="400">  
You can safely weld them inside your T-connector.  
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/18.Welding-conductors-to-the-T-connector.jpg" alt="Welding of the conductors to the T Connector" width=65% height=65%>  
Finally, you can close the final cap and glue it but before use sand paper or a knife to scrape the plastic to be sure of having a good adhesion  
<img src="https://github.com/CIDCO-dev/AISToolkit/blob/main/Hardware/Antenna/images/19.Adding-the-cap-to-the-T-connector.jpg" alt="Final product" width=65% height=65%>   
Et voilà !  
