class Map {

  //collision variables
  float zRadius; //radius of the main ellipse

  //x and y coordinates of the safe zone
  int zoneX;
  int zoneY;
  int zoneSize;

  //timer settings -> float to subtract decimals
  float countdown = 10.8;

  //the difficulty / stage of the levels
  int stage = 0;

  void update() {
    //state of success
    for (Andy u : user) {
      u.success = false;
    }

    //random zone generation
    //randomize size
    // old -> //zoneSize = int(random(150, 400));

    //incriment smaller zoneSize
    zoneSize = 400 - (stage*20);
    //println(stage);

    //first randomize in order to offset from the edge

    //randomize location of safe zone
    zoneX = int(random(0 + zoneSize/2, width - zoneSize/2));
    zoneY = int(random(0 + zoneSize/2, height - zoneSize/2));
  }

  void display() {
    //zone style
    noFill();
    stroke(white);
    circle(zoneX, zoneY, zoneSize);
  }

  void progress() {
    //resets countdown and advances the level

    // + need to integrate timer reducing by one every time as long as its above 5 secs
    countdown = 10.8;
    stage ++;

    //increase player size each level
    for (Andy u : user) {
      u.size += 10;
    }

    //reset item spawn
    powerUp.collected = false;
  }

  void countDown() {

    //variable for countdown interval
    float interval = .04;

    //only subtracts if not 0
    if (countdown >= interval) {
      //count to 0
      countdown = countdown - interval;

      //println(floor(countdown));
    }
  }

  void resetGame() {
    //reset player size
    for (Andy u : user) {
      u.size = 40;
    }


    //reset zone size
    zoneSize = 400;

    //reset timer
    countdown = 10.8;

    //reset gameStatus game over
    gameStatus = true;
    
    //reset level
    stage = 0;
  }
}
