import java.awt.Rectangle;

class SlicingScreen extends Screen {

  ArrayList<Rectangle> rectList;
  Rectangle[] fists;
  String[] wordList = loadStrings("words.txt");
  Word word = createWord();
  int updImage=0;
  
  int score = 0;
  int level = 1;
  int frame = 0;
  
  color colorTopBar=#F4FDFE;
  color colorScore=#1D709E;
  
  int getId() {
    return 3;
  }
  
  SlicingScreen() {
  }
  
  void draw() {
    background(0);
    if(cam.available()==true)
      cam.read();
    scale(1.6);
    opencv.loadImage(cam);
    fists = opencv.detect();
    
    // Display Cam
    image(cam,0,0);
    
    // Display Fist Recognition
    noFill();
    stroke(0,255,0);
    strokeWeight(3);
    //println("Length fists = "+fists.length);
    if(fists.length > 0){
      for (int i=0; i<fists.length ; i++){
        rect(fists[i].x,fists[i].y,fists[i].width,fists[i].height);
      }
    }
    scale(1/1.6);
    
    // Display top bar
    stroke(0,0,0);
    fill(colorTopBar);
    line(screenWidth/2,40,screenWidth/2,screenHeight);
    rect(0,0,screenWidth,80);
    fill(colorScore);
    text("SCORE : "+score,(width/2)-200,30);
    text("LEVEL : "+level,(width/2)+100,30);
    fill(#FA6900);
    text(word.text,(screenWidth/2)-(word.text.length()*6),70);
    fill(0,255,0);
    text("TRUE",200,70);
    fill(255,0,0);
    text("FALSE",screenWidth-240,70);
    
    // Check Choice
    if(updImage%20==0){
      if(correctChoice() == 1){
        score++;
        // Display good image
        word = createWord();
      }
      else if(correctChoice() == -1){
        score--;
        // Display bad image
        word = createWord();
      }
    }
    updImage++;
    
    // Instructions
    if(frame<50){
      stroke(0);
      fill(255);
      rect(width/2-350,height/2-25,700,100);
      fill(0);
      text("Press esc to exit the game\n",width/2-150,height/2+10);
      text("[INSERT GAME INSTRUCTIONS IN NATIVE LANGUAGE]\n",width/2-340,height/2+50);
    }
    
    // Levels
    if(score <10)
      level = 1;
    if(score > 10 && score < 20)
      level = 2;
    if(score > 20 && score < 30)
      level = 3;
    if(score > 30 && score < 40)
      level = 4;
    if(score>40)
      level = 5;
      
    frame++;
  }
  
  
  int correctChoice(){
    rectList = new ArrayList<Rectangle>(Arrays.asList(fists));
    if(rectList.size() != 0){
      if( (!word.isCorrect && isLeftSide(rectList.get(0))) || (word.isCorrect && !isLeftSide(rectList.get(0))) )
        return 1;
      else
        return -1;
    }
    return 0;
  }
  
  boolean isLeftSide(Rectangle r){
    return r.x+r.width <= screenWidth/2;
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
