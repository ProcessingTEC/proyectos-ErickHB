//Erick Hernandez Bonilla
#include <Servo.h>

Servo myServo;
int posX = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  myServo.attach(2);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(posX);
  int val = map(posX,0,600,0,180);
  myServo.write(val);
  //delay(50);
}

void serialEvent()
{
  if(Serial.available())
  {
    posX = Serial.parseInt();
  }
}

