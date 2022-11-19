//create player
Player player1;

//initialize map
Map level;

//gameflow booleans
boolean gameStatus = true;

void settings() {
  //full screen and resolution if on smaller and larger devices
  if (displayWidth > 1920 && displayHeight > 1080) {
    size(1920, 1080);
  } else {
    fullScreen();
    //size(displayWidth, displayHeight); //not using fullscreen because both are mutually exclusive
  }
}

void setup() {

  //fps
  frameRate(60);

  player1 = new Player(0, 0, 60, 0, 0);

  //create the level
  level = new Map();
  //the created map is the level instance
  player1.map = level;

  //font stuff
  score = createFont("EuclidSquare-Bold.otf", 640);
  body = createFont("EuclidSquare-Medium.otf", 24);

  //generate the very first circle in advance
  level.update();
}

void draw() {

  // 0. Set the stage level and difficulty(0, 1, 2 etc.)
  level.countDown();

  // 1. Where is the Zone
  // 2. Where is the player
  // 3. Check the timer
  // 4. If timer has run out check if player is safe

  //is player safe when countdown is at 0
  //Player lose
  if (level.countdown < 0.4) {

    //player safe -> win
    if (player1.isSafe == true) {
      //println("win");
      
      //game flow for screens
      gameStatus = true;
      
      player1.success = true;
    }

    //player not safe -> lose
    if (player1.isSafe == false) {
      //println("lose");
      
      //gameflow for screens
      gameStatus = false;
      
      player1.success = false;
    }
  }

  //if all players are safe
  //congratulate players //wait a few sec
  //restart the process at step 0.

  if (player1.success == true) {
    level.progress();    
    level.update();

  }

  //if one player not safe
  //announce the other player has won
  //optional -> advance to next level

  //after all of this -> start drawing


  background(gameStatus ? black : honey);

  //display timer
  textFont(score);
  textAlign(CENTER);
  fill(12);
  //rounds the countdown with the int instead of manually doing it
  text(int(level.countdown), width/2, height/2 + 240); //addition to compensate for font height

  level.display();

  player1.move();
  player1.display();


  //Gui -----v
  textFont(body);
  textAlign(LEFT);
  fill(white);
  text("Level:  " + level.stage, 10, 24);

  //debug
  //println(level.countdown);
}

//void keyPressed() {
//  level.update();
//}
