class Player {
  float x;
  float y;
  float size; //player diameter
  int status; //safe or not safe
  int id; //which player

  
  //safety margin to be counted as within the zone
  int safety = 0;
  
  //import level data
  Map map = level;

  //player safety
  boolean isSafe = false;
  
  //level advancement
  boolean success = false;
  
  //assing incoming to local variables
  Player(float x, float y, float size, int status, int id) {

    //assign variables to use later on
    this.x = x;
    this.y = y;
    this.size = size;
    this.status = status;
    this.id = id;
    
    //dont think i even need size, status and the id but ill leave them for now
    
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
    float zDist = dist(x, y, map.zoneX, map.zoneY); //need to change these mouse variables to incoming variables

    //calculate the new safe distance based on both radius (2)
    float playerDist = zDist + size/2 - safety;

    //if the zone radius is larger than the distance from the player
    if (map.zoneSize/2 > playerDist) { //*note swap with zDist to make it easier
      isSafe = true;
      //println("safe");
    } else {
      isSafe = false;
      //println("danger");
    }

    ////debug line
    //stroke(sky);
    //strokeWeight(3);
    //line(mouseX, mouseY, map.zoneX, map.zoneY);

    noStroke();
    fill(isSafe ? mint : crimson); //control player display if safe and in danger
    circle(x, y, size);
  }
}
