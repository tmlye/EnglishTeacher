class TypingScreen extends Screen {
  String[] wordList = loadStrings("words.txt");
  ArrayList<Word> words;
  char letter;
  String word = "";
  String lastOpe ="";
  int speed = 1;
  int score;
  int frame = 0;
  int level;
  color colorTopBar=#F4FDFE;
  color colorScore=#1D709E;
  
  int getId() {
    return 4;
  }
  
  TypingScreen() {
    words = new ArrayList<Word>();
    score = 0;
    level = 1;
  }
  
  void draw() {
    background(#B6CEFF);
    
    // Display top bar
    fill(colorTopBar);
    stroke(0);
    rect(0,0,screenWidth,80);
    fill(colorScore);
    text("SCORE : "+score,(width/2)-200,40);
    text("LEVEL : "+level,(width/2)+100,40);
    
    
    
    // Display bottom bar
    fill(colorTopBar);
    rect(0,height-100,screenWidth,100);
    noStroke();
    fill(colorScore);
    text(lastOpe,width/5,height -20 );
    text("\nWord = "+word,width /5, height - 100);
    fill(0,0,255);
    
    if(words.size() < (2 + level)){
      words.add(createWord());
    }
    fill(#FA6900);
    Iterator<Word> it = words.iterator();
    while(it.hasNext()) {
      Word nw = it.next();
      if(nw.x > width) {                    // remove the word if it's off screen and modify score
        if(!nw.isCorrect){
          // Display ok image
          score --;
        }
        else{
          //Display ok image
          score ++;
        } 
        it.remove();
      }
      nw.x += speed;
      text(nw.text, nw.x, nw.y+40);
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
      speed += 0.5;
    }
    frame++;
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
          lastOpe = "The word \""+word+"\" is spelled correctly but doesn't exist !";
      else if( result == -1)
          lastOpe = "The word \""+word+"\" is mispelled !";
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
          // Display ok image
          return 1;
        }
        else {
          it.remove();
          // Display neutral image
          return 0;
        }
      }
     }
    //display bad image
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
    temp.y = 80+random(height-210);
    for(Word w: words){
     if( temp.y >= w.y && temp.y <= w.y+30 ){
       if(temp.y < height-160)
         temp.y += 30;
       else
         temp.y -= 30;
     }
     else if( temp.y <= w.y && temp.y+30 <= w.y ){
       if(temp.y > 80)
         temp.y -= 30;
       else
         temp.y += 30;
     }
    }
    return temp;
  }
  
  boolean eventHandler(int id, String eventName) {
    return false;
  }
}
