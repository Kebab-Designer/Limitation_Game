import processing.video.*;
Capture video; //initial class "Capture" to beginn capturing video material

//void event to get new content from camera if available (smooth video transmission)
void captureEvent(Capture video) {
  video.read();
}

//create player
Player player1;

//initialize map
Map level;

//initialize items
Item powerUp;

//initialize screens
Screen ui;

//gameflow booleans
boolean gameStatus = true; //used when in game

//boolean for gameplay and menu time
boolean gamePlay = false; //used to control from game to lobby
boolean preGame = false; //used for calibrating players
boolean controls = false; //used to show leaderboard in lobby
boolean giveItem = false; //used to control when to spawn items
boolean multiplayer = false; //used to declare multiple people
boolean rewards = false; //used to show winning screen

//void settings() {
//  //full screen and resolution if on smaller and larger devices
//  if (displayWidth > 1920 && displayHeight > 1080) {
//    size(1280, 720);
//  } else {
//    fullScreen();
//    //size(displayWidth, displayHeight); //not using fullscreen because both are mutually exclusive
//  }
//}

//arraystuff
ArrayList<Andy> user = new ArrayList<Andy>(); //define arrayList


void setup() {
  size(1280, 720);
  //dictates countdown speed :(
  frameRate(60);

  //camere shozzle
  printArray(Capture.list());

  //create ui
  ui = new Screen();

  //create player
  player1 = new Player(0, 0, 40, 0, 0);

  //create the level
  level = new Map();

  //the created map is the level instance
  player1.map = level; //redundant

  //setup item
  powerUp = new Item();

  //connect instance variables from item
  powerUp.connect = level;

  //font stuff
  score = createFont("EuclidSquare-Bold.otf", 640);
  body = createFont("EuclidSquare-Medium.otf", 24);
  h1 = createFont("EuclidSquare-Bold.otf", 80);
  h3 = createFont("EuclidSquare-Light.otf", 32);

  //reset game
  level.resetGame();

  //generate the very first circle in advance
  level.update();

  //video initialize
  video = new Capture(this, 1280, 720, "pipeline:avfvideosrc device-index=0 ! video/x-raw, width=1280, height=720, framerate=30/1"); //start new capture, capture size and fps
  video.start(); //start the video function
}


void draw() {

  //menu time -------------------------------------------------->
  //homeScreen
  ui.home();

  if (controls) {
    //show leaderboard
    ui.controls();
  }
  //menu time -------------------------------------------------->

  /* ---------- user creation ------------*/
  if (preGame) {
    ui.preGame();


    //array
    for (Andy p : user) {
      p.display();
    }
  }
  /* ---------- user creation ------------*/

  if (gamePlay == true) {
    //gaming time -------------------------------------------------->
    // 0. Set the stage level and difficulty(0, 1, 2 etc.)
    level.countDown();

    // 1. Where is the Zone
    // 2. Where is the player
    // 3. Check the timer
    // 4. If timer has run out check if player is safe

    //is player safe when countdown is at 0
    //Player lose
    if (level.countdown < 0.4) {

      //array checks if each player is safe
      //if not safe they get removed
      //if safe the gameStatus is set to true
      for (int i = 0; i < user.size(); i++) {
        if (user.get(i).isSafe == false) {
          user.remove(user.get(i));
        } else {
          gameStatus = true;
          user.get(i).success = true;
        }
      }
    }

    //if all players are safe
    //congratulate players //wait a few sec
    //restart the process at step 0.

    if (multiplayer) {
      //game send to lobby prototype loop
      if (user.size() < 2) { //has player lost?
        //gamePlay = false; //therefore not gaming anymore -> back to the lobby

        //reset process
        for (Andy u : user) {
          u.size = 40;
        }
        //reset zone size
        level.zoneSize = 400;

        //reset timer
        level.countdown = 10.8;

        //reset gameStatus game over
        gameStatus = true;

        rewards = true;
      } else {
        for (Andy p : user) {

          if (p.success == true) {
            level.progress();
            level.update();
          }
        }
      }
    } else {
      for (Andy p : user) {

        if (p.success == true) {
          level.progress();
          level.update();
        }
      }
    }

    //if on multiplayer and there is only one player left -> game win

    //first time player has progressed //only happens once -------------------- OLD ITEM STUFF
    //if (level.stage > 2) {
    //  giveItem = true;
    //  powerUp.generate();
    //}


    //if one player not safe
    //announce the other player has won
    //optional -> advance to next level

    //after all of this -> start drawing


    background(black);    //gameplay background
    blendMode(NORMAL);
    //display timer
    textFont(score);
    textAlign(CENTER);
    fill(20);
    //rounds the countdown with the int instead of manually doing it
    text(int(level.countdown), width/2, height/2 + 240); //addition to compensate for font height

    //1. layer -----------------> map
    level.display();

    //2. layer -----------------> items
    //if (level.stage > 2) { //activate items after passing level 2

    //  //modulo the stage to get a item every second level
    //  //modulo
    //  int frequency = level.stage%2; //only spits out 0 and 1
    //  if (frequency > 0 && gameStatus == true) {

    //    //only display when item has not been collected
    //    if (powerUp.collected == false) {
    //      powerUp.display();
    //    }
    //  }
    //}

    //3. layer -----------------> player
    //player1.move();
    //player1.display();

    //array
    for (Andy p : user) {
      p.display();
      p.collision();
    }

    if (rewards) {
      ui.youWon();
    }

    //4. layer -----------------> ui
    //Gui -----v
    textFont(body);
    textAlign(CENTER);
    fill(white);
    text("Level:  " + level.stage, width/2, height - 24);


    //gaming time -------------------------------------------------->
  }  //- end bracket for gaming section
  //println(leaderboard);
}

void keyPressed() {

  //reset game
  if (key == 'r') {
    //1. reset data
    level.resetGame();

    //2. randomize zone
    level.update();

    preGame = true;
    rewards = false;
    gamePlay = false;
  }

  //direct play game shortcut
  if (key == 'p') {
    //1. reset data
    level.resetGame();

    //2. randomize zone
    level.update();

    preGame = true;
    multiplayer = false;
  }

  //advance to gameplay with SPACE
  if (key == ' ') {
    gamePlay = true;
    preGame = false;
  }

  if (key == 'f') {
    user = new ArrayList<Andy>(); //define arrayList
    multiplayer = false;
  }

  //flush entire programm
  if (key == 'q') {
    //gameflow booleans
    gameStatus = true; //used when in game
    gamePlay = false; //used to control from game to lobby
    preGame = false; //used for calibrating players
    controls = false; //used to show leaderboard in lobby
    giveItem = false; //used to control when to spawn items
    multiplayer = false; //used to declare multiple people
    rewards = false; //used to show winning screen

    user = new ArrayList<Andy>(); //define arrayList
    multiplayer = false;
  }
}

void mousePressed() {
  //sample color
  if (preGame) {
    //array
    Andy p = new Andy();
    user.add(p);
    p.sampleColor();

    //sets multiplayer on if more than one player is registered
    if (user.size() > 1) {
      multiplayer = true;
    }
    println(multiplayer);
  }

  //btn 2 = c
  if (mouseX >= 480 && mouseX <= 800) {
    if (mouseY > 480 && mouseY < 540) {
      //leaderboard
      controls = true;
    }
  }

  //btn 1 = p
  if (mouseX >= 120 && mouseX <= 440) {
    if (mouseY > 480 && mouseY < 540) {
      //1. reset data
      level.resetGame();

      //2. randomize zone
      level.update();

      preGame = true;
      multiplayer = false;
    }
  }
}
