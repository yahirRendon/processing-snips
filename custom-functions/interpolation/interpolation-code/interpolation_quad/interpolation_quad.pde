/**************************************************************
 Project:  Creating interpolation and inverse interpolation
           functions. All the non linear function were based
           around the easing functions by Anrey Sitnik and 
           Ivan Solovev from easings.net. The inverse
           interpolation functions are my own.
           
 Date:     May 1, 2022
 
 About:    In various sketches I have used different types of 
           easing. I thought it would be helpful to convert the 
           easing functions into interpolation functions. 
           Additionally, I found it to be good math practice to 
           create the inverse functions as well. 
 
 Notes:
           - Processing41.0b2
   
 TO DO:
           - keep adding various interpolation functions. 
 **************************************************************/
 
// elements needed for interpolation
float t = 0.0;          // t is a value between 0.0 and 1.0 used for interpolation.
                        // sometimes consider in terms of time or frames
float tspd = 0.005;     // tspd is the value at which t grows per frame

// display blocks for showing example, curve, and inverse
Block bQuadIn;
Block bQuadOut;
Block bQuadInOut;

// styling elements for project
PFont font;                
float delayCounter = 0;
int stage = 0;
color teal = color(130, 150, 139 ); 
color dark = color(12, 19, 12);
color purple = color(76, 59, 77); 

int rawNum = 0;

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  size(600, 600);
  
  // set font
  font = createFont("Roboto Light", 28);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  // display interpolation blocks
  bQuadInOut = new Block();
  bQuadIn = new Block();
  bQuadOut = new Block();
  
  // for testing values coming in and out of functions
  // t steps passed into interpolation function
  ArrayList<Float> tvalues = new ArrayList<Float>(); 
  // result of interpolation when passing in t value between 0.0 and 1.0
  ArrayList<Float> values = new ArrayList<Float>();
  //for(float i = 0; i < 1.0; i+=0.1) {
  //  tvalues.add(i);
  //  values.add(qerpInOut(0, 255, i));
  //}
  
  //for(int i = 0; i < tvalues.size(); i++) {
  //  // print t step, intep result given t, inverse given inter result: should return initial t step
  //  print(tvalues.get(i), values.get(i), qerpInOutInverse(0, 255, values.get(i)));
  //  println();
  //}
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/ 
 void draw() {
   background(239);
  
   switch(stage) {
     // slight delay prior to animating
    case 0:
      delayCounter++;
      if(delayCounter > 100) {
        delayCounter = 0;
        stage++;
      }      
    break;
    
    // increment t and pass values to update methods for blocks
    case 1:      
     
     // in function updates
     float interp = qerpIn(0, 255, t);
     float inverse_time = qerpInInverse(0, 255, interp);
     float inverse_raw = qerpInInverse(0, 200, rawNum);
     bQuadIn.update(t, rawNum, interp, inverse_time, inverse_raw);
     
     // out function updates
     interp = qerpOut(0, 255, t);
     inverse_time = qerpOutInverse(0, 255, interp);
     inverse_raw = qerpOutInverse(0, 200, rawNum);
     bQuadOut.update(t, rawNum, interp, inverse_time, inverse_raw);
     
     // in out function updates
     interp = qerpInOut(0, 255, t);
     inverse_time = qerpInOutInverse(0, 255, interp);
     inverse_raw = qerpInOutInverse(0, 200, rawNum);
     bQuadInOut.update(t, rawNum, interp, inverse_time, inverse_raw);
     
     t += tspd;
     if(t > 1.0) {       
       stage++;
     }
     rawNum++;
    break;
    
    // delay after animation complete
    case 2:
      delayCounter++;
      if(delayCounter > 100) {
        
        delayCounter = 0;
        stage ++;
      }      
    break;
    
    // reset prior to animating again
    case 3:        
    bQuadIn.reset();
    bQuadOut.reset();
    bQuadInOut.reset();
    
    rawNum = 0;
    t = 0.0;
    stage = 1;
    break;
   }
     
   // type of interpolation title
   fill(0);
   textSize(28);
   text("Quad Interpolation", width/2, 50);
  
    // y labels 
   textSize(12);
   text("In", 75, 175);
   text("Out", 75, 325);
   text("In/Out", 75, 475);
   
   // in display
   bQuadIn.display(100, 125, "Example");
   bQuadIn.displayInterpolation(250, 125, "Graph");
   bQuadIn.displayInverse(400, 125, "Inverse");
   
   // out display
   bQuadOut.display(100, 275, "");
   bQuadOut.displayInterpolation(250, 275, "");
   bQuadOut.displayInverse(400, 275, "");
   
   // in out display
   bQuadInOut.display(100, 425, "");
   bQuadInOut.displayInterpolation(250, 425, "");
   bQuadInOut.displayInverse(400, 425, "");
     
 }
 
/**
* Standard linear lerp function
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} t      amt between 0.0 and 1.0
* @return               value between first and second value given t
*/
float linearLerp(int a, int b, float t) {
  if(t <= 0) return a;
  if(t >= 1) return b;
  return a + (b - a) * t;
}

/**
* Inverse function for linear interpolation. Pass a value
* between the frist and second value to get the corresponding 
* value between 0.0 and 1.0. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per linear easing
*/
float LinearLerpInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;
  return (v - a) / (b - a);
}

/**
* Interpolation function using the quad in easing function
* by easing.net
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} t      amt between 0.0 and 1.0
* @return               value between first and second value given t
*/
float qerpIn(int a, int b, float t) {
  if(t <= 0) return a;
  if(t >= 1) return b;
  float in_t = t * t;
  return a + (b - a) * in_t;
}

/** 
* Inverse interpolation for quad in interpolation. Pass a value
* between the first and second value to get the corresponding 
* value between 0.0 and 1.0 based on quad in out easing. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per quad in easing
*/
float qerpInInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;  
  float t = (v - a) / (b - a); 
  return sqrt(t); 
}

/**
* Interpolation function using the quad out easing function
* by easing.net
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} t      amt between 0.0 and 1.0
* @return               value between first and second value given t
*/
float qerpOut(int a, int b, float t) {
  if(t <= 0) return a;
  if(t >= 1) return b;
  float in_t = 1 - (1 - t) * (1 - t);
  return a + (b - a) * in_t;
}

/** 
* Inverse interpolation for quad out interpolation. Pass a value
* between the first and second value to get the corresponding 
* value between 0.0 and 1.0 based on quad out easing. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per quad out easing
*/
float qerpOutInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;  
  float t = (v - a) / (b - a); 
  return -sqrt(-t + 1) + 1; 
}

/**
* Interpolation function using the quad in out easing function
* by easing.net
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} t      amt between 0.0 and 1.0
* @return               value between first and second value given t
*/
float qerpInOut(int a, int b, float t) {
  if(t <= 0) return a;
  if(t >= 1) return b;
  float in_t = t < 0.5 ? 2 * t * t : 1 - sq(-2 * t + 2) / 2;
  return a + (b - a) * in_t;
}

/** 
* Inverse interpolation for quad in/out interpolation. Pass a value
* between the first and second value to get the corresponding 
* value between 0.0 and 1.0 based on quad in/out easing. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per quad in/out easing
*/
float qerpInOutInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;  
  float t = (v - a) / (b - a);
  return t < 0.5 ? (sqrt(2) * sqrt(t)) / 2 : 1 - (sqrt(2 - 2 * t))/ 2;
}
