class CatchingScreen extends Screen {
  
  ArrayList<Word> words;

    
  int speed ; // larger means faster
  int wordRate = 15; // larger means less words
  int frame = 0;
  int level = 0;
  float scale = 1.6;
  int score = 0;
  int lastAnswer = 2;
  int nbFrameAnswer = 0;
  
  float controllerPosition = width / 2;
  int controllerSpeed = 60;
  int controllerWidth = 200;
  int controllerHeight = 30;
  
  color controllerColor = #FA6900;
  color colorTopBar=#F4FDFE;
  color colorScore=#1D709E;
  
  color background = #E0E4CC;
  
  PImage cross = loadImage("gamePics/cross.png");
  PImage tick = loadImage("gamePics/tick.png");
  PImage neutral = loadImage("gamePics/minus.png");
  
  String[] wordList = loadStrings("words.txt");
  PFont font = createFont("Helvetica", 20, true);
  color fontColor = #000000;
  
  boolean controllerIsKeyboard = false;
  Rectangle[] fists;
  
  CatchingScreen() {
    words = new ArrayList<Word>();
  }
  
  int getId() {
    return 2;
  }
  
  void draw() {
    
    background(background);
    if(frame % wordRate == 0) {
      words.add(createWord());
    }
    
    if(cam.available()==true)
      cam.read();
    opencv.loadImage(cam);
    fists = opencv.detect();
    
    scale(scale);
    // Display Cam
    image(opencv.getOutput(),0,0);
    // Display Fist Recognition
    noFill();
    stroke(0,255,0);
    strokeWeight(3);
    if(fists.length > 0){
      for (int i=0; i<fists.length ; i++){
        rect(fists[i].x,fists[i].y,fists[i].width,fists[i].height);
      }
    } 
    scale(1/scale);
    
    // Display words
    frame ++;
    speed = 3+(level/2);
    controllerWidth = 200-((level-1)*20);
    
    Iterator<Word> it = words.iterator();
    while(it.hasNext()) {
      Word word = it.next();
      if(word.y > height) {// remove the word if it's off screen
        it.remove();
      }
      fill(#FA6900);
      text(word.text, word.x, word.y);
      word.y += speed;
    }
    
    noStroke();
    
    // Display top bar
    fill(colorTopBar);
    rect(0,0,screenWidth,80);
    fill(colorScore);
    text("SCORE : "+score,(width/2)-200,30);
    text("LEVEL : "+level,(width/2)+100,30);
    stroke(fontColor);
    fill(fontColor);
    
    fill(controllerColor);
    rect(controllerPosition - controllerWidth / 2, height - controllerHeight,
         controllerWidth, controllerHeight);
    
    
    if(fists.length != 0)
      controllerPosition = fists[0].x*scale;
      
    controllerTouchWord();
    
    // Instructions
    if(frame<50){
      stroke(0);
      fill(255);
      rect(width/2-350,height/2-25,700,100);
      fill(0);
      text("Press esc to exit the game\n",width/2-150,height/2+10);
      text("[INSERT GAME INSTRUCTIONS IN NATIVE LANGUAGE]\n",width/2-340,height/2+50);
    }
    
    if(nbFrameAnswer < 10 && lastAnswer !=2){
      displayAnswer(lastAnswer);
      nbFrameAnswer ++;
    }
    else{
      nbFrameAnswer = 0;
      lastAnswer = 2;
    }
    // Scores
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
    if(controllerIsKeyboard){
      if(key == 'h' || key == 'q') {
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
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
  boolean controllerTouchWord(){
    Iterator<Word> it = words.iterator();
    int result;
    while(it.hasNext()) {
      Word word = it.next();
      if( (word.y >= height-controllerHeight) && ((word.x+(word.text.length()*10)) > (controllerPosition - controllerWidth / 2) && word.x < (controllerPosition + controllerWidth/2)) ) {
        if(!word.isCorrect){
          lastAnswer = 1;
          score++;
        }
        else{
          lastAnswer = -1;
          score--;
        }
        it.remove();
        return true;
      }
    }
    return false;
  }
  
  void displayAnswer(int i){
    if(i == 1)
      image(tick,width-250,80);
    if(i == 0)
      image(neutral,width-250,80);
    if(i == -1)
      image(cross,width-250,80);
    //nbFrameAnswer = 0;
  }
  
  Word createWord() {
    String text = wordList[int(random(wordList.length))];
    
    boolean wordIsWrong = false;
    if(!boolean(int(random(0,4)))) {
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
