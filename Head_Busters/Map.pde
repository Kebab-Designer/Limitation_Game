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
      player1.success = false;
        
    
    //random zone generation
      //randomize size
      zoneSize = int(random(150, 400));

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

void restart(){
  countdown = 10.8;
  stage ++;
}


  void countDown() {
    
    //variable for countdown interval
    float interval = .02;
    
    //only subtracts if not 0
    if (countdown >= interval) {
      //count to 0
      countdown = countdown - interval;
      
      println(floor(countdown));
    }
  }
}
