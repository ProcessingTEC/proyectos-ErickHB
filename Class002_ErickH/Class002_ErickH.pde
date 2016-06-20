//Erick Hernandez Bonilla
int BOX_SIZE = 300;
int SPHERE_SIZE = 20;
int HALF_SPHERE_SIZE = SPHERE_SIZE/2;
int MAX_SPHERES = 50;

int nSpheres = 0;

class Figure { 
  PVector vector;
  PVector direction;
  int size;
  color iColor;

  Figure (PVector vector, int size, PVector direction, color iColor) {  
    this.vector = vector;
    this.direction = direction;
    this.size = size;
    this.iColor = iColor;
  } 
}

ArrayList<Figure> spheres = new ArrayList<Figure>();

void mouseMoved() 
{
  if(nSpheres < MAX_SPHERES)
  {
    PVector sphere = PVector.random3D();
    sphere.x = map(sphere.x,0,1,HALF_SPHERE_SIZE, BOX_SIZE-HALF_SPHERE_SIZE)/2;
    sphere.y = map(sphere.y,0,1,HALF_SPHERE_SIZE, BOX_SIZE-HALF_SPHERE_SIZE)/2;
    sphere.z = map(sphere.z,0,1,HALF_SPHERE_SIZE, BOX_SIZE-HALF_SPHERE_SIZE)/2;
    
    spheres.add(new Figure(sphere, SPHERE_SIZE,new PVector(1,1,1), color(96*random(-20,20),151*random(-20,20),50*random(-20,20),70))); 
    nSpheres++;
  }
}

void setup()
{
  size(600,600,P3D);
  randomSeed(millis());
  noiseSeed(millis());
}

void draw()
{
  background(255);
  
  translate(300,300,0);
  rotateY(radians(map(mouseX,0,height,0,360)));
  rotateX(radians(map(mouseY,0,width,0,360)));
  
  stroke(0);
  noFill();
  box(BOX_SIZE);
  
  lights();
  noStroke();
  
  
  for (int i = 0; i < spheres.size(); i++) 
  {
    Figure sphere = spheres.get(i);
    
    pushMatrix(); 
  
    fill(sphere.iColor);
    translate(sphere.vector.x,sphere.vector.y,sphere.vector.z);
    sphere(SPHERE_SIZE);
  
    sphere.vector.add(sphere.direction);
  
    sphere.direction.x = (sphere.vector.x >= (BOX_SIZE/2-SPHERE_SIZE) ? -1 : sphere.vector.x <= -(BOX_SIZE/2-SPHERE_SIZE) ? 1 : sphere.direction.x); 
    sphere.direction.y = (sphere.vector.y >= (BOX_SIZE/2-SPHERE_SIZE) ? -1 : sphere.vector.y <= -(BOX_SIZE/2-SPHERE_SIZE) ? 1 : sphere.direction.y); 
    sphere.direction.z = (sphere.vector.z >= (BOX_SIZE/2-SPHERE_SIZE) ? -1 : sphere.vector.z <= -(BOX_SIZE/2-SPHERE_SIZE) ? 1 : sphere.direction.z); 
  
    popMatrix();
  }
}