class TypingScreen extends Screen {
  String[] wordList = loadStrings("words.txt");
  ArrayList<Word> words;
  char letter;
  String word = "";
  String lastOpe ="";
  int speed = 1;
  int score;
  int level;
  
  int getId() {
    return 4;
  }
  
  TypingScreen() {
    words = new ArrayList<Word>();
    score = 0;
    level = 1;
  }
  
  void draw() {
    background(0);
    fill(255,0,0);
    text("SCORE : "+score,20,40);
    text("LEVEL : "+level,(width/2)-40,40);
    fill(0,255,255);
    text(lastOpe,width/8,height - (height/8) );
    fill(100,100,100);
    text("\nLetter = "+letter+"\nWord = "+word,width /3, height - (height/8));
    fill(0,0,255);
    
    if(words.size() < (2 + level)){
      words.add(createWord());
    }
    
    Iterator<Word> it = words.iterator();
    while(it.hasNext()) {
      Word nw = it.next();
      if(nw.x > width) {// remove the word if it's off screen and modify score
        if(!nw.isCorrect){
          background(255,0,0);
          score --;
        }
        else{
          background(0,255,0);
          score ++;
        } 
        it.remove();
      }
      nw.x += speed;
      text(nw.text, nw.x, nw.y+40);
    }
    
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
      speed += 0.5;
    }
  }
  
  void mouseClickHandler() {
  }
  
  void keyPressHandler() {
    if((int)key == 27) {        // ESC
      screenId = 1;     
      key = 0; // don't exit
    }
    else if((int)key == 8) {    // BS
      word = "";
    }
    else if((int)key == 10)     // Enter
    {
      int result = checkWord();
      if(result == 1)
          lastOpe = "The word \""+word+"\" is a good word !";
      else if( result == 0)
          lastOpe = "The word \""+word+"\" is spelled correctly but doesn't exist :s";
      else if( result == -1)
          lastOpe = "The word \""+word+"\" is mispelled :s";
      word = "";
      score += result;
      // add points if good  
    }
    else if( (((int)key >= 32) && ((int)key <= 122)) ){      // letter or a caractere or space
      letter = key;
      word = word+key;
    }
  }
  
  int checkWord(){
    Iterator<Word> it = words.iterator();
     while(it.hasNext()) {
      Word nw = it.next();
      if(nw.text.equals(word)) {
        if(!nw.isCorrect){
          it.remove();
          background(0,255,0);
          return 1;
        }
        else {
          it.remove();
          background(0,0,255);
          return 0;
        }
      }
     }
     background(255,0,0);
    return -1;
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
    temp.y = random(height - text.length() * 20);
    return temp;
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
}
