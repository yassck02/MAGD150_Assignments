color currentColor;
color selectedColor;
color backgroundColor = color(0, 0, 0);
float r = random(0, TWO_PI); // ring rotation
float spiralOrientation = 0;
float triangleOrientation = 0;
boolean bool = false;


void setup() {
  size(800, 800);
  background(backgroundColor);
  noCursor();
  rectMode(CENTER);
  colorMode(HSB);
}


void draw() {
  background(backgroundColor);

  drawDots();
  drawGradientCircle();
  drawSpiral(spiralOrientation);
  drawSpinningCircles();
  drawCursor();
  drawCircleOfLines();
  drawTriangle(width/2, height/2, triangleOrientation);
  
  if(bool){
    filter(INVERT);
  }

  spiralOrientation = spiralOrientation - 0.1;
  triangleOrientation = triangleOrientation + 0.025;
}

void drawGradientCircle() {
  noFill();
  for (float t = 0.0; t <= TWO_PI; t = t + .15) {
    currentColor = color(255*(t/TWO_PI), 255, 255);
    stroke(currentColor);
    strokeWeight(20);
    point(width/2+200*cos(t), height/2+200*sin(t));
    stroke(0, 0, 255);
    strokeWeight(15);
    point(width/2+200*cos(t), height/2+200*sin(t));
  }
}

void drawSpinningCircles() {
  noFill();
  stroke(0, 0, 255);
  strokeWeight(2);
  ellipse(width/2, height/2, 450, 450);
  ellipse(width/2, height/2, 350, 350);

  strokeWeight(8);
  arc(width/2, height/2, 450, 450, triangleOrientation-PI/8+PI/3, triangleOrientation+PI/8+PI/3);
  arc(width/2, height/2, 350, 350, triangleOrientation-PI/16+PI/3, triangleOrientation+PI/16+PI/3);

  arc(width/2, height/2, 450, 450, triangleOrientation-PI/8+PI, triangleOrientation+PI/8+PI);
  arc(width/2, height/2, 350, 350, triangleOrientation-PI/16+PI, triangleOrientation+PI/16+PI);

  arc(width/2, height/2, 450, 450, triangleOrientation-PI/8-PI/3, triangleOrientation+PI/8-PI/3);
  arc(width/2, height/2, 350, 350, triangleOrientation-PI/16-PI/3, triangleOrientation+PI/16-PI/3);
}


void drawCursor() {
  noFill();
  int x = mouseX;
  int y = mouseY;

  stroke(0, 0, 255);
  strokeWeight(1);
  noFill();

  stroke(0, 0, 255);
  line(x+10, y, x-10, y); //crosshairs
  line(x, y-10, x, y+10);


  if (mousePressed) {
    rect(x, y, 35, 35); //rect
  } else {
    line(x-20, y-20, x-10, y-20); //corners only
    line(x+20, y-20, x+10, y-20);
    line(x-20, y+20, x-10, y+20);
    line(x+20, y+20, x+10, y+20);

    line(x-20, y-20, x-20, y-10);
    line(x+20, y-20, x+20, y-10);
    line(x-20, y+20, x-20, y+10);
    line(x+20, y+20, x+20, y+10);
  }

  //r = atan2((1.0*mouseY-height/2), (1.0*mouseX-width/2)); //angle from center based on mouse position
}

void drawSpiral(float a) {
  stroke(0, 0, 255);
  fill(0, 0, 255);
  strokeWeight(1);
  ellipse(width/2, height/2, 7, 7);
  for (float z = 0; z <= PI*18.5; z = z + 0.005) {
    point(width/2+3*z*cos(z+a), height/2+3*z*sin(z+a));
  }
}

void drawCircleOfLines() {
  for (float t = 0.0; t <= TWO_PI; t = t + .1) {
    strokeWeight(2);
    line (width/2+250*cos(t), height/2+250*sin(t), width/2+255*cos(t), height/2+255*sin(t));
  }
}

void drawDots() {
  strokeWeight(1);
  stroke(0, 0, 255);
  for (int q = 0; q <= 10; q++) {
    point(random(width), random(height));
  }
}

void drawTriangle(int x, int y, float b) {
  stroke(0, 0, 255);
  beginShape();
  for (float s = b; s <= b + TWO_PI; s = s + 2*PI/3) {
    vertex(x+250*cos(s), y+250*sin(s));
  }
  endShape(CLOSE);
}

void mousePressed(){
  bool =! bool;
}
