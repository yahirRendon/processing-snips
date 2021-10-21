/**************************************************************
 Second Window used in sketch
 
 Holds all methods and functions for second window
 **************************************************************/
class PWindow extends PApplet {
  // design
  color c1 = color(234, 236, 238);
  color c2 = color(213, 216, 220);
  color c3 = color(192, 197, 203);
  color c4 = color(171, 178, 185);
  color c5 = color(150, 159, 168);
  color c6 = color(128, 139, 150);
  color c7 = color(107, 120, 133);
  color c8 = color(86, 101, 115);
  color c9 = color(65, 81, 98);


  //ArrayList<PVector> vectors = new ArrayList<PVector>(); // is this needed?

  // second sketch variables
  Slider s1, s2;
  Button b1;


  /**
   * Constructor method PWindow class
   *
   */
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  // not sure that I needed this?
  //void evokedFromPrimary(float relPosX, float relPosY) {
  //  println("evoked from primary");
  //  tempX = relPosX;
  //  tempY = relPosY;

  //  float xPos = map(relPosX, 0, 100, 0, this.width);
  //  float yPos = map(relPosY, 0, 100, 0, this.height);

  //  vectors.add(new PVector(xPos, yPos));
  //}

  // set the size here of second window window
  void settings() {
    size(900, 900);
  }

  /**************************************************************
   SET UP METHOD - SECOND
   **************************************************************/
  void setup() {
    surface.setTitle("Sketch 2 - Control Panel");
    surface.setLocation(925, 25);

    s1 = new Slider(50, 100, 300, "Radius", 50, 200, 100);
    s2 = new Slider(50, 250, 300, "Stroke", 2, 8, 2);
    b1 = new Button(200, 400, true);

    sketch2Loaded = true; // inform sketch 1 on load
  }

  /**************************************************************
   DRAW METHOD - SECOND 
   **************************************************************/
  void draw() {
    background(c3);
    
    // display 
    s1.display();
    s2.display();   
    b1.display();
  }

  /**************************************************************
   MOUSE DRAGGED
   
   - Update sliders
   **************************************************************/
  void mouseDragged() {
    s1.onDrag();
    s2.onDrag();
  }

  /**************************************************************
   MOUSE RELEASED
   
   - Update button
   **************************************************************/
  void mouseReleased() {
    if (mouseButton == LEFT) {
      b1.onClick();
    }
  }

  /**************************************************************
   Class for creating very basic GUI sliders to modify elements 
   of sketch 1
   **************************************************************/
  class Slider {
    PVector pos;
    PVector handlePos;
    String name;
    float min;
    float max;
    float len;

    /**
     * Constructor method for Slider class
     *
     * @param {int} _x        the x position of Slider (LEFT)
     * @param {int} _y        the y position of Slider (LEFT)
     * @param {int} _l        the length of the Slider
     * @param {STRING} _n     the y name of the Slider
     * @param {float} _min    the minimum value of Slider
     * @param {float} _max    the maximum value of Slider
     * @param {float} _v      the start value of Slider
     */
    Slider(int _x, int _y, int _l, String _n, float _min, float _max, float _v) {
      min = _min;
      max = _max;
      len = _l;
      float val = map(_v, min, max, 0, len);
      pos = new PVector(_x, _y, _v);  
      handlePos = new PVector(_x + val, _y);
      name = _n;
    }

    /**
     * return value method
     */
    float getValue() {
      return pos.z;
    }

    /**
     * on drage update value
     */
    void onDrag() {
      if (active()) {
        float val = map(mouseX, pos.x, pos.x + len, min, max);
        if (val < min) val = min;
        if (val > max) val = max;
        pos.z = val;

        handlePos.x = mouseX;
        if (handlePos.x < pos.x) handlePos.x = pos.x;
        if (handlePos.x > pos.x + 300) handlePos.x = pos.x + 300;
      }
    }

    /**
     * display the slider
     */
    void display() {  
      stroke(c9);
      line(pos.x, pos.y, pos.x + len, pos.y);
      stroke(255); 
      if (active()) {
        fill(c1);
      } else {
        fill(c4);
      }
      ellipse(handlePos.x, handlePos.y, 30, 30);

      fill(c9);

      textAlign(LEFT);
      text(name, pos.x, pos.y + 30);
      textAlign(RIGHT);
      text(pos.z, pos.x + len, pos.y + 30);
    }

    /**
     * check if mouse is within slider knob
     */
    boolean active() {
      if (dist(mouseX, mouseY, handlePos.x, handlePos.y) < 15) {
        return true;
      } else {
        return false;
      }
    }
  } 

  /**************************************************************
   Class for creating very basic GUI button to modify elements 
   of sketch 1
   **************************************************************/
  class Button {
    PVector pos;
    boolean value;
    int len;
    String name;

    /**
     * Constructor method for Button class
     *
     * @param {int} _x        the x position of Button (CENTER)
     * @param {int} _y        the y position of Butoon (CENTER)
     * @param {boolean} _v    the start value of Button
     */
    Button(int _x, int _y, boolean _v) {
      pos = new PVector(_x, _y);
      len = 60;
      name = "Fill";
      value = _v;
    }

    /**
     * get value
     */
    boolean getValue() {
      return value;
    }

    /**
     * onClick update value
     */
    void onClick() {
      if (active()) {
        value = !value;
      }
    }

    /**
     * display slider
     */
    void display() {
      stroke(255);
      if (value) {
        fill(c2);
      } else {
        fill(c4);
      }

      if (active()) {
        fill(c1);
      }
      ellipse(pos.x, pos.y, len, len);
      textAlign(CENTER);
      fill(c9);
      text(name, pos.x, pos.y + len - 10);
    }

    /**
     * check if mouse is within button 
     */
    boolean active() {
      if (dist(mouseX, mouseY, pos.x, pos.y) < len/2) {
        return true;
      } else {
        return false;
      }
    }
  }
}
