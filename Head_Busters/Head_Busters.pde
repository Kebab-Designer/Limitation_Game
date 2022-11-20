//create player
Player player1;

//initialize map
Map level;

//initialize items
Item powerUp;

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
  //dictates countdown speed :(
  frameRate(60);

  player1 = new Player(0, 0, 60, 0, 0);

  //create the level
  level = new Map();

  //the created map is the level instance
  player1.map = level;

  //setup item
  powerUp = new Item();

  //connect instance variables from item
  powerUp.connect = level;

  //font stuff
  score = createFont("EuclidSquare-Bold.otf", 640);
  body = createFont("EuclidSquare-Medium.otf", 24);

  //reset game
  level.resetGame();

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

    //first time player has progressed //only happens once
    if (level.stage > 2) {
      powerUp.generate();
    }
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

  //1. layer -----------------> map
  level.display();

  //2. layer -----------------> items
  if (level.stage > 2) { //activate items after passing level 2

    //modulo the stage to get a item every second level
    //modulo
    int frequency = level.stage%2; //only spits out 0 and 1
    if (frequency > 0 && gameStatus == true) {

      //only display when item has not been collected
      if (powerUp.collected == false) {
        powerUp.display();
      }
    }
  }

  //3. layer -----------------> player
  player1.move();
  player1.display();

  //4. layer -----------------> ui
  //Gui -----v
  textFont(body);
  textAlign(LEFT);
  fill(white);
  text("Level:  " + level.stage, 10, 24);

  //debug
  //println(frameCount%2);
}

void keyPressed() {

  //reset game
  if (key == 'r') {
    //1. reset data
    level.resetGame();

    //2. randomize zone
    level.update();
  }
}
