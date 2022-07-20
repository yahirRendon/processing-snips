/**************************************************************
 Project:  Random idea born out of wanting to use sine waves and
           easing to create a wiggling square. Added a class for
           a line as well. 
           
 Author:   Yahir
 Date:     January 2022
 
 Notes:
 - click on square or line to see the wiggle effect.
 - processing 3.5.4
 
 **************************************************************/

// wiggle objects
WiggleSquare wSquare;        
WiggleSquare wSquare2;
WiggleLine wLine;

/**************************************************************
 SET UP METHOD
 **************************************************************/
void setup() {
  size(600, 600, FX2D);
  
  // initialize objects
  wSquare = new WiggleSquare(200, 200, 200);
  wSquare2 = new WiggleSquare(250, 50, 100);
  wSquare2.wiggleAmt = 5;  // change wiggle amount
  wSquare2.firmness = .8;  // change firmness
  wLine = new WiggleLine(150, 480, 300, 1);
}

/**************************************************************
 DRAW METHOD
 **************************************************************/
void draw() {
  background(240);
  
  fill(248);
  wSquare.display();
  wSquare2.display();
  wLine.display();

}

/**************************************************************
 MOUSE CLICKED
 
 - on object hover do wiggle
 **************************************************************/
void mouseClicked() {
  wSquare.wiggleClick();
  wSquare2.wiggleClick();
  wLine.wiggleClick();
}




/**
* Class for creating a line that will oscillate or wiggle
* when clicked. boundary height 10 pixels
*/
class WiggleLine {
  int x, y;            // left corner x and y
  int sze;             // sze of square
  float angle;         // position within sine wave #rename?
  float firmness;      // lower seems soft. higher seems firmer
  float amplitude;     // amplitude of sine wave
  float easing;        // easing amount
  float speed;         // speed moving through sine wave
  float wiggleAmt;     // amplitude of sine wave on wiggle
  int type;            // type of wiggle 0 or 1
  
  /**
  * Wiggle Line constructor
  *
  * @PARAM _x    left x position of line
  * @PARAM _y    left y position of line
  * @PARAM _s    size of the square
  */
  WiggleLine(int _x, int _y, int _s, int _t) {
    x = _x;
    y = _y;
    sze = _s;
    angle = 0;
    firmness = .20;
    amplitude = 0;
    easing = 0.02;
    speed = (sin(angle));
    wiggleAmt = 10;
    type = _t;
  }
  
  /**
  * update elements of the wiggle and easing
  */
  void update() {
    speed = (sin(angle));
    angle += firmness;

    // return to 0 amplitude using easing
    float targetAmp = 0;
    float dx = targetAmp - amplitude;
    amplitude += dx* easing;
  }
  
  /**
  *  display the square
  */
  void display() {
    update();
    
    // set points accounting for wiggle
    // right point
    float x1 =  x;
    float y1 = y;
    // left point
    float x2 = x + sze;
    float y2 = y;

    
    switch(type) {
     case 0: // grow shrink
       x1 = x + speed * amplitude;
       y1 = y + speed * amplitude; 
       x2 = (x + sze) + speed * -amplitude;
       y2 = y + speed * amplitude; // TR
     break;
     case 1: // wobble
       x1 = x + speed * -amplitude;
       y1 = y + speed * -amplitude; 
       x2 = (x + sze) + speed * -amplitude;
       y2 = y + speed * amplitude; // TR
     break;
    }
    
    beginShape();
      vertex(x1, y1);
      vertex(x2, y2);
    endShape();
  }
  
  /**
  * run method on click to activate wiggle
  */
  void wiggleClick() {
    if (active()) {
      amplitude = wiggleAmt;
    }
  }
  
  /**
  * check if mouse is within line boundary
  *
  * @RETURN true if hover
  */
  boolean active() {
    if (mouseX > x && mouseX < x + sze &&
      mouseY > y - 5 && mouseY < y + 10) {
      return true;
    } else {
      return false;
    }
  }
}


/**
* Class for creating a square that will oscillate or wiggle
* when clicked
*/
class WiggleSquare {
  int x, y;            // left corner x and y
  int sze;             // sze of square
  float angle;         // position within sine wave #rename?
  float firmness;      // lower seems soft. higher seems firmer
  float amplitude;     // amplitude of sine wave
  float easing;        // easing amount
  float speed;         // speed moving through sine wave
  float wiggleAmt;     // amplitude of sine wave on wiggle
  
  /**
  * Wiggle Square constructor
  *
  * @PARAM _x    left corner x position of square
  * @PARAM _y    left corner y position of square
  * @PARAM _s    size of the square
  */
  WiggleSquare(int _x, int _y, int _s) {
    x = _x;
    y = _y;
    sze = _s;
    angle = 0;
    firmness = .20;
    amplitude = 0;
    easing = 0.02;
    speed = (sin(angle));
    wiggleAmt = 10;
  }
  
  /**
  * update elements of the wiggle and easing
  */
  void update() {
    speed = (sin(angle));
    angle += firmness;

    // return to 0 amplitude using easing
    float targetAmp = 0;
    float dx = targetAmp - amplitude;
    amplitude += dx* easing;
  }
  
  /**
  *  display the square
  */
  void display() {
    update();
    
    // set square corners accounting for wiggle
    float x1 = x + speed * amplitude;
    float y1 = y + speed * amplitude; // TL
    float x2 = (x + sze) + speed * -amplitude;
    float y2 = y + speed * amplitude; // TR
    float x3 = (x + sze) + speed * -amplitude;
    float y3 = (y + sze) + speed * -amplitude; // BR
    float x4 = x + speed * amplitude;
    float y4 = (y + sze) + speed * -amplitude; // BL

    beginShape();
      vertex(x1, y1);
      vertex(x2, y2);
      vertex(x3, y3);
      vertex(x4, y4);
    endShape(CLOSE);
  }
  
  /**
  * run method on click to activate wiggle
  */
  void wiggleClick() {
    if (active()) {
      amplitude = wiggleAmt;
    }
  }  
  
  /**
  * check if mouse is within square
  *
  * @RETURN true if hover
  */
  boolean active() {
    if (mouseX > x && mouseX < x + sze &&
      mouseY > y && mouseY < y + sze) {
      return true;
    } else {
      return false;
    }
  }
}
