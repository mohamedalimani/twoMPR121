#include <Wire.h>
#include <Adafruit_MPR121.h>

Adafruit_MPR121 cap1 = Adafruit_MPR121();
Adafruit_MPR121 cap2 = Adafruit_MPR121();

uint16_t lasttouched1 = 0;
uint16_t currtouched1 = 0;

uint16_t lasttouched2 = 0;
uint16_t currtouched2 = 0;

char Buffer[3] ;
int x,y ;
int lastx, lasty ;

void setup() {
Serial.begin(9600);
if (!cap1.begin(0x5A)) {
//Serial.println("MPR121 A not found, check wiring?");
}
//Serial.println("MPR121 A found!");

if (!cap2.begin(0x5B)) {
//Serial.println("MPR121 B not found, check wiring?");
}
//Serial.println("MPR121 B found!");
}

void loop() {
currtouched1 = cap1.touched();
currtouched2 = cap2.touched();

//For A----------------------------------------------------------
for (uint8_t i=0; i<12; i++) {
if ((currtouched1 & _BV(i)) && !(lasttouched1 & _BV(i)) ) {
//Serial.print(i); Serial.println(" touched of A");
x = i ;
}
  
//For B----------------------------------------------------------
if ((currtouched2 & _BV(i)) && !(lasttouched2 & _BV(i)) ) {
//Serial.print(i); Serial.println(" touched of B");
y = i ;
}

/** these two if conditions will make sure that sensor 1 and 2 are touched at the 
 same time when the data is sent via serial port. x and y receive value 20 
that means that it's currently not touched. 
**/
if (!currtouched1 & _BV(i)){
  x = 20 ;
  }

if (!currtouched2 & _BV(i)){
  y = 20 ;
  }
  
  // gives value 21 to x and y if both sensors are not touched
if ((!currtouched1 & _BV(i)) && (!currtouched2 & _BV(i))){
  x = 21 ;
  y = 21 ;
  sprintf(Buffer,"%d %d",x,y) ;
  Serial.println(Buffer) ;
  }
}

// check if both sensors are touched and that one of them (x and y) value are changed
if (((x != lastx) || (y != lasty)) && ((x != 20) && (y != 20))){
  sprintf(Buffer,"%d %d",x,y) ;
  Serial.println(Buffer) ;
}



lasttouched1 = currtouched1;
lasttouched2 = currtouched2;
lastx = x ;
lasty = y ;
return;
}
