import controlP5.*;
ControlP5 cp5;

int screenWidth = 1024;
int screenHeight = 768;

int screenId;
ArrayList<Controller> elements;
LoginScreen loginScreen;
String[] names;
String chosenName;
GameSelectionScreen gameSelectionScreen;

void setup() {
  size(screenWidth, screenHeight);
  noStroke();
  cp5 = new ControlP5(this);
  
  screenId = 0;
}

void draw() {
  if(screenId == 0) {
    if(loginScreen == null) {
      // runs for first time -> setup
      elements = new ArrayList<Controller>();
      loginScreen = new LoginScreen();
    }
    loginScreen.draw();
  } else if (screenId == 1) {
    if(gameSelectionScreen == null) {
      elements = new ArrayList<Controller>();
      gameSelectionScreen = new GameSelectionScreen(chosenName);
    }
    gameSelectionScreen.draw();
  }
}
  
// function controlEvent will be invoked with every value change 
// in any registered controller
public void controlEvent(ControlEvent event) {
  // call each screens handler and let them check if it
  // was their event and if so handle it
  boolean handled;
  if(loginScreen != null) {   
      handled = loginScreen.login(event.getId(), event.getName());
      if(handled) println("Handled by login screen");
  }
}
