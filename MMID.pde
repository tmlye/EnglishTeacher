import gab.opencv.*;
import processing.video.*;
import controlP5.*;
import java.util.*;
import com.getflourish.stt.*;
import ddf.minim.Minim;

String result;

ControlP5 cp5;

int screenWidth = 1024;
int screenHeight = 768;

int screenId;
HashMap<Integer,Screen> screens;

String[] names;
String chosenName;

String[] wordList;

Capture cam;
OpenCV opencv;

void setup() {
  wordList = loadStrings("words.txt");
  //frameRate(1000);
  size(screenWidth, screenHeight);
  noStroke();
  cp5 = new ControlP5(this);
  stt = new STT(this);
  
  screens = new HashMap<Integer, Screen>();
  screens.put(0, new LoginScreen());
  screens.put(1, new GameSelectionScreen());
  screens.put(2, new CatchingScreen());
  screens.put(4, new SlicingScreen());
  screens.put(3, new TypingScreen());
  screens.put(5, new SpeakingScreen());
  
  
  for(Screen screen : screens.values()) {
    screen.hideElements();
  }
  
  screenId = 0;
  
  cam = new Capture(this,640,480);
  cam.start();
  opencv = new OpenCV(this,640,480);
  opencv.loadCascade("aGest.xml");
}

void draw() {
  Screen currentScreen = screens.get(screenId);
  currentScreen.showElements();
  currentScreen.draw();
}

// gets gets called every time the mouse is pressed 
void mousePressed() {
  screens.get(screenId).mouseClickHandler();
}

void keyPressed() {
  screens.get(screenId).keyPressHandler();
}
  
// function controlEvent will be invoked with every value change 
// in any registered controller
public void controlEvent(ControlEvent event) {
  // call each screens handler and let them check if it
  // was their event and if so handle it
  boolean handled;
  for(Screen screen : screens.values()) {
    handled = screen.eventHandler(event.getId(), event.getName());
    if(handled) break;
  }
}

// Method is called if STT transcription was successfull 
void transcribe (String utterance, float confidence) 
{
  println(utterance);
  result = utterance;
}
  
  
  
