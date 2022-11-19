float itemSpawn;
int itemHeight;

boolean collected;

class Item{
  void generate(){
    
    itemSpawn = random(0, width);
    itemHeight = 0;

  }
  
  void display(){
    noStroke();
    fill(honey);
    circle(itemSpawn, itemHeight +=2, 40);
    
    //itemdebugging
    stroke(255);
    strokeWeight(2);
    line(itemSpawn, itemHeight, mouseX, mouseY);
    
  }
}
