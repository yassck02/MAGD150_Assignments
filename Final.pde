Tank player1 = new Tank(1); //player 1
Tank player2 = new Tank(2); //player 2

PImage blueTank;
PImage redTank;
PImage startScreen;

boolean shouldShowStartScreen = true;
boolean gameOver = false;

PowerUp powerUps[] = new PowerUp[3]; //array of powerups
Wall walls[] = new Wall[7]; //array of walls

void setup() {
  size(1000, 700);
  colorMode(HSB);
  rectMode(CENTER);
  imageMode(CENTER);
  textMode(CENTER);
  textAlign(CENTER);
  textSize(50);
  noSmooth();
  noStroke();

  //frameRate(15);

  blueTank = loadImage("https://cloud.githubusercontent.com/assets/14878231/11768026/c02c325a-a185-11e5-95b5-5119d7f58eb6.png");
  redTank = loadImage("https://cloud.githubusercontent.com/assets/14878231/11768027/c4b99998-a185-11e5-99d5-47877506a515.png");
  startScreen = loadImage("https://cloud.githubusercontent.com/assets/14878231/11768024/b6df1c94-a185-11e5-9693-eeb23ee27f26.png");

  for (int i = 0; i < powerUps.length; i++) { //Initanizes each item in the array as a new powerup
    powerUps[i] = new PowerUp();
  }

  walls[0] = new Wall(50, height/2, height); //left wall
  walls[1] = new Wall(width-50, height/2, height); //right wall
  walls[2] = new Wall(width/2, height/2, 300); //center wall
  walls[3] = new Wall(width/4, height/4, 200); //left top wall
  walls[4] = new Wall(width/4, 3*height/4, 200); //left bottom wall
  walls[5] = new Wall(3*width/4, height/4, 200); //right top wall
  walls[6] = new Wall(3*width/4, 3*height/4, 200); //right bottom wall
}

