Dot dots[] = new Dot[10];

void setup() {
  size(2500, 1300);
  colorMode(HSB);

  for (int i = 0; i <dots.length; i++) {
    dots[i] = new Dot();
    dots[i].X1 = (width/dots.length)*i;
    dots[i].Y1 = height/2;
  }
}

void draw() {

  for (int i = 0; i <dots.length; i++) {
    dots[i].updatePos();
    stroke(255.0*(1.0*i/dots.length), 255, 255);
    dots[i].display();
  }
}

class Dot {
  int X1;
  int Y1;
  int X2;
  int Y2;
  
  int maxDist = 5;
  
  //int h; //hue

  Dot() {
    X1 = int(random(width));
    Y1 = int(random(height));
  }
  void display() {

    line(X1, Y1, X2, Y2);
  }

  void updatePos() {
    X2 = X1;
    Y2 = Y1;
    X1 += round(random(-1 * maxDist, maxDist));
    Y1 += round(random(-1 * maxDist, maxDist));
    
  }
}
