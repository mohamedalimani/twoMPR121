import processing.serial.*;

/**
- add "line linking" option 
- add delete graph button
- change random x number with graphical reactive buttons in processing screen
- add the next program mode "draw point between two points" 
**/

int xAxeText ;
int yAxeText ;
int step = 50 ; 
Serial myPort;  // Create object from Serial class
int cycle = 0 ; //sensors send random data at the program start so we'll wait for 12 loops to start reading data after it finishes sending them
int x,y ;
String inBuffer;
String[] token;

void setup(){
  // THE PLOT SETUP 
  background(0,0,0) ;
  size(700,650) ;
    xAxeText = 0 ;
    yAxeText = 0 ;
  //tracing plot 
  // X AXE :
  stroke(255) ;
  strokeWeight(3) ;
  line(30,600,600,600) ;         // x axes
  for(int i = 0;i<12;i++){
    text(i,30+xAxeText,615) ;
    textSize(10) ;
    textAlign(CENTER) ;
    fill(255);
     xAxeText += 50 ;
  }
  // Y AXE : 
  line(30,30,30,600) ;           // y axes
  for(int i = 0;i<12;i++){
    text(i,15,600-yAxeText) ;
    textSize(10) ;
    textAlign(CENTER) ;
    fill(255);
     yAxeText += 50 ;
  }
 
  String portName = Serial.list()[0] ;
  myPort = new Serial(this, portName, 9600) ;
}

void draw(){
  if (myPort.available() > 0 ){
      inBuffer = myPort.readStringUntil('\n') ;
      if ((inBuffer != null) && (cycle>12)){
        token = splitTokens(inBuffer) ;
        x = Integer.parseInt(token[0]);
        y = Integer.parseInt(token[1]);
        circle(30+50*x,600-50*y,10) ;
      }
      cycle++ ;
  }

}
