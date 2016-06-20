//Erick Hernandez Bonilla

class Figure { 
  color savedColor;
  float savedX;
  float savedY;
  float savedR;

  Figure (float x, float y, float r, color inColor) {  
    savedX = x; 
    savedY = y; 
    savedR = r;
    savedColor = inColor;
  } 
} 

ArrayList<Figure> figures = new ArrayList<Figure>();
boolean stop = false;

void setup() {
  size(600, 600, P3D);
  smooth(8);
  
  randomSeed(0);
  
  location = new PVector(mouseX, mouseY);
}

color getColorRandomly()
{
  float R = random(0,255);
  float G = random(0,255);
  float B = random(0,255);
  float A = random(70,100);
  return color(R,G,B,A);
}

void mouseClicked() {
  if(mouseButton == LEFT)
  {
    color newColor = getColorRandomly();
    figures.add(new Figure(mouseX,mouseY, 10, newColor));
  }
  
  stop = mouseButton == RIGHT;
}

void mouseDragged() 
{
  velocity = new PVector(mouseX - pmouseX, mouseY - pmouseY);
  location.add(velocity);
}

PVector location;
PVector velocity;

void draw() {
  
  if (stop) return;
  
  background(255);
  //line weight and color
  //strokeWeight(10);

  pushMatrix();

  lights();
  translate(location.x, location.y);

  for (int i = 0; i < figures.size(); i++) {
    pushMatrix();
    
    Figure figure = figures.get(i);
    stroke(figure.savedColor); 
    
    translate(figure.savedX, figure.savedY, -i);
    sphere(figure.savedR);
    if(figure.savedR <= 100) 
      figure.savedR += 0.05;
    
    popMatrix();
  }
  
  popMatrix();
  
}