void draw() {

  if (shouldShowStartScreen) {
    image(startScreen, width/2, height/2);
  } else {

    background(#AAD137); //grass

    for (int i = 0; i < powerUps.length; i++) {
      powerUps[i].display();
      powerUps[i].collect(player1);
      powerUps[i].collect(player2);
    }

    for (int i = 0; i < walls.length; i++) {
      walls[i].display();
    }

    player1.display();
    player1.move();
    player1.displayScore(200, 50);

    player2.display();
    player2.move();
    player2.displayScore(800, 50);

    if (player1.bullet.isFired) {
      player1.bullet.move();
    }
    if (player2.bullet.isFired) {
      player2.bullet.move();
    }

     println(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ");
     println("[PLAYER 1] - " + player1.keys[0] + ", " + player1.keys[1] + ", " +player1.keys[2] + ", " + player1.keys[3]);
     println("(" + player1.pos.x + ", " + player1.pos.y + ")");
     println("angle = " + player1.angle);
     println("health = " + player1.health);
     println("able to fire: " + player1.ableToFire);
     println(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ");
     println("[PLAYER 2] - " + player2.keys[0] + ", " + player2.keys[1] + ", " +player2.keys[2] + ", " + player2.keys[3]);
     println("(" + player2.pos.x + ", " + player2.pos.y + ")");
     println("angle = " + player2.angle);
     println("health = " + player2.health);
     println("able to fire: " + player2.ableToFire);
     
  }
}

void gameOver(Tank t) {
  filter(BLUR, 4);
  textSize(100);
  fill(0, 0, 0);
  text("GAME OVER", width/2, 200);
  fill(t.hue, 255, 160, 255);
  textSize(75);
  text("Player " + t.number + " wins!", width/2, 275);
  textSize(30);
  fill(0, 0, 0);
  text("click to reset...", width/2, 450);
  gameOver = true;
  player1.ableToFire = false;
  player2.ableToFire = false;
  noLoop();
}

void resetGame() {
  gameOver = false;
  player1.health = player2.health = 100;
  player1.pos.x = 200;
  player1.pos.y = 200;
  player2.pos.x = 800;
  player2.pos.y = 200;
  player1.ableToFire = true;
  player2.ableToFire = true;
}

void keyPressed() {
  player1.keyPressed();
  player2.keyPressed();
}
void keyReleased() {
  player1.keyReleased();
  player2.keyReleased();
}

void mousePressed() {
  if (gameOver) {
    loop();
    resetGame();
  }
  if (shouldShowStartScreen) {
    shouldShowStartScreen = false;
  }
}







class Bullet {
  PVector pos  = new PVector(0.0, 0.0);

  int radius = 10;
  float speed = 0.05;

  boolean canBounce = true;

  boolean isFired = false;
  float angle;
  float normalAngle;

  Tank targetTank;
  Tank parentTank;


  Bullet() {
  }

  void Launch(Tank parent, float a, Tank target) {
    targetTank = target;
    parentTank = parent;
    pos.x = parentTank.pos.x;
    pos.y = parentTank.pos.y;

    angle = a;
    parentTank.ableToFire = false;
    isFired = true;
  }

  void move() {
    pos.x += 1/(speed/cos(angle));
    pos.y += 1/(speed/sin(angle));

    if (isFired) {
      display();
    }

    if (dist(pos.x, pos.y, targetTank.pos.x, targetTank.pos.y) <= 35) { //if the missile gets close enough to the target tank...
      parentTank.ableToFire = true; //allow the tank that shot this missile to fire again
      targetTank.health -= 10; //subrtact 10 health from target tank
      resetBullet();
      if (targetTank.health <= 0) { //cap the health at min 0
        targetTank.health = 0;
        gameOver(parentTank); //parent tank wins if the target tank (the other tank) looses
      }
    }

    for (int i = 0; i < walls.length; i++) {
      if (((pos.x >= walls[i].pos.x - walls[i].W/2)&&(pos.x <= walls[i].pos.x + walls[i].W/2))&&((pos.y >= walls[i].pos.y - walls[i].H/2)&&(pos.y <= walls[i].pos.y + walls[i].H/2))) { 
        if (canBounce) {

          normalAngle = PI;

          angle = (2*normalAngle - PI - angle); //calculate bounce angle
          canBounce = false;
        } else { //if the bullet hits a wall and is unable to bounce...
          resetBullet();
        }
      }
    }


    if ((pos.x < 0)||(pos.x > width)||(pos.y < 0)||(pos.y > height)) { //if the bullet goes off the screen...      
      resetBullet();
    }
  }

  void resetBullet() {
    pos.x = parentTank.pos.x; //set the bullet position to the parent tanks position
    pos.y = parentTank.pos.y;
    parentTank.ableToFire = true; //allow the tank that shot this missile to fire again
    isFired = false;
    normalAngle = 0;
    canBounce = true;
  }
  
  
  
  
  
  class Tank {
  PVector pos  = new PVector(0.0, 0.0);

  float forwardSpeed = .5;
  float backwardSpeed = .5;

  float rotateSpeed = .025;
  float angle;

  int health = 100;
  boolean ableToFire = true;
  Bullet bullet = new Bullet();

  int hue; //not related to the tank color...
  int number;
  boolean keys[] = {false, false, false, false, false, false}; // W A S D Q *or* I J K L O
  boolean controlScheme; //if true then player uses WASD if false then player uses IJKL

  Tank(int num) {
    number = num;
    if (num == 1) {
      controlScheme = true;
      pos.x = 200;
      pos.y = 200;
      hue = 0;
      angle = 0;
    } else if (num == 2) {
      controlScheme = false;
      pos.x = 800;
      pos.y = 200;
      hue = 155;
      angle = 3.14;
    }
  }

  void display() {
    translate(pos.x, pos.y);
    rotate(angle);

    if (controlScheme) { //display red tank for player 1 and blue for 2
      image(redTank, 0, 0);
    } else {
      image(blueTank, 0, 0);
    }

    rotate(-angle);
    translate(-1*pos.x, -1*pos.y); //reset the origin to the top left of the screen
  }

  void move() {
    if (keys[0]) { //WWWWW
      pos.x += 1/(forwardSpeed/cos(angle));
      pos.y += 1/(forwardSpeed/sin(angle));
    }
    if (keys[1]) { //AAAAA
      angle -= rotateSpeed;
    }
    if (keys[2]) { //SSSSS
      pos.x -= 1/(backwardSpeed/cos(angle));
      pos.y -= 1/(backwardSpeed/sin(angle));
    }
    if (keys[3]) { //DDDDD
      angle += rotateSpeed;
    }
    if (keys[4]) {
      if (ableToFire) {
        if (number == 1) {
          bullet.Launch(player1, angle, player2); //first parrameter is the parent tank second is the target
        } else if (number == 2) {
          bullet.Launch(player2, angle, player1); //first parrameter is the parent tank second is the target
        }
      }
    }
  } 

  void displayScore(int x, int y) { //x,y are the position of the displayted score, h is the color
    textSize(30);
    fill(hue, 255, 160, 255);
    text("Player " + number +": " + health, x, y);
  }

  void keyPressed() {
    if (controlScheme == true) {
      if (key == 'w') {
        keys[0] = true;
      }
      if (key == 'a') {
        keys[1] = true;
      }
      if (key == 's') {
        keys[2] = true;
      }
      if (key == 'd') {
        keys[3] = true;
      }
      if (key == 'q') {
        keys[4] = true;
      }
    } else if (controlScheme == false) {
      if (key == 'i') {
        keys[0] = true;
      }
      if (key == 'j') {
        keys[1] = true;
      }
      if (key == 'k') {
        keys[2] = true;
      }
      if (key == 'l') {
        keys[3] = true;
      }
      if (key == 'o') {
        keys[4] = true;
      }
    }
  }

  void keyReleased() {
    if (controlScheme == true) {
      if (key == 'w') {
        keys[0] = false;
      } 
      if (key == 'a') {
        keys[1] = false;
      }
      if (key == 's') {
        keys[2] = false;
      }
      if (key == 'd') {
        keys[3] = false;
      }
      if (key == 'q') {
        keys[4] = false;
      }
    } 
    if (controlScheme == false) {
      if (key == 'i') {
        keys[0] = false;
      } 
      if (key == 'j') {
        keys[1] = false;
      }
      if (key == 'k') {
        keys[2] = false;
      }
      if (key == 'l') {
        keys[3] = false;
      }
      if (key == 'o') {
        keys[4] = false;
      }
    }
  }
}







class Wall {
  PVector pos = new PVector(0.0, 0.0);
  int H;
  int W;

  Wall(int x, int y, int h) {
    pos.x = x;
    pos.y = y;
    H = h;
    W = 20;
  }

  void display() {
    noStroke();
    fill(25, 85, 255);
    rect(pos.x, pos.y, W, H);
  }
}



class PowerUp {
  PVector pos  = new PVector(0.0, 0.0);
  float r;
  float r2;

  float startTime;

  float h; //hue (color)
  float t = 255; //transparency

  PowerUp() {
    r = 10;
    r2 = 50; //ending circle radius
    h = 0;
    randomPosition(); // give the circle a random position
  }

  void display() { 
    update();
    noStroke();
    fill(h, 0, 255, 255);
    ellipse(pos.x, pos.y, 20, 20); //constant dot
    noFill();
    strokeWeight(4);
    stroke(h, 0, 255, t); 
    ellipse(pos.x, pos.y, r, r); //growing ring
  }

  void update() {
    r = lerp(r, r2, 0.04); // increase current raduis (r) to max radius (r2) by step 0.04
    t = (255*(1-(r/r2))); //decrease transparency (as a percentage of the radius)

    if (r >= r2*.95) {
      r = 0;
      t = 255;
    }
  }

  void collect(Tank T) {
    if ((dist(T.pos.x, T.pos.y, pos.x, pos.y) <= 30)&&(T.health < 100)){ //if the tank is close enough to the health and the health of the tank is less than max 100...
      T.health += 5;
      randomPosition();
    }
  }

  void randomPosition() {
    pos.x = random(r, width-r); //random width position
    pos.y = random(r, height-r); //random height position
  }
}

  void display() {
    noStroke();
    fill(0, 0, 0);
    translate(pos.x, pos.y);
    ellipse(0, 0, radius, radius);
    translate(-1*pos.x, -1*pos.y);
  }
}
