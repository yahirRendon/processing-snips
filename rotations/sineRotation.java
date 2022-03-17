
PVector offsetAmt;        // start position in x and y of the sine wave
PVector currentPos;       // updating x and y values of sine wave

float theta;              // angle passed to sine function
float speed;              // linear propegation speed

// for display a trail of the sinve wave 
ArrayList<PVector> standardTrail;
ArrayList<PVector> rotatedTrail;

void setup() {
  size(600, 600);
  offsetAmt = new PVector(300, 300); 
  currentPos = new PVector(0, 0);
  theta = 0;
  speed = .5;
  
  standardTrail = new ArrayList<PVector>();
  rotatedTrail = new ArrayList<PVector>();
}

void draw() {
  background(255);

  // calculate sine wave values
  theta--;
  currentPos.y = (sin(radians(theta)) * 100);
  currentPos.x+=speed;
  
  // reset sine wave at 0, 0
  if(offsetAmt.x + currentPos.x > width) {
    currentPos.x = 0;
    currentPos.y = 0;
    theta = 0;
  }
  
  noStroke();
   
  // basic sine wave at desired origin
  fill(0);
  ellipse(offsetAmt.x + currentPos.x, offsetAmt.y + currentPos.y, 10, 10);
  
  // rotated sine wave at desired origin
  float angleRotated = -45;
  PVector t = rotation(currentPos, angleRotated);
  fill(255, 0, 0);
  ellipse(offsetAmt.x + t.x, offsetAmt.y + t.y, 10, 10);
  
 /* 
  * code below is to make sine waves easier to see 
  * and doesn't add to the calculates at heart of sketch
  * 
  */
  
  // create x and y lines through offset to show rotation
  stroke(1);
  line(300, 100, 300, 500);
  line(100, 300, 500, 300);
  
  // add values to array list for trail
  standardTrail.add(new PVector(offsetAmt.x + currentPos.x, offsetAmt.y + currentPos.y));
  rotatedTrail.add(new PVector(offsetAmt.x + t.x, offsetAmt.y + t.y));
  
  // remove oldest value in trail after set size
  if(standardTrail.size() > 100) {
   standardTrail.remove(0);
   rotatedTrail.remove(0);
  }
  
  // draw the trail of original sine wave
  fill(0);
  noStroke();
  for(int i = 0; i < standardTrail.size(); i++) {
    float trailSize = map(i, 0, standardTrail.size(), 0, 10);
    ellipse(standardTrail.get(i).x, standardTrail.get(i).y, trailSize, trailSize);
  }
  
  // draw the trail of rotated sine wave
  fill(255, 0, 0);
  for(int i = 0; i < rotatedTrail.size(); i++) {
    float trailSize = map(i, 0, rotatedTrail.size(), 0, 10);
    ellipse(rotatedTrail.get(i).x, rotatedTrail.get(i).y, trailSize, trailSize);
  }
  
}

/* 
 * Function for rotating a vector by given angle
 * 
 * @param {PVector}   vec      the vector being rotated (x and y only)
 * @param {float}     angle    the desired rotation angle in degrees
 * return                      the values of rotated vector in PVector object
 */
PVector rotation(PVector vec, float angle) {
  // assign desired rotation angle in radians
  float rotationAngle = radians(angle);
  
  // calculate new x and y values based on rotation
  float tempX = (vec.x * cos(rotationAngle)) - (vec.y * sin(rotationAngle));
  float tempY = (vec.y * cos(rotationAngle)) + (vec.x * sin(rotationAngle));
  
  // assign and return new PVector
  PVector tempVector = new PVector(tempX, tempY);
  return tempVector; 
}


