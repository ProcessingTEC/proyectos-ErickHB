//Erick Hernandez Bonilla
//based on Tomas de Camino Beck

import processing.serial.*;
Serial port;

void setup() {
  port = new Serial(this, "/dev/tty.usbmodem1411", 9600);
  size(600,600);
}

void draw() {
  int mX = mouseX;
  port.write(nf(mX)+"\n");
}

void stop()
{
  port.stop();
}
