class Map {

  //collision variables
  float zRadius; //radius of the main ellipse

  //x and y coordinates of the safe zone
  int zoneX;
  int zoneY;
  int zoneSize;


  void display() {
    //random zone generation
    if (keyPressed) {
      //randomize size
      zoneSize = int(random(150, 400));

      //first randomize in order to offset from the edge

      //randomize location of safe zone
      zoneX = int(random(0 + zoneSize/2, width - zoneSize/2));
      zoneY = int(random(0 + zoneSize/2, height - zoneSize/2));
    }

    //zone
    fill(white);
    noStroke();
    circle(zoneX, zoneY, zoneSize);
  }
}
