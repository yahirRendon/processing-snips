/**************************************************************
 Project:  create a standard slider for use in projects 
           
 Date:     May 24, 2022
 Author:   Yahir

 
 Notes:
           - Processing 3.5.4
 **************************************************************/
 
Slider slider;       // slider object
float alphaValue;    // value to be controlled by slider

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(600, 300);
  
  // initialize 
  alphaValue = 30;
  
  // initialize with position x, y start, stop, initial value, and name
  slider = new Slider(25, 150, "alpha", 0, 255, alphaValue);
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(255);
  
  // display and update value to desired variable
  slider.display();
  alphaValue = slider.getValue();
  
  // display rect for fill example
  stroke(0, 255 - alphaValue);
  fill(0, alphaValue);
  rect(350, 40, 200, 200); 
}

/*
 * Class for creating a basic horiztonal slider
 */
class Slider {
  int x, y;                  // corner position of slider
  int w, h;                  // dimensions of slider
  float rval;                // Raw value used when mapping
  float value;               // value to be used between min and max
  float min, max;            // min and max range of slider
  int nameSize;              // text size for name
  int valueSize;             // text size for value 
  String name;               // display name for slider
  color cBackground;         // background color
  color cForeground;         // foregournd color
  color cName;               // name color
  color cValue;              // value color
  color cActive;             // color when slider active

  /*
   * Constructor method for setting up slider
   *
   * @param: int    | _x        | x position CORNER
   * @param: int    | _y        | y position CORNER
   * @param: String | _name     | name of slider
   * @param: float  | _min      | min slider value
   * @param: float  | _max      | max slider value
   * @param: float  | _startVal | initial value of slider 
   */
  Slider(int _x, int _y, String _name, float _min, float _max, float _startVal) {
    x = _x;
    y = _y;
    min = _min;
    max = _max;
    name = _name;
    w = 300;
    h = 20;
    
    // map position bases on min, max, and start value   
    value = _startVal;
    rval = map(value, min, max, 0, w);
    
    // style elements
    nameSize = 12;
    valueSize = 12;
    cBackground = color(220);
    cForeground = color(150);
    cName = color(80);
    cValue = color(0);
    cActive =color(0);    
  }
  
  /**
  * getter method for returning slider value
  *
  */
  float getValue() {
    return value;
  }
  
  /**
  * Update slider values and elements
  */
  void update() {
    // if selected calculate angle to determine value setting
    if (selected()) {
      rval = mouseX;
      // map slider value as desired
      rval = map(mouseX, x, x + w, 0, w);
    }  
    value = map(rval, 0, w, min, max); 
  }
  
  /**
  * display slider elements
  */
  void display() {   
    update();
    
    strokeWeight(1);
    stroke(0);
    fill(cBackground);
    rect(x, y, w, h, 5);
    
    fill(cForeground);
    if(active()) {
      fill(cActive);
    }    
    rect(x, y, rval, h, 5);
    
    // text settings for slider
    textAlign(CENTER, CENTER);
    textSize(nameSize);
    
    // position name 
    fill(0);
    text(name, x +(w/2), y + h + 10);
    
    // round and position value
    textSize(valueSize);
    float displayValue = (float)(Math.round(value * Math.pow(10, 1))
                         / Math.pow(10, 1));
                 
    fill(cValue);
    if(active()) {
      fill(cForeground);
    }
    text(Float.toString(displayValue), x + h, y + (h/2));
  }
  
  /**
  * Check if the mouse is within area of slider
  *
  * @return true if within area else false
  */
  boolean active() {
    if(mouseX >= x && mouseX <= x + w &&
       mouseY >= y && mouseY <= y + h) {
      return true;
    } else {
      return false;
    }
  }
  
  /**
  * Check if the slider is selected
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
