class Player {
  float x;
  float y;
  float size; //player diameter
  int status; //safe or not safe
  int id; //which player


  //playerball
  int pSize = 60;
  
  
  //import level data
  Map map = level;

  //player safety
  boolean isSafe = false;
  
  
  
  //assing incoming to local variables
  Player(float x, float y, float size, int status, int id) {

    //assign variables to use later on
    this.x = x;
    this.y = y;
    this.size = size;
    this.status = status;
    this.id = id;
    
  }

  //move player according to sampled colors
  void move() {

    x = mouseX;
    y = mouseY;
  }

  //draw the player
  void display() {

    //calculate necessary variables for collision
    //calculate distance between player and zone (1)
    float zDist = dist(mouseX, mouseY, map.zoneX, map.zoneY);

    //calculate the new safe distance based on both radius (2)
    float playerDist = zDist + pSize/2;

    //if the zone radius is larger than the distance from the player
    if (map.zoneSize/2 > playerDist) { //*note swap with zDist to make it easier
      isSafe = true;
      //println("safe");
    } else {
      isSafe = false;
      //println("danger");
    }

    //debug line
    stroke(sky);
    strokeWeight(3);
    line(mouseX, mouseY, map.zoneX, map.zoneY);

    fill(isSafe ? mint : crimson);
    circle(x, y, pSize);
  }
}
