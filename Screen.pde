abstract class Screen {
  ArrayList<Controller> elements = new ArrayList<Controller>();
  abstract int getId();
  abstract void draw();
  abstract void mouseClickHandler();
  abstract void keyPressHandler();
  abstract boolean eventHandler(int id, String eventName);
  
  void hideElements() {
    for(Controller ele : elements) {
         ele.hide();
    }
  }
  
  void showElements() {
    for(Controller ele : elements) {
         ele.show();
    }
  }
}
