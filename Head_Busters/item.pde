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
    circle(itemSpawn, itemHeight ++, 40);
    
  }
}
