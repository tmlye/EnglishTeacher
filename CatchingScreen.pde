class CatchingScreen extends Screen {
  String[] wordList = loadStrings("words.txt");
  ArrayList<Word> words;
  int speed = 1; // larger means faster
  int wordRate = 70; // larger means less words
  int frame = 0;
  
  float controllerPosition = width / 2;
  int controllerSpeed = 20;
  int controllerWidth = 200;
  int controllerHeight = 30;
  color controllerColor = #FA6900;
  
  color background = #E0E4CC;
  
  PFont font = createFont("Helvetica", 20, true);
  color fontColor = #000000;
  
  CatchingScreen() {
    words = new ArrayList<Word>();
  }
  
  int getId() {
    return 2;
  }
  
  void draw() {
    frame++;
    background(background);
    
    if(frame % wordRate == 0) {
      words.add(createWord());
    }
    
    stroke(fontColor);
    fill(fontColor);
    
    Iterator<Word> it = words.iterator();
    while(it.hasNext()) {
      Word word = it.next();
      if(word.y > height) {// remove the word if it's off screen
        it.remove();
      }
      word.y += speed;
      text(word.text, word.x, word.y);
    }
    
    noStroke();
    fill(controllerColor);
    rect(controllerPosition - controllerWidth / 2, height - controllerHeight,
         controllerWidth, controllerHeight);
  }
  
  void mouseClickHandler() {
  }
  
  void keyPressHandler() {
    if((int)key == 27) {
      // ESC
      screenId = 1;
      words.clear();
      key = 0; // don't exit
    } else if(key == 'h') {
      if(controllerPosition - controllerWidth / 2 < 0) {
        return;
      }
      controllerPosition -= controllerSpeed;
    } else if(key == 'l') {
      if(controllerPosition + controllerWidth / 2 > width) {
        return;
      }
      controllerPosition += controllerSpeed;
    }
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
  
  Word createWord() {
    String text = wordList[int(random(wordList.length))];
    
    boolean wordIsWrong = false;
    if(boolean(int(random(0,2)))) {
      // replace random character with random character
      char[] tempArray = text.toCharArray();
      char randomChar = (char)((int)'a' + random(1) * ((int)'z' - (int)'a' + 1));
      tempArray[int(random(tempArray.length))] = randomChar;
      text = new String(tempArray);
      wordIsWrong = true;
    }
    
    Word temp = new Word(text, wordIsWrong);
    temp.x = random(width - text.length() * 20);
    return temp;
  }
}
