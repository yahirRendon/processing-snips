/**************************************************************
 Project:  General use for attraction and repelling of points,
           nodes, or objects. Would be neat in the future to
           add a more advanced collision detection that allows
           clusters to continue moving. Could check the angle
           of collision and rotating nodes along edge if
           possible until it is completely locked. 
           
 Author:  Yahir 
 Date:    May 2022

 
 Notes:
          - Processing 3.5.4
 
 Instructions:
           1. Run sketch
           2. LEFT MOUSE  | repel 
           3. RIGHT MOUSE | attract          
 **************************************************************/

ArrayList<PVector> nodes;        // list contain x and y values
int range;                       // range from mouse to attract/repel nodes
float spd;                       // how fast nodes move

boolean leftPressed;             // track left mouse button pressed
boolean rightPressed;            // track right mouse button pressed

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(600, 600);
  
  range = 200;
  spd = 1;
  leftPressed = false;
  rightPressed = false;
  
  // populate array with nodes/pvectors
  nodes = new ArrayList<PVector>();
  int numNodes = 50;
  for(int i = 0; i < numNodes; i++) {
    int x = int(random(100, width - 100));
    int y = int(random(100, height - 100));
    nodes.add(new PVector(x, y));
  }
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(240);  
  
  // a basic implementation to see the repel and attract effect
  //basic();
  
  // basic plus a crude collision detection
  basicCollision();
}

/**************************************************************
 MOUSEPRESSED FUNCTION
 
 LEFT  | left mouse button pressed
 RIGHT | right mouse button pressed
 **************************************************************/
void mousePressed() {
  if (mouseButton == LEFT) {
    leftPressed = true;
  } 
  if (mouseButton == RIGHT) {
    rightPressed = true;
  }
  
}

/**************************************************************
 MOUSEPRESSED FUNCTION
 
 LEFT  | left mouse button released
 RIGHT | right mouse button released
 **************************************************************/
void mouseReleased() {
  if (mouseButton == LEFT) {
    leftPressed = false;
  } 
  if (mouseButton == RIGHT) {
    rightPressed = false;
  } 
}


/**
 *  A basic implementation of the repel and attraction effect
 *
 */
void basic() {
  for(int i = 0; i < nodes.size(); i++) {
    // calculate distance of current node to mouse
    float d = dist(mouseX, mouseY, nodes.get(i).x, nodes.get(i).y);
    
    // check nodes are within range
    if(d < range) {
      // calculate angle from mouse to node
      float angle = atan2(mouseY - nodes.get(i).y, mouseX - nodes.get(i).x);
      
      // attract nodes in range when left mouse button pressed
      if(rightPressed) {
        nodes.get(i).x += map(d, range, 0, 0, spd) * cos(angle);
        nodes.get(i).y += map(d, range, 0, 0, spd) * sin(angle);
      }          
      
      // repel nodes in range when right mouse button pressed
      if(leftPressed) {
        nodes.get(i).x -= map(d, range, 0, 0, spd) * cos(angle);
        nodes.get(i).y -= map(d, range, 0, 0, spd) * sin(angle);
      }      
    }
    
    // simple display of nodes
    fill(0);
    ellipse(nodes.get(i).x, nodes.get(i).y, 5, 5);
  }
}

/**
 *  A basic collision check
 *
 * @param a    first point
 * @param b    second point
 * @param r    distance to trigger collision
 */
boolean collision(PVector a, PVector b, int r) {
  float d = dist(a.x, a.y, b.x, b.y);
  if(d < r) {
    return true;
  } else {
    return false;
  }  
}

/**
 *  the basic repel attract effect with a crude collision detection
 */
void basicCollision() {
  for(int i = 0; i < nodes.size(); i++) {
    // calculate distance of current node to mouse
    float d = dist(mouseX, mouseY, nodes.get(i).x, nodes.get(i).y);
    
    // check nodes are within range
    if(d < range) {
      // calculate angle from mouse to node
      float angle = atan2(mouseY - nodes.get(i).y, mouseX - nodes.get(i).x);
      
      // attract nodes in range when left mouse button pressed
      if(rightPressed) {
        // check collision
        boolean canMove = true;
        for(int j = 0; j < nodes.size(); j++) {
          if(i != j && collision(nodes.get(i), nodes.get(j), 5)) {
            canMove = false;
            break;
          }
        }
        if(canMove) {
        nodes.get(i).x += map(d, range, 0, 0, spd) * cos(angle);
        nodes.get(i).y += map(d, range, 0, 0, spd) * sin(angle);
        }      
      }
      
      // repel nodes in range when right mouse button pressed
      if(leftPressed) {
        nodes.get(i).x -= map(d, range, 0, 0, spd) * cos(angle);
        nodes.get(i).y -= map(d, range, 0, 0, spd) * sin(angle);
      }      
    }
    
    // simple display of nodes
    fill(0);
    ellipse(nodes.get(i).x, nodes.get(i).y, 5, 5);
  }
}
