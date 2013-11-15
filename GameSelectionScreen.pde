class GameSelectionScreen {
  String chosenName;
  PImage chart;
  PImage logOffImg;
  PImage avatar;
  PImage[] gameIcons;
  
  // COLORS
  color background = #E0E4CC;
  color foreground = #FA6900;
  color fontColor = #000000;
  color buttonBackground = #000000;
  color buttonFontColor = #EEEEEE;
  // Color when hovering:
  color buttonForegroundColor = #FA6900;
  color nameBackground = #000000;
  color line1Color = #FA6900;
  color line2Color = #000000;
  color line3Color = #A7DBD8;
  
  // FONTS
  PFont font = createFont("Helvetica", 20, true);
 
  // SIZES
  int buttonWidth = 150;
  int buttonHeight = 30;
  
  int gameIconSize = 200;
  
  // POSITIONS
  float leftPosition;
  float top;
  float leftColumn;
  float rightColumn;
  int distToLogOff = 60;
  int distBetweenRows = 120;
    
  GameSelectionScreen(String chosenName) {
    top = 0.1 * height;
    leftColumn = 0.37 * width;
    rightColumn = 0.7 * width;
    leftPosition = 0.01 * width;
   
    avatar = loadImage(chosenName + ".jpg");
    
    elements.add(
     cp5.addTextlabel("nameLabel")
       .setText("Name: " + chosenName)
       .setPosition(leftPosition, height * 0.5)
       .setColorValue(fontColor)
       .setFont(font));
       
    elements.add(
     cp5.addTextlabel("scoreLabel")
       .setText("Score: 0")
       .setPosition(leftPosition, height * 0.5 + 30)
       .setColorValue(fontColor)
       .setFont(font));
    
    chart = loadImage("chart.png");
    chart.resize(buttonHeight,buttonHeight);
    chart.filter(INVERT);
    
    logOffImg = loadImage("back.png");
    logOffImg.filter(INVERT);
    logOffImg.resize(buttonHeight,buttonHeight);
        
    Button temp;
    temp =
      cp5.addButton("progress")
        .setId(11)
        .setPosition(leftPosition + chart.width, height * 0.7)
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
        .setPosition(leftPosition + chart.width, height * 0.7 + distToLogOff)
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
      gameIcons[i] = loadImage("gameIcon" + i + ".jpg");
    }
    
    // Top left
    elements.add(
     cp5.addTextlabel("game0Level")
       .setText("Level: 1")
       .setPosition(leftColumn, top + gameIconSize + 10)
       .setColorValue(fontColor)
       .setFont(font));
    // Bottom left
    elements.add(
     cp5.addTextlabel("game1Level")
       .setText("Level: 3")
       .setPosition(leftColumn, top + 2 * gameIconSize + distBetweenRows + 10)
       .setColorValue(fontColor)
       .setFont(font));
    // Top right
    elements.add(
     cp5.addTextlabel("game2Level")
       .setText("Level: 3")
       .setPosition(rightColumn, top + gameIconSize + 10)
       .setColorValue(fontColor)
       .setFont(font));
    // Bottom right
    elements.add(
     cp5.addTextlabel("game3Level")
       .setText("Level: 7")
       .setPosition(rightColumn, top + 2 * gameIconSize + distBetweenRows + 10)
       .setColorValue(fontColor)
       .setFont(font));
  }
  
  void draw() {
    background(background);
    
    image(avatar, leftPosition, top, 230, 300);
    
    noStroke();
    fill(0);
    rect(leftPosition, height * 0.7, chart.width, chart.height);    
    image(chart, leftPosition, height * 0.7);
    
    noStroke();
    fill(0);
    rect(leftPosition, height * 0.7 + distToLogOff, logOffImg.width, logOffImg.height);
    image(logOffImg, leftPosition, height * 0.7 + distToLogOff);
    
    // Top left game
    image(gameIcons[0], leftColumn, top, gameIconSize, gameIconSize);
    // Bottom left game
    image(gameIcons[1], leftColumn, top + distBetweenRows + gameIconSize, gameIconSize, gameIconSize);
    // Top right game
    image(gameIcons[2], rightColumn, top, gameIconSize, gameIconSize);
    // Bottom right game
    image(gameIcons[3], rightColumn, top + distBetweenRows + gameIconSize, gameIconSize, gameIconSize);
    
    float lPH = 0.25 * width;
    stroke(line1Color);
    fill(line1Color);
    rect(lPH, 0,  5, height);
    stroke(line2Color);
    fill(line2Color);
    rect(lPH + 5, 0,  5, height);
    stroke(line3Color);
    fill(line3Color);
    rect(lPH + 10, 0,  5, height);
  }
  
}
