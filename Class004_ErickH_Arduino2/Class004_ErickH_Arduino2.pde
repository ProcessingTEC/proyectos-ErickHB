//Tomas de Camino Beck

import processing.serial.*;
Serial port;

FloatList values = new FloatList();
int maxValue = 100;

void setup() {
  //println(Serial.list());
  //Seleccionar puerto de la lista
  port = new Serial(this, "/dev/tty.usbmodem1411", 9600);
  port.bufferUntil('\n');  //clear the buffer
  size(600, 600);
}

void draw() {
  
  background(255);
  
  stroke(0);
  beginShape(); 
  for(int i = 0; i < values.size();i++)
  {
    float newX = map(i,1,maxValue,0,600);
    curveVertex(newX, 100+values.get(i)); // the first control point
    ellipse(newX,100+values.get(i),3,3);
  }
  endShape();
  
  line(0,100,600,100);
  
  //port.write(""+"\n");
}

void stop()
{
  port.stop();
}

void serialEvent(Serial port) {
  String data = port.readString();
  float tVal = float(data);
  if(Float.isNaN(tVal)) return;  
  
  if(values.size() == maxValue)
    values.remove(1);
  
  if(tVal > 50) tVal = 50;
  if(tVal < 0) tVal = 0;
  
  float size = map(tVal,0,50,0,500);
  values.append(size);
}