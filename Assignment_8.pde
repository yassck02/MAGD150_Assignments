int squareSize = 20; //number of tiles
int numFoods = 10;

boolean gameOver = false;

Timer myTimer;

int[] gridX = new int[width/squareSize];
int[] gridY = new int[height/squareSize];

Food[] food = new Food[numFoods];

Snake player1 = new Snake();

void setup() {
  size(1005, 750);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CORNERS);
  colorMode(HSB);

  myTimer = new Timer();
  myTimer.Start();

  for (int n = 0; n < food.length; n++) {
    food[n] = new Food();
  }
}

void draw() {
  if (frameCount%6 == 0) {
    background(0, 0, 0);
    drawGrid();
    player1.render();
    player1.updatePos();
    for (int n = 0; n < food.length; n++) {
      food[n].render();
    }
    myTimer.getPassedTime();
    println(myTimer.passedTime);
  }
}

void drawGrid() {
  fill(0, 0, 255, 100);
  stroke(0, 0, 255, 50);
  for (int x = squareSize; x <= width-squareSize; x+=squareSize) {
    for (int y = squareSize; y <= height-squareSize; y+=squareSize) {
      rect(x, y, squareSize-1, squareSize-1);
    }
  }
}

void gameOver() {
  gameOver = true;
  myTimer.End();
  myTimer.getPassedTime();

  filter(INVERT);

  fill(0, 0, 255);
  println("GAME OVER");
  textSize(100);
  text("GAME OVER", width/2, height/2-75);
  textSize(50);
  text("Snake Length = " + player1.snakeLength, width/2, height/2+30);
  textSize(40);
  text("Game Time - " + myTimer.passedTime + " seconds", width/2, height/2+80);
  textSize(25);
  text("Click to restart", width/2, height/2+115);
  noLoop();
}

void mousePressed() {
  if (gameOver) {
    loop();
    player1.reset();
    myTimer.Start();
    gameOver = false;
  }
}






class Food {
  PImage img;

  int posX;
  int posY;

  float t = 100; //transparency

  Food() {
    img = loadImage("food.png");

    posX = round(random(1, width/squareSize))*squareSize;
    posY = round(random(1, height/squareSize))*squareSize;
  }

  void render() {
    image(img, posX-squareSize/2, posY-squareSize/2, posX+squareSize/2, posY+squareSize/2);
    //fill(h, 255, 255, t);
    //ellipse(posX, posY, squareSize-2, squareSize-2);
  }

  void reset() {
    posX = round(random(1, width/squareSize))*squareSize;
    posY = round(random(1, height/squareSize))*squareSize;
  }
}





class Snake {
  int maxLength = 350;
  int initialLength = 6;

  int[] Xpositions = new int[maxLength];
  int[] Ypositions = new int[maxLength];

  int posX; // of the head of the snake
  int posY; // ''

  int snakeLength;

  int direction; // 1 = right, 2 = up, 3 = left, 4 = down 

  float h; // hue (color) of the snake

  Snake() {
    h = round(random(255));
    snakeLength = initialLength;
    posX = round(random(10, width/squareSize))*squareSize;
    posY = round(random(10, height/squareSize))*squareSize;
    direction = int(random(1, 4));
  }

  void updatePos() {
    if (keyPressed) { //get the direction based on key pressed
      switch(key) {
      case 'w':
        direction = 2; 
        break;
      case 'a':
        direction = 3;
        break;
      case 's':
        direction = 4;
        break;
      case 'd':
        direction = 1; 
        break;
      }
    }
    switch(direction) { //move the snake based on current direction ov movement
    case 1:
      posX += squareSize; 
      break;
    case 2:
      posY -= squareSize; 
      break;
    case 3:
      posX -= squareSize; 
      break;
    case 4:
      posY += squareSize; 
      break;
    }

    for (int i = snakeLength; i > 0; i = i - 1) { 
      Xpositions[i] = Xpositions[i-1]; //shif x positions in array to the right
      Ypositions[i] = Ypositions[i-1]; //shif Y positions in array to the right
      if ((posX == Xpositions[i])&&(posY == Ypositions[i])) { //if the position of the head == any of the positions of the other body parts...
        gameOver();
      }
    }

    Xpositions[0] = posX; //set the first value of the x positions array to the current xposition
    Ypositions[0] = posY; //set the first value of the y positions array to the current y position


    if ((posX > width-squareSize)||(posX < squareSize)) { //if the head of the snake goes off the left or right side...
      gameOver();
    }
    if ((posY > height-squareSize)||(posY < squareSize)) { //if the head of the snake goes off the top or bottom of the screen...
      gameOver();
    }

    for (int n = 0; n < food.length; n++) { //cycle through food positions
      if ((food[n].posX == posX) && (food[n].posY == posY)) { //if the head position is equal to any of the food positons...
        snakeLength += 3;//add 3 to the length when you eat a food
        food[n].reset(); //move the fruit to a new place
      }
    }

    //println(direction + " " + posX + "," + posY); //direction and position of the head
  }

  void render() {
    for (int i = 0; i < snakeLength; i++) { //draw the last #(snakeLenght) positions of the head
      h = 225*(i*1.0/snakeLength); //rainbow snake
      fill(int(h), 255, 255);
      rect(Xpositions[i], Ypositions[i], squareSize-3, squareSize-3);//draw the body part
    }
  }

  void reset() {
    for (int i = 0; i < maxLength; i++) { //reset snake body parts positions to 0 (x and y)
      Xpositions[i] = 0;
      Ypositions[i] = 0;
    }

    snakeLength = initialLength;

    posX = 10*squareSize; //reset the x position of the head to a random position on the board
    posY = 10*squareSize; //reset the y position of the head to a random position on the board
    Xpositions[0] = posX;
    Ypositions[0] = posY;

    direction = int(random(1, 4)); //set the direction randomly (see direction variable declaration above for explanation)...

    h = round(random(255)); //set the solor of the snake to a random color
  }
}








class Timer{
  float startTime;  // When Timer started
  float endTime; //When the timer is stopped
  float passedTime;
  
  // The constructor, set how long the Timer last with integer value
  Timer(){
    
  }
  
  // Start the Timer
  void Start() {
    startTime = millis();
  }
  void End(){
    endTime = millis();
  }
  void getPassedTime(){
    passedTime = (endTime - startTime)/1000;
  }
}
