//create player
Player player1;

Map level;

void setup() {

  /* PFont score;
   createFont("montserrat", 128); */

  size(800, 600);
  player1 = new Player(0, 0, 80, 0, 0);
  level = new Map();
  
  player1.map = level; //the created map is the level instance
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
      
  
  background(black);

  level.display();

  player1.move();
  player1.display();
}
