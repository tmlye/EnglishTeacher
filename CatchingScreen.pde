class CatchingScreen extends Screen {
  
  
  CatchingScreen() {
    
  }
  
  int getId() {
    return 2;
  }
  
  void draw() {
    background(0);
    
    fill(255);
    rect(width * 0.5, height * 0.5, 50, 50);
  }
  
  void mouseClickHandler() {
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
}
