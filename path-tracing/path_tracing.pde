/******************************************************************************
 Project:  I needed to move between points for another project so created a
 simple class that traces a path between a list of points. 
 
 Author:   Yahir
 Date:     May 2023
 
 Notes:    processing 3.5.4^ 
 
 ******************************************************************************/

PathTracer trace;                // path tracer object

/******************************************************************************
 * 
 * setup method
 * 
 *****************************************************************************/
void setup() {
  size(400, 400);

  // populate node points
  ArrayList<PVector> nodes = new ArrayList<PVector>();  
  for (int i = 0; i < 3; i++) {
    int xpos = int(random(50, 350));
    int ypos = int(random(50, 350));
    nodes.add(new PVector(xpos, ypos));
  }

  // initialize path tracer object (nodes list, trace speed, direction, type)
  trace = new PathTracer(nodes, 1, "REVERSE", "SINGLE");
}

/******************************************************************************
 * 
 * draw method
 * 
 *****************************************************************************/
void draw() {
  background(255);
  trace.update();
  trace.display();
}

/******************************************************************************
 *
 * class for tracing path between a list of points. 
 *
 *****************************************************************************/
class PathTracer {
  float x, y;                  // the x and y position moving along path
  int curIndex;                // the current index within path points
  int nextIndex;               // the next index within path points
  boolean atTarget;            // track if x and y have arrived at next path point
  float traceSpeed;            // the travel speed of x and y
  float angle;                 // angle to next path point
  float radius;                // radius increments from cur to next path point
  ArrayList<PVector> path;     // list of points in path
  String type;
  String direction;
  boolean endLoop;

  /******************************************************************************
   * constructor
   * 
   * @param  _nodes    the list of points within path
   * @param  _spd      the tracing speed
   
   *****************************************************************************/
  PathTracer(ArrayList<PVector> _nodes, float _spd, String _dir, String _type) {
    path = _nodes;
    traceSpeed = _spd;
    direction = _dir;
    type = _type;

    if (path.size() < 2) {
      println("path size needs at least 2 points");
    } else {
      resetTrace();
    }
  }

  /******************************************************************************
   * 
   * update the x and y position 
   * 
   *****************************************************************************/
  void update() { 
    // move x and y positions
    if (!endLoop) {
      radius += traceSpeed;
      x = path.get(curIndex).x + cos(angle) * radius;
      y = path.get(curIndex).y + sin(angle) * radius;
    }

    // check distance to next point and set limit check
    float distanceToNext = dist(x, y, path.get(nextIndex).x, path.get(nextIndex).y);
    float limit = 1;
    if (traceSpeed > 1) limit = traceSpeed;

    // update once arrived at next path point
    if (distanceToNext < limit) {
      switch(direction) {
      case "REVERSE":
        reverseTrace();
        break;
      case "FORWARD":
      default:
        forwardTrace();
        break;
      }
    }
  }

  /******************************************************************************
   * 
   * trace path in normal mode
   * 
   *****************************************************************************/
  void forwardTrace() {
    curIndex++;
    nextIndex++;
    
    if (curIndex >= path.size()) curIndex = 0;     
    if (nextIndex >= path.size()) nextIndex = 0;
    if (type.equals("SINGLE") && nextIndex == 0) endLoop = true;

    x = path.get(curIndex).x;
    y = path.get(curIndex).y;

    angle = atan2(path.get(nextIndex).y - y, path.get(nextIndex).x - x);
    radius = 0;
  }

  /******************************************************************************
   * 
   * trace in path in reverse order
   * 
   *****************************************************************************/
  void reverseTrace() {
    curIndex--;
    nextIndex--;

    if (curIndex < 0) curIndex = path.size() - 1;     
    if (nextIndex < 0) nextIndex = path.size() - 1;
    if (type.equals("SINGLE") && nextIndex == 0) endLoop = true;

    x = path.get(curIndex).x;
    y = path.get(curIndex).y;

    angle = atan2(path.get(nextIndex).y - y, path.get(nextIndex).x - x);
    radius = 0;
  }
  
  /******************************************************************************
   * 
   * reset to beginning of trace conditions
   * 
   *****************************************************************************/
  void resetTrace() {
    atTarget = false;
      endLoop = false;
      curIndex = 0;
      nextIndex = 1;
      if (direction == "REVERSE") {
        curIndex = 0;
        nextIndex = path.size() - 1;
      }
      x = path.get(curIndex).x;
      y = path.get(curIndex).y;
      angle = atan2(path.get(nextIndex).y - y, path.get(nextIndex).x - x);
      radius = 0;
  }
  
  /******************************************************************************
   * 
   * simple way to set path direction
   * 
   *****************************************************************************/
  void setDirection(String _dir) {
    direction = _dir;
    resetTrace();
  }
  
  /******************************************************************************
   * 
   * simple way to set path type
   * 
   *****************************************************************************/
  void setType(String _type) {
    direction = _type;
    resetTrace();
  }
  
  /******************************************************************************
   * 
   * set a new path and reset tracer
   * 
   *****************************************************************************/
  void updatePath(ArrayList<PVector> _nodes) {
     if (_nodes.size() < 2) {
      println("Cannot update path: Path needs at least 2 points");
    } else {
      path = _nodes;
      resetTrace();
    }
  }

  /******************************************************************************
   * 
   * display the path points and x and y location along path
   * 
   *****************************************************************************/
  void display() {
    // display all path points
    for (int i = 0; i < path.size(); i++) {
      float curx = path.get(i).x;
      float cury = path.get(i).y;
      stroke(0);
      noFill();
      ellipse(curx, cury, 20, 20);
      fill(0);
      text(i, curx - 3, cury + 6);
    }

    // display x and y position along path
    fill(0);
    ellipse(x, y, 5, 5);
  }
}
