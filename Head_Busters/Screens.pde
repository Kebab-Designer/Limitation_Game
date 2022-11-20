class Screen {

  //splashscreen on load
  void home() {

    //switch to leaderboard only when in homescreen
    if (key == 'l') {
      //leaderboard
      leaderboard = true;
    }

    //bg
    background(black);

    //game title
    textFont(h1);
    textSize(94);
    textAlign(LEFT);
    fill(white);
    text("HEAD BUSTERS", 114, 440);

    //game details
    textFont(h3);
    textSize(18);
    text("Ferdi Pinarci   |   Game Frame 1", 118, height/2 - 8); 
    //dear stefan, ik this is not how im supposed to position the ui but if it works it works.

    //cta ----->
    //element
    blendMode(NORMAL);
    noFill();
    strokeWeight(2);
    stroke(white);
    
    int btnH = 480;

    //Start game
    rect(120, btnH, 320, 60);
    //hover
    if (mouseX >= 120 && mouseX <= 440) {
      if (mouseY > btnH && mouseY < btnH + 60) {
        fill(white);
        rect(120, btnH, 320, 60);
      }
    }

    //Leaderboard
    noFill();
    rect(480, btnH, 320, 60);
    //hover
    if (mouseX >= 480 && mouseX <= 800) {
      if (mouseY > btnH && mouseY < btnH + 60) {
        fill(white);
        rect(480, btnH, 320, 60);
      }
    }

    //typography
    int typoH = btnH + 40;
    textFont(h3);
    textSize(18);
    blendMode(DIFFERENCE);
    text("PLAY GAME   ( P )", 140, typoH);
    text("LEADERBOARD   ( L )", 500, typoH);
    blendMode(NORMAL);//reset blendmode for safety
  }

  //register the player names
  void register() {
    //
  }

  //arraylist of leaderboard members
  void leaderboard() {
    //show leaderboard
      if (leaderboard) {
        //bg
        background(black);
        
        //gui
        textFont(h3);
        textSize(18);
        blendMode(DIFFERENCE);
        text("close   ( x )", 120, 120);
  
        //x to close leaderboard
        if (key == 'x') {
          leaderboard = false;
        }
      }
  }
}
