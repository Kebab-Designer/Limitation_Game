class Screen {

  //splashscreen on load
  void home() {

    //switch to leaderboard only when in homescreen
    if (key == 'c') {
      //leaderboard
      controls = true;
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
    blendMode(NORMAL);
    blendMode(DIFFERENCE);
    text("PLAY GAME   ( P )", 140, typoH);
    text("CONTROLS   ( C )", 500, typoH);
    blendMode(NORMAL);//reset blendmode for safety
  }

  //arraylist of leaderboard members
  void controls() {

    //array for description
    String[] controlList = new String[6];

    controlList[0] = "Start Game";
    controlList[1] = "Controls";
    controlList[2] = "Flush colors (reset colors)";
    controlList[3] = "Home";
    controlList[4] = " ";
    controlList[5] = "Sample colors";

    //array for shortcut
    String[] shortcuts = new String[6];

    shortcuts[0] = "( P )";
    shortcuts[1] = "( C )";
    shortcuts[2] = "( F )";
    shortcuts[3] = "( Q )";
    shortcuts[4] = " ";
    shortcuts[5] = "( Mouse click )";

    //show leaderboard
    if (controls) {
      //bg
      background(black);

      //gui
      textFont(h3);
      textSize(18);
      text("close   ( x )", 120, 120);

      //display controls
      for (int i = 0; i < controlList.length; i++) {
        text(controlList[i], 120, 200 + (24*i));
      }

      //display shortcuts
      for (int i = 0; i < shortcuts.length; i++) {
        text(shortcuts[i], 400, 200 + (24*i));
      }

      //x to close leaderboard
      if (key == 'x' || key == 'c') {
        controls = false;
      }
    }
  }

  void preGame() {
    background(0);
    //show video bg
    pushMatrix();
    scale(-1, 1);
    image(video, -video.width, 0, width, height); // draw video
    popMatrix();

    textFont(h3);
    textAlign(CENTER);
    text("Click on players to register", width/2, 80);
    text ("press SPACE to Start", width/2, height - 120);
    textSize(24);
    text("press ( f ) to flush colors", width/2, 120);
  }

  void youWon() {
    background(0);

    //text
    textFont(score);
    textMode(CENTER);
    textSize(400);
    text("WINS", width/2, height/2 + 124);

    textFont(h3);
    textMode(CENTER);
    text("press ( R ) for rematch", width/2, height - 120);
  }
}
