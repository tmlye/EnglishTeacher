class CatchingScreen extends Screen {
  String[] wordList = loadStrings("words.txt");
  ArrayList<Word> words;
  int speed = 1; // larger means faster
  int wordRate = 70; // larger means less words
  int frame = 0;
  
  int level = 0;
  int score = 0;
  
  float controllerPosition = width / 2;
  int controllerSpeed = 60;
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
    speed = 1+(level/2);
    controllerWidth = 200-((level-1)*20);
    background(background);
    
    if(frame % wordRate == 0) {
      words.add(createWord());
    }
    fill(255,0,0);
    text("SCORE : "+score,20,40);
    text("LEVEL : "+level,(width/2)-40,40);
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
         
    controllerTouchWord();
    
    if(score <10)
      level = 1;
    if(score > 10 && score < 20)
      level = 2;
    if(score > 20 && score < 30)
      level = 3;
    if(score > 30 && score < 40)
      level = 4;
    if(score>40){
      level = 5;
      //speed += 0.5;
    }
    
  }
  
  void mouseClickHandler() {
  }
  
  void keyPressHandler() {
    if((int)key == 27) {
      // ESC
      screenId = 1;
      words.clear();
      key = 0; // don't exit
    } 
    else if(key == 'h' || key == 'q') {
      if(controllerPosition - controllerWidth / 2 < 0) {
        return;
      }
      controllerPosition -= controllerSpeed;
    } 
    else if(key == 'l' || key=='d') {
      if(controllerPosition + controllerWidth / 2 > width) {
        return;
      }
      controllerPosition += controllerSpeed;
    }
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
  boolean controllerTouchWord(){
    Iterator<Word> it = words.iterator();
    int result;
    while(it.hasNext()) {
      Word word = it.next();
      if( (word.y == height-controllerHeight ) && ((word.x+(word.text.length()*10)) > (controllerPosition - controllerWidth / 2) && word.x < (controllerPosition + controllerWidth/2)) ) {
        if(!word.isCorrect){
          background(0,255,0);
          score++;
        }
        else{
          score--;
          background(255,0,0);
        }
        it.remove();
        return true;
      }
    }
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
