class LoginScreen {
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
  PFont nameListFont = createFont("Helvetica", 26, true);
 
  // SIZES  
  int buttonWidth = 100;
  int buttonHeight = 30;
  
  int nameButtonWidth = 200;
  int nameButtonHeight = 50;
  
  int nameListWidth= 200;
  int nameListHeight = 300;
      
  LoginScreen() {   
   elements.add(
     cp5.addTextlabel("pickNameLabel")
       .setText("Pick your name")
       .setPosition(width * 0.1,height * 0.3)
       .setColorValue(fontColor)
       .setFont(font));
   
   elements.add(
     cp5.addTextlabel("orLabel")
       .setText("or")
       .setPosition(width * 0.1,height * 0.3 + 100)
       .setColorValue(fontColor)
       .setFont(font));
   
   elements.add(
     cp5.addTextlabel("addItLabel")
       .setText("Add it")
       .setPosition(width * 0.1,height * 0.3 + 200)
       .setColorValue(fontColor)
       .setFont(font));
  
    float bPH = 0.6 * width;
    float bPV = 0.3 * height + 2;
    
    names = new String[] { "Albrecht", "William", "jhg" };
    
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
    background(background);
    
     stroke(line1Color);
     fill(line1Color);
     rect(0.35 * width, 0,  5, height);
     stroke(line2Color);
     fill(line2Color);
     rect(0.35 * width + 5, 0,  5, height);
     stroke(line3Color);
     fill(line3Color);
     rect(0.35 * width + 10, 0,  5, height);
  }
  
  // Returns true if the fired event was on LoginScreen
  boolean login(int eventId, String eventName){
     if(eventId < names.length) {
       chosenName = eventName;
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
