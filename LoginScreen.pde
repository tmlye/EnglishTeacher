class LoginScreen extends Screen {
  // COLORS
  color background = #E0E4CC;
  color foreground = #FA6900;
  color fontColor = #000000;
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
  PFont nameListFont = createFont("Helvetica", 26, true);
 
  // SIZES  
  int buttonWidth = 100;
  int buttonHeight = 30;
  
  int nameButtonWidth = 200;
  int nameButtonHeight = 50;
  
  int nameListWidth= 200;
  int nameListHeight = 300;
  
  int getId() {
    return 0;
  }
      
  LoginScreen() {   
    float bPH = 0.4 * width;
    float bPV = 0.3 * height + 2;
    
    names = new String[] { "Hadrien", "Ian", "Sascha" , "Sophie" };
    
    Button temp;
    for(int i = 0; i < names.length; i++) {
      temp =
        cp5.addButton(names[i])
          .setId(i)
          .setPosition(bPH , bPV + i * nameButtonHeight)
          .setSize(nameButtonWidth, nameButtonHeight)
          .setColorBackground(buttonBackground)
          .setColorForeground(buttonForegroundColor)
          .setColorCaptionLabel(buttonFontColor);
          
        temp
          .getCaptionLabel()
          .setText(names[i])
          .setFont(nameListFont)
          .align(ControlP5.CENTER, ControlP5.CENTER)
          .toUpperCase(false);
          
        elements.add(temp);
    }
    
    temp =
      cp5.addButton("addNew")
       .setId(names.length)
       .setPosition(bPH, bPV + names.length * nameButtonHeight + 50)
       .setSize(nameButtonWidth, nameButtonHeight)
       .setColorBackground(buttonBackground)
       .setColorCaptionLabel(buttonFontColor)
       .setColorForeground(buttonForegroundColor);
       
     temp
       .getCaptionLabel()
       .setText("Add New")
       .setFont(nameListFont)
       .align(ControlP5.CENTER, ControlP5.CENTER)
       .toUpperCase(false);
       
     elements.add(temp);
  }
  
  void draw() {
     background(loadImage("gamePics/startScreen.png"));
  }
  
  void mouseClickHandler() {
  }
  
  void keyPressHandler() {
  }
  
  // Returns true if the fired event was on LoginScreen
  boolean eventHandler(int eventId, String eventName){
     if(eventId < names.length) {
       chosenName = eventName;
       // not very good practice
       ((GameSelectionScreen)screens.get(1)).setName(eventName);
       screenId++;
       for(Controller ele : elements) {
         ele.hide();
       }
       return true;
     } else if (eventName == "addNew") {
       // add code for adding new name here
       // don't let user add more than 9 names
       // because this screen only has ids 0-9 available
       return true;
     }
     
     return false;
  }
}
