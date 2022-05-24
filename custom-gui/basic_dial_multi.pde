/**************************************************************
 Project:  generalize a dial with control for multiple values
           from a prior project.
           
 Date:     May 23, 2022
 Author:   Yahir
 
 About:    This was used in my Terrain project and was a good
           way to manipulate multiple values in a compact way. 
 
 Notes:
           - Processing 3.5.4
 **************************************************************/
 
Dial dial;           // dial object
float alphaValue;    // alpha value to be controlled by dial value [0]
float rectSize;      // size value to be controlled by dial value [1]
float strokeSize;    // stroke value to be controlled by dial value [2]

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(600, 300);
 
  // initialize
  alphaValue = 155;
  rectSize = 200;
  strokeSize = 1;
  
  // create buttons for dial
  ButtonDial[] btns = new ButtonDial[]{
    new ButtonDial("alpha", "adjust alpha value", true, 0, 255, alphaValue),
    new ButtonDial("size", "set rectangle size", false, 150, 250, rectSize),
    new ButtonDial("stroke", "set the stroke size", false, 0, 10, strokeSize)};
 
  // initialize with position x, y, name, and buttons
  dial = new Dial(150, 150, "", btns);
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(255);
 
  // display and update values to desired variables
  dial.display();
  alphaValue = dial.getValue(0);
  rectSize = dial.getValue(1);
  strokeSize = dial.getValue(2);
 
  // display rect for fill example
  stroke(0);
  strokeWeight(strokeSize);
  fill(0, alphaValue);
  rectMode(CENTER);
  rect(450, 150, rectSize, rectSize);
}
 
/**************************************************************
 MOUSE CLICKED FUNCTION
 
 update dial/buttons on click
 **************************************************************/
void mouseClicked() {
 dial.updateButtonState();
}

/*
 * Class for creating a basic round dial that can control
 * multiple values by using the buttonDial class
 */
class Dial {
  int x, y;                  // Center position of dial
  String name;               // name of button
  String description;        // optional description for button
  int valueIndex;            // track which button is active
  int numButtons;            // set to number of buttons (max 3)
  int len;                   // Radius of dial
  int diam;                  // Diameter of dial
  float angle;               // Angle for rotation
  float rval;                // Raw value of angular rotation
  float dialValue;           // Value to be used between min and max
  float dialMin, dialMax;    // Min and max range of dial
  int nameSize;              // text size for name
  int valueSize;             // text size for value
  
  color cBackground;         // background color
  color cForeground;         // foregournd color
  color cName;               // name color
  color cValue;              // value color
  color cActive;             // color when dial active

  ButtonDial[] buttons;      // array of buttons to hold additional values
  
  /*
   * Constructor method for setting x and y position of node
   *
   * @param: _x        x position CENTER
   * @param: _y        y position CENTER
   * @param: _name     name of dial
   * @param: _buttons  array of buttonDials to control multiple values
   *
   */
  Dial(int _x, int _y, String _name, ButtonDial[] _buttons) {
    x = _x;
    y = _y;
    len = 100;
    diam = 100 * 2;
    name = _name;   
    numButtons = _buttons.length;   
          
    buttons = _buttons;
    int xoff = x - 25;
    int yoff = y + len - 10;
    if(numButtons == 1) {
      buttons[0].setPosition(xoff, yoff);
    }
    else if(numButtons == 2) {
      buttons[0].setPosition(xoff - 50, yoff);
      buttons[1].setPosition(xoff + 50, yoff);
    } else {    
      buttons[0].setPosition(xoff - 50, yoff);
      buttons[1].setPosition(xoff, yoff);
      buttons[2].setPosition(xoff + 50, yoff);     
    }
     
    valueIndex = 0;
    dialValue = buttons[valueIndex].getValue();
    dialMin = buttons[valueIndex].getMin();
    dialMax = buttons[valueIndex].getMax();
   
    // map position bases on min, max, and start value of current button
    rval = map(dialValue, dialMin, dialMax, 135, 405);
    angle = rval;
   
    // style elements
    nameSize = 18;
    valueSize = 12;
    cBackground = color(220);
    cForeground = color(150);
    cName = color(80);
    cValue = color(100);
    cActive =color(0);      
  }
  
  /**
  * set the value index
  *
  * @ param _index        integer between 0 and 3
  */
  void setIndex(int _index) {
    valueIndex = _index;
  }
 
  /**
  * get the value at index
  *
  * @param _index      integer between 0 and 3
  * @return            the value at _index
  */
  float getValue(int _index) {
    return buttons[_index].getValue();
  } 
 
  /**
  * Update dial values and elements
  */
  void update() {
    // if selected calculate angle to determine value setting
    
    if (selected()) {
      angle = ((degrees(atan2(mouseY - y, mouseX - x)) + 720) % 360);
    }
   
    // adjust for angle 0 location
    if (angle >= 0 && angle <= 90) {
      rval = 360 + angle;
    } else {
      rval = angle;
    }

    if (rval < 135) {
      rval = 135;
      angle = 135;
    }
    if (rval > 405) {
      rval = 405;
      angle = 45;
    }
   
    // map dial value as desired
    dialValue = map(rval, 135, 405, dialMin, dialMax);
    buttons[valueIndex].setValue(dialValue);
  }
 
