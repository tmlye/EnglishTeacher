color colorTopBar=#F4FDFE;
color colorScore=#1D709E;
int score;
int level = 1;
int frame = 0;

int currentWordIndex;
boolean wasWordCorrect;


STT stt;

class SpeakingScreen extends Screen {
  
  int getId() {
    return 5;
  }
  
  SpeakingScreen() {
    stt.enableDebug();
    stt.setLanguage("en");
    stt.disableAutoThreshold();
    stt.enableAutoRecord(6);
    
    currentWordIndex = (int)random(wordList.length);
    score = 0;
  }
  
  void draw() {
    frame++;
    if(result != null && result.equals(wordList[currentWordIndex])) {
      score++;
      currentWordIndex = (int)random(wordList.length);
      result = null;
      wasWordCorrect = true;
    }
    
    background(#B6CEFF);
    
    // Display top bar
    fill(colorTopBar);
    stroke(0);
    rect(0,0,screenWidth,80);
    fill(colorScore);
    text("SCORE : "+score,(width/2)-200,40);
    text("LEVEL : "+level,(width/2)+100,40);
    
    text(wordList[currentWordIndex], width / 2 - wordList[currentWordIndex].length() * 10, height / 2 - 50);
    
    if(result != null) {
      text("You said: " + result, width / 2 - result.length() * 10 - 100, height / 2 + 100);
    } else {
      text("Sorry, I couldn't understand.\nPlease try again.", width / 2 - 200, height / 2 + 100);
    }
    
    // Instructions
    if(frame<100){
      stroke(0);
      fill(255);
      rect(width/2-350,height/2-25,700,100);
      fill(0);
      text("Press esc to exit the game\n",width/2-150,height/2+10);
      text("[INSERT GAME INSTRUCTIONS IN NATIVE LANGUAGE]\n",width/2-340,height/2+50);
    }
  }
  
  void mouseClickHandler() {
  }
  
  void keyPressHandler() {
    if((int)key == 27) {
      // ESC
      screenId = 1;     
      key = 0; // don't exit
    } else if((int)key == 32) {
      // skip word with space
      currentWordIndex = (int)random(wordList.length);
    }
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
}
