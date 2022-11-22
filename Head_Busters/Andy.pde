class Andy{
int x;
int y;
// location
int loc;

float avgX = 0;
float avgY = 0;

float mX;//interpolated X coordinate for mouse
float mY; //interpolated Y coordinate for mouse

// current color
color currentColor;

// track color
color trackColor;

float r1, r2, g1, g2, b1, b2;
// distance
float d;

//treshold
float treshHold = 40; //any pixel with difference less than value

//global collision detection variables
float zDist;
float playerDist;
float size = 40;

//safety margin to be counted as within the zone
int safety = 0;

//import level data
Map map = level;

//player safety
boolean isSafe = false;

//level advancement
boolean success = false;
  
//----------------------------------------------------->
  void display(){
  //declaring closest xy coordinates
  float avgX;
  float avgY;
  
  //count variable for avg pixel color
  int count = 0;

  //debugging
  //treshHold = map(mouseX, 0, width, 0, 100); // maps mouse to treshHold
  //println(treshHold);

  /*--------------video processing algorythm-----------------*/
  for (int x = 0; x < video.width; x ++) {
    for (int y = 0; y <video.height; y ++) {


      //without horizontal flip the line below woudld read -> x + y * video.width;
      this.loc = (video.width - x - 1) + y * video.width; //formula for finding the location

      //current color
      this.currentColor = video.pixels[loc]; //set currentColor variable to the location of the pixel

      //extract rgb values of the variable currentColor (currentColor -> current loc in for loop)
      this.r1 = red(currentColor);
      this.g1 = green(currentColor);
      this.b1 = blue(currentColor);

      //get rgb values of tracking color (trackcolor -> color to look for)
      this.r2 = red(trackColor);
      this.g2 = green(trackColor);
      this.b2 = blue(trackColor);

      //calculate difference of the two colors
      this.d = dist(r1, g1, b1, r2, g2, b2);

      //if current color within defined treshhold
      if (this.d < treshHold) {
        this.avgX += x;
        this.avgY += y;

        count++; //increase everytime to later divide to create avg
      }
    }
  }

  //what to do if location has been found
  if (count > 0) {

    this.avgX = this.avgX / count; // creates average
    this.avgY = this.avgY / count; // creates average
    //draw a circle at tracked pixel
    fill(trackColor); //give fill of specified color to track
    stroke(0);
    
    //lerp the cursor
    mX = lerp(mX, this.avgX, 0.01); //create smooth X dot sample
    mY = lerp(mY, this.avgY, 0.01); // create smooth Y dot sample    

    //display ellipse flipped
    ellipse(this.avgX, this.avgY, this.size, this.size);

    //if (this.isSafe == true){
    //  fill(mint);
    //  ellipse(avgX, avgY, 16, 16);
    //}else{
    //  fill(crimson);
    //  ellipse(avgX, avgY, 16, 16);
    //}

  }
    
    //textSize(12);
    //text(this.avgX, this.avgX, this.avgY - 32);
    //text(this.avgY, this.avgX, this.avgY - 20);
  }
  
  void sampleColor(){
    //without horizontal flip the line below would read -> mouseX + mouseY * video.width
    this.loc = (video.width - mouseX -1) + mouseY * video.width; //same formula as above to get location
    this.trackColor = video.pixels[loc];
  }
  
  
  void collision(){
    //calculate necessary variables for collision
    //calculate distance between player and zone (1)
    this.zDist = dist(this.avgX, this.avgY, map.zoneX, map.zoneY); //need to change these mouse variables to incoming variables

    //calculate the new safe distance based on both radius (2)
    this.playerDist = this.zDist + this.size/2 - safety;

    //if the zone radius is larger than the distance from the player
    if (map.zoneSize/2 > this.playerDist) { //*note swap with zDist to make it easier
      this.isSafe = true;
      //println("safe");
    } else {
      this.isSafe = false;
      //println("danger");
    }
        ////debug line
    //stroke(sky);
    //strokeWeight(3);
    //line(avgX, avgY, map.zoneX, map.zoneY);
    
  }
}
