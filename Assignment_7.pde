Food[] myFoods = new Food[10];
Food currentFood = new Food();

Person myPerson = new Person();
Timer myTimer = new Timer();

int numEaten = 0;

PImage burger;
PImage fork;
PImage background;

boolean paused = false;

void setup() {
  size(1000, 750);
  colorMode(RGB);
  imageMode(CORNERS);
  noSmooth();
  noCursor();

  textSize(50);
  fill(0, 255, 0);

  fork = loadImage("https://cloud.githubusercontent.com/assets/14878231/11727668/d5079db4-9f4a-11e5-8f66-f6bc45ab28c1.png");
  burger = loadImage("https://cloud.githubusercontent.com/assets/14878231/11727652/ba53b714-9f4a-11e5-9a56-c349c4a77154.png");
  background = loadImage("https://cloud.githubusercontent.com/assets/14878231/11727670/dbda4efc-9f4a-11e5-8e6c-29cb3ced8a10.gif");


  for (int i = 0; i < myFoods.length; i++) { //initialize array
    myFoods[i] = new Food();
  }

  myTimer.Begin();
}


void draw() {
  image(background, 0, 0, width, height); //background

  myPerson.move();
  myPerson.display();

  myTimer.display();


  for (int i = 0; i < myFoods.length; i++) { 
    currentFood = myFoods[i];

    currentFood.renderFood();
    currentFood.updateFoodPos();

    println("eaten " + numEaten + " out of " + myFoods.length);
  }

  if (numEaten >= myFoods.length) {
    println("game is over");
    myTimer.display();
  } else {
    myTimer.endTime = millis();
  }
}






class Timer {
  float startTime;
  float endTime;
  float time;

  Timer() {
  }

  void Begin() {
    startTime = millis();
  }


  void display() {
    text((endTime - startTime)/1000.0, 10, 50);
  }

  void resetTimer() {
    startTime = millis();
  }
}





class Person {
  int posX = width/2;
  int posY = height/2;

  int d = 100;
  int speed = 10;

  Person() {
  }

  void display() {
    image(fork, posX-130, posY-50, posX+30, posY+50);
  }

  void move() {
    posX = mouseX;
    posY = mouseY;

    if (posX >= width-d/2) {
      posX = width-d/2;
    }
    if (posX <= 0+d/2) {
      posX = 0+d/2;
      if (posY >= height-d/2) {
        posY = height-d/2;
      }
      if (posY <= 0+d/2) {
        posY = 0+d/2;
      }
    }
  }
}




class Food {
  float x;
  float y;
  float sx;
  float sy;
  float r = 50;
  boolean eaten = false;

  Food() {
    x = random(r, width-r);
    y = random(r, height-r);
    do {
      sx = round(random(-5, 5));
    } while (sx == 0); //select a random x speed until its not equal to zero
    do {
      sy = round(random(-5, 5));
    } while ((sy == 0)||(sy == sx));//select a random y speed until its not equal to zero AND the x speed
  }

  void renderFood() {
    if (eaten == false) {
      image(burger, x-50, y-50, x+50, y+50);
    }
  }

  void updateFoodPos() {
    x += sx;
    y += sy;

    if ((x <= 0+r)||(x >= width-r)) {
      sx *= -1;
    }
    if ((y <= 0+r)||(y >= height-r)) {
      sy *= -1;
    }
  }
}






void mousePressed() {
  if (mousePressed == true) {
    for (int i = 0; i < myFoods.length; i++) { 
      currentFood = myFoods[i];
      if (currentFood.eaten == false) {
        if (dist(currentFood.x, currentFood.y, myPerson.posX, myPerson.posY) <= 50) {
          currentFood.eaten = true;
          numEaten++;
        }
      }
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    resetGame();
  }
  if (key == ' ') {
    paused =! paused;
    if (paused) {
      noLoop();
    } else {
      loop();
    }
  }
}

void resetGame() {
  for (int i = 0; i < myFoods.length; i++) { 
    currentFood = myFoods[i];
    currentFood.eaten = false;
  }
  numEaten = 0;
  myTimer.startTime = millis();
  myTimer.endTime = 0;
}
