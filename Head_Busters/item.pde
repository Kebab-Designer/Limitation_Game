float itemSpawn;
int itemHeight;

int size = 40;

//safety margin to be counted as within the zone
int safety = 0;



class Item {
  
  //import data
  Map connect = level;
  
  //player collected
  boolean collected = false;  
  
  void generate() {
    giveItem = false;
    itemSpawn = random(0, width);
    itemHeight = 0;
  }

  void display() {
    for (Andy u : user){ //player = u
  
      //calculate necessary variables for collision
      //calculate distance between player and zone (1)
      float zDist = dist(itemSpawn, itemHeight, u.avgX, u.avgY); //need to change these mouse variables to incoming variables
  
      //calculate the new safe distance based on both radius (2)
      float playerDist = zDist - u.size/2 - safety;
  
        //if the zone radius is larger than the distance from the player
        if (playerDist < u.size) { //*note swap with zDist to make it easier
          collected = true;
          println("collected");
          
          //when item is collected
          u.size -= 30; //reduce player size by 30
          
        } else {
          collected = false;
          println("nope");
      }  
      
        //itemdebugging
    stroke(255);
    strokeWeight(2);
    line(itemSpawn, itemHeight, u.avgX, u.avgY);
}

    //draw item
    noStroke();
    fill(honey);
    circle(itemSpawn, itemHeight +=2, size);

  }
}
