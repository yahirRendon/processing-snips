/**************************************************************
 Project:  create a basic button that can be toggled on and off
           
 Date:     May 23, 2022
 Author:   Yahir 
 
 Notes:
           - Processing 3.5.4
 **************************************************************/
 
Button button;
boolean fillOn;

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(600, 300);
 
  // initialize
  fillOn = false;
  // x pos, y pos, on name, off name, initial state
  button = new Button(125, 135, "on", "off", fillOn);
  
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(255);
  
  // update variable and display button
  fillOn = button.getState(); 
  button.display();
  
  if(fillOn) {
    fill(80, 0, 200);
  } else {
    noFill();
  }
  
  rect(350, 50, 200, 200);
}
 
/**************************************************************
 MOUSE CLICKED FUNCTION
 
 update button on click
 **************************************************************/
void mouseClicked() {
 button.updateState();
}

/*
 * simple class for creating a button that can be turned on and off
 */
class Button {
  int x, y;              // x and y position of button
  int w;                 // width of button
  int h;                 // height of button
  boolean state;         // boolean state/value of button (true = selected)
  String nameTrue;       // name when true
  String nameFalse;      // name when false
  
  color cTrue;           // color when true 
  color cFalse;          // color when falser
  color cActive;         // color when active
  color cName;           // name color
  color cNameActive;     // name color when active
  
  /*
   * Constructor method for creating a button
   *
   * @param _x              the x positon of the button
   * @param _y              the y position of the button
   * @param _nameT          name when button state is true
   * @param _nameF          name when button state is false
   * @param _initState      inital boolean state/value of button
   */
  Button(int _x, int _y, String _nameT, String _nameF, boolean _initState) {
    x = _x;
    y = _y;
    nameTrue = _nameT;
    nameFalse = _nameF;
    state = _initState;
    w = 100;
    h = 30;   
    cTrue = color(220);
    cFalse = color(150);
    cName = color(0);
    cActive = color(0);
    cNameActive = color(255);      
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
  * get button state
  *
  * @return      boolean state of the button
  */
  boolean getState() {
    return state;
  }
  
  /**
  * display the button
  */
  void display() {    
    // display button boundary
    if(state) {
      fill(cTrue);
    } else {
      fill(cFalse);
    }
    if (active()) {
     fill(cActive);
    } 
       
    rect(x, y, w, h, 5);   
    
    // display button text
    if(active()) {
        fill(cNameActive);
      } else {
      if(state) {
        fill(cName);
      } else {
        fill(cNameActive);
      }
    }
    
    textAlign(CENTER, CENTER);
    textSize(12);
    String displayName = nameTrue;
    if(!state) {
      displayName = nameFalse;
    }
    text(displayName, x + (w/2), y + (h/2));
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