  /**
  * display dial elements
  */
  void display() {  
    update();
    
    // visually display total dial value range
    noStroke();  
    noFill();
    stroke(cBackground);
    strokeWeight(5);
    arc(x, y, diam, diam, radians(135), radians(405));

    // visually display current dial value  
    strokeWeight(9);
    stroke(cForeground);
    if(active()) {
      stroke(cActive);
    }
    arc(x, y, diam, diam, radians(135), radians(rval));
   
    // text settings to display dial name and value
    textAlign(CENTER, CENTER);
    textSize(nameSize);
   
    // position name and display
    float nameY = y + sin(radians(135)) * len;
    fill(cName);
    if(active()) {
      fill(cActive);
    }
    text(name, x , nameY);
     
    // round and display value
    textSize(valueSize);
    float displayValue = (float)(Math.round(dialValue * Math.pow(10, 1)) / Math.pow(10, 1));                
    fill(cValue);
    if(active()) {
      fill(cActive);
    }
    text(Float.toString(displayValue), x, y);
    
    // display buttons and description when active
    for(int i = 0; i < buttons.length; i++) {
      buttons[i].display();
      if(buttons[i].active()) {
        text(buttons[i].getDescription(), x, y + len + 25);
      }
    }
       
    // Reset values to avoid impact other sketch elements
    strokeWeight(1);
  }
 
  /**
  * check and update buttons as necessary.
  * place this in mouseClicked
  *
  */
  void updateButtonState() {
    for(int i = 0; i < buttons.length; i++) {
      if(buttons[i].active()) {
        valueIndex = i;
        buttons[i].state = true;  
      }
    }
    
    for(int i = 0; i < buttons.length; i++) {
      if(valueIndex != i) {
        buttons[i].state = false;  
      }
    }
    dialMin = buttons[valueIndex].getMin();
    dialMax = buttons[valueIndex].getMax();
    dialValue = buttons[valueIndex].getValue();
    rval = map(dialValue, dialMin, dialMax, 135, 405);
    angle = rval;
  }
 
  /**
  * Check if the mouse is within area of dial
  *
  * @return true if within area else false
  */
  boolean active() {
    if (abs(dist(mouseX, mouseY, x, y)) < 110 && mouseY < y + len - 10) {
      return true;
    } else {
      return false;
    }
  }
 
  /**
  * Check if the dial is selected
  *
  * @return true if within and mousePressed else false
  */
  boolean selected() {
    if (mousePressed && active()) {
      return true;
    } else {
      return false;
    }
  }
}

/*
 * simple class for creating a buttons that works with the dial class.
 * the buttons are designed to be grouped (max 3) with others such that
 * one dial can hold several and adjust several values. The button state
 * tracks and updates whether the button has been selected or note,
 * (true or false). Additionally the button stores values for a
 * value that can be manipulated by the slider. 
 */
class ButtonDial {
  int x, y;              // x and y position of button
  int w;                 // width of button
  int h;                 // height of button
  boolean state;         // boolean state/value of button (true = selected)
  String name;           // name of button
  String description;    // short description of what button does
  
  float value;           // value of button (modified when active)
  float min;             // min value
  float max;             // max value

  color cNameTrue;       // name color when true
  color cNameFalse;      // name color when false
  color cNameActive;     // name color when active
  
  /*
   * constructor method for creating a button
   *
   * @param _name           initial boolean value of button
   * @param _description    initial boolean value of button
   * @param _initState      inital boolean state/value of button
   * @param _min            min value of button
   * @param _max            max value of button
   * @param _initialValue   initial value of button
   */
  ButtonDial(String _name, String _description, boolean _initState, float _min, float _max, float _initialValue) {
    x = 0;
    y = 0;
    name = _name;
    description = _description;
    state = _initState;
    w = 50;
    h = 20;
    
    value = _initialValue;
    min = _min;
    max = _max;
    
    cNameTrue = color(80);
    cNameFalse = color(150);
    cNameActive =color(0);  
  }
  
  /**
  * set the position of the button
  *
  * @param {int} _x    x position
  * @param {int} _y    y position
  */
  void setPosition(int _x, int _y) {
    x = _x;
    y = _y;
  }
  
  /**
  * set the description of the button
  *
  * @param {String} _description    short description of the button
  */
  void setDescription(String _description) {
    description = _description;
  }
  
  /**
  * set the value of the button
  *
  * @param {float} _value    the value of the button
  */
  void setValue(float _value) {
    value = _value;
  }
  
  /**
  * get the value of the button
  *
  * @return      the button value
  */
  float getValue() {
    return value;
  }
  
  /**
  * get the min value for the button
  *
  * @return      the min value
  */
  float getMin() {
    return min;
  }
  
  /**
  * get the max value for the button
  *
  * @return      the max value
  */
  float getMax() {
    return max;
  }
  
  /**
  * get the description of the button
  *
  * @return      the button description
  */
  String getDescription() {
    return description;
  }
  
  /**
  * display the button with just text
  */
  void display() {
    textAlign(CENTER, CENTER);
    
    if(active()) {
        fill(cNameActive);
      } else {
      if(state) {
        fill(cNameTrue);
      } else {
        fill(cNameFalse);
      }
    } 
      
    textSize(12);   
    text(name, x + (w/2), y + (h/2));
  
  }
  
  /**
  * update the button state
  */
  void updateState() {
    if(active()) {
      state = !state;
    }       
  }
  
  /**
  * check if mouse is within button
  *
  * @return      return true if mouse is within button
  */
  boolean active() {
    if (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h) {
      return true;
    } else {
      return false;
    }
  }
}
