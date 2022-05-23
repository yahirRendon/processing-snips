/**************************************************************
 Project:  generalize a dial used from a prior project for use
           in the future. 
           
 Date:     May 1, 2022
 Author:   Yahir
 
 About:    In various sketches I have had the need to manipulate
           values. The is an example of a round dial with a 
           minimal aesthetic. 
 
 Notes:
           - Processing 3.5.4
 **************************************************************/
 
Dial dial;           // dial object
float alphaValue;    // value to be controlled by dial

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(600, 300);
  
  // initialize 
  alphaValue = 30;
  
  // initialize with position x, y start, stop, initial value, and name
  dial = new Dial(150, 150, 0, 255, alphaValue, "alpha amt");
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(255);
  
  // display and update value to desired variable
  dial.display();
  alphaValue = dial.getValue();
  
  // display rect for fill example
  stroke(0, 255 - alphaValue);
  fill(0, alphaValue);
  rect(350, 40, 200, 200); 
}

/*
 * Class for creating a basic round dial
 */
class Dial {
  int x, y;                  // Center position of dial
  int len;                   // Radius of dial
  int diam;                  // Diameter of dial
  float angle;               // Angle for rotation 
  float rval;                // Raw value of angular rotation
  float dialValue;           // Value to be used between min and max
  float dialMin, dialMax;    // Min and max range of dial
  int nameSize;              // text size for name
  int valueSize;             // text size for value 
  String name;               // display name for dial
  color cBackground;         // background color
  color cForeground;         // foregournd color
  color cName;               // name color
  color cValue;              // value color
  color cActive;             // color when dial active

  /*
   * Constructor method for setting x and y position of node
   *
   * @param: int    | _x        | x position CENTER
   * @param: int    | _y        | y position CENTER
   * @param: float  | _min      | min dial value
   * @param: float  | _max      | max dial value
   * @param: float  | _startVal | initial value of dial
   * @param: String | _name     | name of dial
   *
   */
  Dial(int _x, int _y, float _min, float _max, float _startVal, String _name) {
    x = _x;
    y = _y;
    len = 100;
    diam = 100 * 2;
    dialMin = _min;
    dialMax = _max;
    name = _name;
    
    // map position bases on min, max, and start value
    rval = map(_startVal, dialMin, dialMax, 135, 405);
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
  * getter method for returning dial value
  *
  */
  float getValue() {
    return dialValue;
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
  }
  
  /**
  * display dial elements
  */
  void display() {   
    update();
    noStroke();
    // visually display total dial value range 
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
    float displayValue = (float)(Math.round(dialValue * Math.pow(10, 1))
                         / Math.pow(10, 1));
                 
    fill(cValue);
    if(active()) {
      fill(cActive);
    }
    text(Float.toString(displayValue), x, y);
    
    // Reset values to avoid impact other sketch elements
    strokeWeight(1);
    textAlign(LEFT);
  }
  
  /**
  * Check if the mouse is within area of dial
  *
  * @return true if within area else false
  */
  boolean active() {
    if (abs(dist(mouseX, mouseY, x, y)) < 110) {
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
