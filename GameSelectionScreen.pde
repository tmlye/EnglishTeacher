class GameSelectionScreen extends Screen {
  PImage chart;
  PImage logOffImg;
  PImage avatar;
  PImage[] gameIcons;
  int hoverIndex;// id of the icon the mouse is hovering over
  
  // COLORS
  color background = #E0E4CC;
  color foreground = #FA6900;
  color fontColor = #1D709E;
  color buttonBackground = #F4FDFE;
  color buttonFontColor = #1D709E;
  // Color when hovering:
  color buttonForegroundColor = #FA6900;
  color nameBackground = #000000;
  color line1Color = #FA6900;
  color line2Color = #000000;
  color line3Color = #A7DBD8;
  
  // FONTS
  PFont font = createFont("Helvetica", 20, true);
 
  // SIZES
  int buttonWidth = 110;
  int buttonHeight = 30;
  
  int gameIconSize = 200;
  
  // POSITIONS
  float leftPosition;
  float top;
  float leftColumn;
  float rightColumn;
  int distToLogOff = 40;
  int distBetweenRows = 100;
  
  int getId() {
    return 1;
  }
  
  void setName(String name) {
    // look for the name label
    for(Controller controller : elements) {
      if(controller.getName() == "nameLabel") {
        ((Textlabel)controller).setText(name);
        break;
      }
    }
    
    avatar = loadImage("gamePics/"+name + ".png");
  }
    
  GameSelectionScreen() {
    hoverIndex = -1;
    top = 0.1 * height + 68;
    leftColumn = 0.37 * width;
    rightColumn = 0.7 * width;
    leftPosition = 0.01 * width + 10;
   
    
    elements.add(
     cp5.addTextlabel("nameLabel")
       .setText(chosenName)
       .setPosition(leftPosition + 90, height * 0.5 - 55)
       .setColorValue(fontColor)
       .setFont(font));
       
    elements.add(
     cp5.addTextlabel("scoreLabel")
       .setText("0")
       .setPosition(leftPosition + 90, height * 0.5 - 25)
       .setColorValue(fontColor)
       .setFont(font));
    
    chart = loadImage("gamePics/chart.png");
    chart.resize(buttonHeight,buttonHeight);
    chart.filter(INVERT);
    
    logOffImg = loadImage("gamePics/back.png");
    logOffImg.filter(INVERT);
    logOffImg.resize(buttonHeight,buttonHeight);
        
    Button temp;
    temp =
      cp5.addButton("progress")
        .setId(11)
        .setPosition(leftPosition + 60, height * 0.7 - 40)
        .setSize(buttonWidth, buttonHeight)
        .setColorBackground(buttonBackground)
        .setColorCaptionLabel(buttonFontColor)
        .setColorForeground(buttonForegroundColor);
        
      temp
        .getCaptionLabel()
        .setText("Progress")
        .setFont(font)
        .align(ControlP5.LEFT, ControlP5.CENTER)
        .toUpperCase(false);
    
    elements.add(temp);
    
    temp =
     cp5.addButton("logoff")
        .setId(12)
        .setPosition(leftPosition + 60, height * 0.7 - 10 + distToLogOff)
        .setSize(buttonWidth, buttonHeight)
        .setColorBackground(buttonBackground)
        .setColorCaptionLabel(buttonFontColor)
        .setColorForeground(buttonForegroundColor);
        
      temp
        .getCaptionLabel()
        .setText("Log off")
        .setFont(font)
        .align(ControlP5.LEFT, ControlP5.CENTER)
        .toUpperCase(false);
        
    elements.add(temp);
    
    gameIcons = new PImage[4];
    for(int i = 0; i < 4; i++) {
      gameIcons[i] = loadImage("gamePics/gameIcon" + i + ".png");
    }
    
    // Top left
    elements.add(
     cp5.addTextlabel("game0Level")
       .setText("Catching")
       .setPosition(leftColumn, top + gameIconSize + 10)
       .setColorValue(fontColor)
       .setFont(font));
    // Bottom left
    elements.add(
     cp5.addTextlabel("game1Level")
       .setText("Spelling")
       .setPosition(leftColumn, top + 2 * gameIconSize + distBetweenRows + 10)
       .setColorValue(fontColor)
       .setFont(font));
    // Top right
    elements.add(
     cp5.addTextlabel("game2Level")
       .setText("True/False")
       .setPosition(rightColumn, top + gameIconSize + 10)
       .setColorValue(fontColor)
       .setFont(font));
    // Bottom right
    elements.add(
     cp5.addTextlabel("game3Level")
       .setText("New game")
       .setPosition(rightColumn, top + 2 * gameIconSize + distBetweenRows + 10)
       .setColorValue(fontColor)
       .setFont(font));
  }
  
  void draw() {
    updateHoverIndex(mouseX, mouseY);
    background(loadImage("gamePics/gameScreen.png"));
         
    image(avatar, leftPosition, top);
    
    // Top left game
    image(gameIcons[0], leftColumn, top, gameIconSize, gameIconSize);
    // Bottom left game
    image(gameIcons[1], leftColumn, top + distBetweenRows + gameIconSize, gameIconSize, gameIconSize);
    // Top right game
    image(gameIcons[2], rightColumn, top, gameIconSize, gameIconSize);
    // Bottom right game
    image(gameIcons[3], rightColumn, top + distBetweenRows + gameIconSize, gameIconSize, gameIconSize);
    
   // TODO enter game icon highlight code here  
  }
  
  void mouseClickHandler(){
    if(hoverIndex != -1) {      
       this.hideElements();
       screenId += hoverIndex + 1;
    }
  }
  
  void keyPressHandler() {
    if((int)key == 27) {
      // ESC
      hideElements();
      screenId = 0;
      key = 0; // don't exit
    }
  }

  // Sets hoverIndex to the game icon id of the icon
  // the mouse is hovering over.
  // Sets hoverIndex to -1 if it's not hovering over anything
  void updateHoverIndex(int x, int y) {
    int rowIndex = -1;
    if(y >= top && y <= top + gameIconSize) {
        // Top row
        rowIndex = 0;
    } else if (y >= top + gameIconSize + distBetweenRows &&
               y <= top + 2 * gameIconSize + distBetweenRows) {
        rowIndex = 1;
    }
    if(x >= leftColumn && x <= leftColumn + gameIconSize) {
      // We're in the left column
      if(rowIndex == 0) {
        hoverIndex = 0;
        return;
      } else if(rowIndex == 1) {
       hoverIndex = 1;
       return;
      }
    } else if (x >= rightColumn && x <= rightColumn + gameIconSize) {
      // We're in the right column
      if(rowIndex == 0) {
        hoverIndex = 2;
        return;
      } else if(rowIndex == 1) {
        hoverIndex = 3;
        return;
      }
    }
    
    hoverIndex = -1;
  }
  
  boolean eventHandler(int id, String eventName) {
    if(eventName == "logoff") {
      this.hideElements();
      screenId = 0;
      return true;
    }
    return false;
  }
}
