void setup(){
  
   size(400,400);
   background(0, 0, 0);
   
   //dots(background)
   for(int x = 1; x < 400; x++){  
     for(int y = 1; y < 400; y++){  
       if ((x % 10 == 0) && (y % 10 == 0)){
         stroke(random(255), random(255), random(255));
           point(x,y);
       }
     }
   }
   
   //coin shape
   stroke(0, 0, 0); //black
   fill(200, 200, 200); //light grey
   ellipseMode(CENTER);
   ellipse(200, 200, 360, 360);
   ellipse(200, 200, 345, 345);
   
   
   
   //dome
   ellipse(200, 160, 125, 100); 
   
   rectMode(CENTER);
   rect(200, 160, 175, 25);
   rect(200, 250, 300, 20);
   rect(200, 200, 275, 80);
   rect(200, 200, 250, 80);
   rect(200, 200, 200, 80);
   rect(200, 200, 100, 70);
   rect(200, 250, 125, 25);
   
   
   //stairs
   line(140, 257, 260, 257);
   line(150, 252, 250, 252);
   line(160, 247, 240, 247);
   line(170, 242, 230, 242);
   
   //angled roof
   triangle(150, 165, 200, 140, 250, 165);
   rect(200, 172, 100, 10); 
   
   //pillars (left to right, top rect to bottom)
   rectMode(CENTER);
   rect(160, 180, 15, 5);
   rect(160, 207, 7, 50);
   rect(160, 235, 15, 5); 
   
   rect(180, 180, 15, 5);
   rect(180, 207, 7, 50);
   rect(180, 235, 15, 5); 
   
   rect(220, 180, 15, 5);
   rect(220, 207, 7, 50);
   rect(220, 235, 15, 5); 
   
   rect(240, 180, 15, 5);
   rect(240, 207, 7, 50);
   rect(240, 235, 15, 5); 
   
   //door
   rect(200, 215, 20, 35);
   
   //windows (left to right)
   rectMode(CORNER);
   rect(83, 185, 10, 20);
   rect(120, 180, 15, 35);
   rect(265, 180, 15, 35);
   rect(308, 185, 10, 20);
   
   //text
   fill(50, 50, 50); //text color
   textSize(15);
   text("Five Cents", 165, 300); 
   textSize(25);
   text("United States of", 103, 330); 
   text("America", 155, 360); 
   textSize(20);
   text("E Pluribus Unum", 120, 80); 
}

void draw () { //helps get coordinates when drawing
  println (mouseX +"," + mouseY);
} 
