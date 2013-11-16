class SpeakingScreen extends Screen {
  
  int getId() {
    return 5;
  }
  
  SpeakingScreen() {
  }
  
  void draw() {
    background(0);
    text("This is the speaking game.\nIt's not implemented. Sorry.", width / 2, height / 2);
  }
  
  void mouseClickHandler() {
  }
  
  void keyPressHandler() {
    if((int)key == 27) {
      // ESC
      screenId = 1;     
      key = 0; // don't exit
    }
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
}
