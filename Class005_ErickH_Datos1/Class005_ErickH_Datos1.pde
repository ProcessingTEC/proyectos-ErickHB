import controlP5.*;

class Measurement
{
  int R=1;
  
  float la;
  float lo;
  float speed;
  float air;
  float cX;
  float cY;
  
  Measurement (float la, float lo, float speed, float air)
  {
    this.la = la;
    this.lo = lo;
    this.speed = speed;
    this.air = air;
  }
  
  //geographic to cartessian
  float getX() {
    float x = R * cos(la) * cos(lo);
    return x;
  }
  
  float getY() {
    float y = R * cos(la) * sin(lo);
    return y;
  }
}

ControlP5 cp5;
float Scale = 45;
int current = 0;

ArrayList<Measurement> data = new ArrayList<Measurement>();
float minX = 0;
float maxX = 800;
float minY = 0;
float maxY = 800;


PFont font;


void setup() {
  cp5 = new ControlP5(this);
  cp5.addSlider("Scale")
    .setPosition(10, 10)
    .setRange(10, 500)
    .setValue(45)
    ;

  boolean first = true;
  size(800, 800);
  font = loadFont("AmericanTypewriter-64.vlw");
  String[] tData = loadStrings("Qdata.txt");
  for (int i=0; i<tData.length; i++) {
    String[] parts = tData[i].split(",");
    Measurement m = new Measurement(float(parts[0]), float(parts[1]), float(parts[2]), float(parts[3]));
    
    m.cX = map(m.getX(), 0, 1, 0, 800);
    m.cY = map(m.getY(), 0, 1, 0, 800);
    
    data.add(m);
    
    if(first)
    {
      minX = maxX = m.getX();
      minY = maxY = m.getY();
      first = false;
    }
    else
    {
      float x = m.getX();
      float y = m.getY();
      if(x < minX) minX = x;
      if(x > maxX) maxX = x;
      if(x < minY) minY = y;
      if(x > maxY) maxY = y;
    }
  }
  
  minX = map(minX, 0, 1, 0, 800);
  maxX = map(maxX, 0, 1, 0, 800);
  minY = map(minY, 0, 1, 0, 800);
  maxY = map(maxY, 0, 1, 0, 800);
  
  smooth();
}


void draw() {
  background(0);
  noFill();
  
  textFont(font, 50);
  boolean text = true;
  
  for(int i =0; i < data.size(); i++) {
    Measurement m = data.get(i);
    
    pushMatrix();
    
    float newX = map(m.cX, minX - 20, maxX + 20, 0, 800);
    float newY = map(m.cY, minY - 20, maxY + 20, 0, 800);
    
    float speed = map(m.speed, 0, 200, 0, 100);
    float air = map(m.air, 0, 200, 100, 300);
    
    translate(newX, newY);
    scale(Scale/100);
    
    stroke(255, 90);
    ellipse(0,0,speed, speed);
    
    if (abs(mouseX - newX) < m.speed && abs(mouseY - newY) < m.speed && text)
    {
      text("Speed: " + m.speed + ", Air: " + m.air, 0, 0);
      text = false;
    }
    
    stroke(154, 51, 52, 75);
    ellipse(0,0,air, air);  
    
    popMatrix();
  }
}