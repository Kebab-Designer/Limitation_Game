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

    itemSpawn = random(0, width);
    itemHeight = 0;
  }

  void display() {



    //calculate necessary variables for collision
    //calculate distance between player and zone (1)
    float zDist = dist(itemSpawn, itemHeight, mouseX, mouseY); //need to change these mouse variables to incoming variables

    //calculate the new safe distance based on both radius (2)
    float playerDist = zDist - size/2 - safety;

    //if the zone radius is larger than the distance from the player
    if (playerDist < size) { //*note swap with zDist to make it easier
      collected = true;
      //println("collected");
      
      //when item is collected
      player1.size -= 30; //reduce player size by 30
      
    } else {
      collected = false;
      //println("nope");
    }

    noStroke();
    fill(honey);
    circle(itemSpawn, itemHeight +=2, size);

    ////itemdebugging
    //stroke(255);
    //strokeWeight(2);
    //line(itemSpawn, itemHeight, mouseX, mouseY);
  }
}
