import grafica.*;
import processing.serial.*;

/**
- add "line linking" option 
- add delete graph button
- change random x number with graphical reactive buttons in processing screen
- add the next program mode "draw point between two points" 
**/

String[] newLabels = {"0", "1", "2", "3", "4", "5","6","7","8","9","10","11"};

GPlot plot1 ;
//int xAxeText ;
//int yAxeText ;
//int step = 50 ; 
Serial myPort;  // Create object from Serial class
int cycle = 0 ; //sensors send random data at the program start so we'll wait for 12 loops to start reading data after it finishes sending them
int x,y ;
String inBuffer;
String[] token;

void setup(){
  // THE PLOT SETUP 
  size(700,700) ;
  plot1 = new GPlot(this);
  
  plot1.setPos(0,0);
  plot1.setDim(600, 600);
  plot1.getTitle().setText("touch sensors data");
  plot1.getXAxis().getAxisLabel().setText("MPR121 one");
  plot1.getYAxis().getAxisLabel().setText("MPR121 two");
  plot1.setPointColor(color(0,0,0,255));
  plot1.setPointSize(8);
  //plot1.setFixedTicks(true) ;
    //xAxeText = 0 ;
    //yAxeText = 0 ;
/**
  //tracing plot 
  // X AXE :
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
  **/
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
     // circle(30+50*x,600-50*y,10) ;
        plot1.addPoint(x, y) ;
      }
      cycle++ ;
  }
  plot1.beginDraw();
  plot1.drawBackground();
  plot1.drawBox();
  plot1.drawXAxis();
  plot1.drawYAxis();
  plot1.drawTitle();
  plot1.drawGridLines(GPlot.BOTH);
  plot1.drawPoints();
  plot1.endDraw();
}
