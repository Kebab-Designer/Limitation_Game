//create player
Player player1;

//initialize map
Map level;

PFont score;

void setup() {
  size(800, 600);
  frameRate(60);

  player1 = new Player(0, 0, 80, 0, 0);
  
  //create the level
  level = new Map();
  //the created map is the level instance
  player1.map = level;
    
  score = createFont("montserrat black", 240);
}

void draw() {

  // 0. Set the stage level and difficulty(0, 1, 2 etc.)



  // 1. Where is the Zone
  // 2. Where is the player
  // 3. Check the timer
  // 4. If timer has run out check if player is safe

  //if all players are safe
  //congratulate players //wait a few sec
  //restart the process at step 0.

  //if one player not safe
  //announce the other player has won
  //optional -> advance to next level

  //after all of this -> start drawing


  background(black);
  
  //logic timer
 
  
  //display timer
  textFont(score);
  textAlign(CENTER);
  fill(12);
  text("5", width/2, height/2 + 80);

  level.display();

  player1.move();
  player1.display();

  //Gui -----v

  
}
