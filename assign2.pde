/* 
author:ching
update:2016/7/29
*/

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_END = 2;

PImage enemyImg, fighterImg, treasureImg, hpImg, bg1Img, bg2Img;
PImage start1Img, start2Img, end1Img, end2Img;

float hpFull, hp, hpDamage, hpAdd, enemy;
float treasureX, treasureY, fighterX, fighterY, enemyX, enemyY;
float enemySpeed, fighterSpeed, bg1Move, bg2Move;

int gameState;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup () {
  
  size(640,480) ;
  
  enemyImg = loadImage("img/enemy.png");
  fighterImg = loadImage("img/fighter.png");
  treasureImg = loadImage("img/treasure.png");
  hpImg = loadImage("img/hp.png");
  bg1Img = loadImage("img/bg1.png");
  bg2Img = loadImage("img/bg2.png");
  start1Img = loadImage("img/start1.png");
  start2Img = loadImage("img/start2.png");
  end1Img = loadImage("img/end1.png");
  end2Img = loadImage("img/end2.png");
      
  //hp 
  hpFull = 194;
  hp = hpFull*2/10;
  hpDamage = hpFull*2/10;
  hpAdd = hpFull/10;  

  //move control
  enemySpeed = 3;
  fighterSpeed = 5;
  bg1Move = 0;
  bg2Move = -640;  

  //subject location
  treasureX = floor(random(0,600));
  treasureY = floor(random(35,440));
  enemyX = 0;  
  enemyY = floor(random(35,410));  
  fighterX = 590;
  fighterY = 220; 
          
  gameState = GAME_START;
}

void draw() {
  
  switch (gameState){
    case GAME_START:
      image(start2Img, 0, 0);    
      if (mouseX > 210 && mouseX < 450 && mouseY > 370 && mouseY < 410){
        if (mousePressed){
          gameState = GAME_RUN;
        }else{
          image(start1Img, 0, 0);
        }
      }  
      break;
      
    case GAME_RUN:
      //background
      bg1Move += 1;
      if(bg1Move == 640){
        bg1Move *= -1;
      }
      image(bg1Img,bg1Move,0);      
      bg2Move += 1;
      if(bg2Move == 640){
        bg2Move *= -1;
      }
      image(bg2Img,bg2Move,0);  
      
      //hp
      fill(255,0,0); 
      rect(13,3,hp,17);  
      noStroke();      
      image(hpImg,0,0);
      
      //fighter move
      image(fighterImg, fighterX, fighterY);  
      if (upPressed) {
        fighterY -= fighterSpeed;
      }
      if (downPressed) {
        fighterY += fighterSpeed;
      }
      if (leftPressed) {
        fighterX -= fighterSpeed;
      }
      if (rightPressed) {
        fighterX += fighterSpeed;
      }      
      
      //fighter boundary detection  
      if(fighterX > 590){
        fighterX = 590;
      }
      if(fighterX < 0){
        fighterX = 0;
      }
      if(fighterY > 430){
        fighterY = 430;
      }
      if(fighterY < 0){
        fighterY = 0;
      }

      //treasure
      image(treasureImg, treasureX, treasureY);
      if(fighterX+50 >= treasureX && fighterX <= treasureX+40){
        if(fighterY+50 >= treasureY && fighterY <= treasureY+40){
        hp += hpAdd;
        treasureX = floor(random(0,600));
        treasureY = floor(random(35,440));
          if(hp > hpFull){
            hp = hpFull;
          }
        }
      }      
      
      //enemy
      enemyX += enemySpeed;
      enemyX %= 640;
      if(fighterY > enemyY){
        enemyY += 1;
        }else if(fighterY < enemyY){
        enemyY -= 1;
        }   
      image(enemyImg, enemyX, enemyY);

      //enemy move
      if (upPressed) {
        enemyY -= 2;
      }
      if (downPressed) {
        enemyY += 2;
      }   
      if(enemyY > height){
        enemyY = 0;
      }
      if(enemyY < 0){
        enemyY = height;
      }      
      
      //game end
      if(fighterX+50 >= enemyX && fighterX <= enemyX+30){
        if(fighterY+50 >= enemyY && fighterY <= enemyY+60){
          hp -= hpDamage;
          enemyX = 0;
          enemyY = floor(random(35,410));  
          if(hp < 1){
            gameState = GAME_END;
          }
        }
      }
      break;
      
    case GAME_END:
      image(end2Img, 0, 0);    
      if (mouseX > 210 && mouseX < 435 && mouseY > 304 && mouseY < 350){
        if (mousePressed){                         
          //default value
          treasureX = floor(random(0,600));
          treasureY = floor(random(35,440));
          enemyX = 0;  
          enemyY = floor(random(35,410));  
          fighterX = 590;
          fighterY = 220;              
          hp = hpFull*2/10;
          
          gameState = GAME_RUN;
        }else{
          image(end1Img, 0, 0);
        }
      }
      break;
  } 
}

void keyPressed(){
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
