float posX = width/2;
float posY = height/2;
float speed = 3;
int roadWidth = 200;
color carColor;
int d;

void setup() {
  size(1200, 700);
  posX = width/2;
  posY = height/2;
  carColor = color(random(255), random(255), random(255));
  textSize(20);
  rectMode(CENTER);
  noStroke();
}

void draw() {

  background(#147900); //grass

  fill(#E0E0E0);
  rect(width/2, height/2, roadWidth+50, height+2);//gravel
  fill(#B9B9B9);
  rect(width/2, height/2, roadWidth, height+2);//pavement

  if (d>=height) {
    d = 0;
  }
  drawLines(d);
  d+=speed;


  if ((posX < width/2-roadWidth/2-25)||(posX > width/2+roadWidth/2+25)) { //if car goes off road, decrease speed
    if (frameCount % 10 == 0) {
      speed--;
    }
    if (speed <= 3) { //set minimum speed to 3
      speed = 3;
    }
  } else if (frameCount % 50 == 0) { // increase the speed every 50th frame
    speed++;
    if (speed >= 10) { //set speed cap at 10
      speed = 10;
    }
  }

  if (keyPressed == true) { //WASD car control
    switch(key) {
      case('w'):
      case('W'):
      posY -= speed;
      break;
      case('d'):
      case('D'):
      posX += speed*0.5; //right speed is half normal speed
      break;
      case('s'):
      case('S'):
      posY += speed;
      break;
      case('a'):
      case('A'):
      posX -= speed*0.5;//left speed is half normal speed
      break;
    }
  }
  drawCar(posX, posY); //draws Car on Screen

  fill(#FFFFFF);

  text("- Use the W A S D keys to move the car", 20, 30);
  text("- Click to change the color of the car", 20, 55);
  text("tip: Stay on the road to go faster", 20, 100);
  text("SPEED = "+speed, 1000, 30);
}

void drawCar(float x, float y) {
  stroke(#000000);

  fill(#292828);
  rect(x, y-25, 40, 5);//front Axle
  rect(x, y+25, 40, 5);//front Axle

  fill(#767676);//wheels
  rect(x-17, y-25, 10, 15, 4, 4, 4, 4);//FR
  rect(x+17, y-25, 10, 15, 4, 4, 4, 4);//FL
  rect(x-17, y+25, 10, 15, 4, 4, 4, 4);//RL
  rect(x+17, y+25, 10, 15, 4, 4, 4, 4);//RR

  fill(carColor);
  rect(x, y-5, 10, 75);//middle thin rectangle

  beginShape(); //front Fin
  vertex(x-10, y-45);
  vertex(x-18, y-35);
  vertex(x+18, y-35);
  vertex(x+10, y-45);
  endShape(CLOSE);

  triangle(x, y-25, x+15, y-10, x-15, y-10);//front triangle
  rect(x, y-5, 30, 10);//niddle rectangle
  triangle(x, y+30, x+15, y, x-15, y);//back triangle

  rect(x, y+35, 25, 7);//back fin

  beginShape();
  vertex(x, y+15);
  vertex(x-5, y);
  vertex(x-5, y-5);
  vertex(x+5, y-5);
  vertex(x+5, y);
  endShape(CLOSE);
}

void drawLines(int s) {
  stroke(#FFF300);

  for (int q = -1*height; q <= height; q+=100) {
    line(width/2, s+q, width/2, s+q+50);
  }
}

void mousePressed() {
  carColor = color(random(255), random(255), random(255)); //Changes color of car
}
