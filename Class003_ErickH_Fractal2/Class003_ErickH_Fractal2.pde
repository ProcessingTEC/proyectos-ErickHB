//Erick Hernandez Bonilla

class Figure
{
  PVector v;
  PVector b;
  PVector d;
  float w;

  Figure (PVector v, float w) {  
    this.v = v;
    this.b = v.copy();
    this.w = w;
  } 
}

ArrayList<Figure> figures = new ArrayList<Figure>();

void setup()
{
  size(600,600);
  branch(new Figure(new PVector(width/2,height),6), 0, 150, 0.78);
}

void draw()
{
  background(255);
  smooth();
  
  for(Figure f : figures)
  {
    PVector close;
    
    if(abs(mouseX-f.v.x) < 50 && abs(mouseY-f.v.y) < 50)
      close = new PVector(mouseX,mouseY);
    else
      close = f.b;
    
    f.v.x += (close.x - f.v.x)/100;
    f.v.y += (close.y - f.v.y)/100;
    
    stroke(0);
    strokeWeight(f.w);
    line(f.v.x,f.v.y, f.d.x,f.d.y);
  }
}

void branch(Figure figure, float a, float l, float p)
{ 
  PVector newPoint = new PVector(figure.v.x, figure.v.y - l);
  newPoint = newPoint.sub(figure.v);
  newPoint = newPoint.rotate(radians(a));
  newPoint = newPoint.add(figure.v);
  
  figure.d = newPoint;
  figures.add(figure);
  
  if(l<10) return;
  
  branch(new Figure(newPoint, figure.w * 0.7), a+45, l*p, p);
  branch(new Figure(newPoint, figure.w * 0.7), a-45, l*p, p);
  
}