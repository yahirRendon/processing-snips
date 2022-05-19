/**************************************************************
 Project:  Creating interpolation and inverse interpolation
           functions. All the non linear function were based
           around the easing functions by Andrey Sitnik and 
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
                        // usually consider in terms of time or frames
float tspd = 0.005;     // tspd is the value at which t grows per frame

// display blocks for showing example, curve, and inverse
Block blockIn;
Block blockOut;
Block blockInOut;

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
  blockIn = new Block();
  blockOut = new Block();
  blockInOut = new Block();
  
  // for testing values coming in and out of functions
  float priorResult = 0.0;
  for(float i = 0; i < 1.01; i+=0.1) {
    float ival = (float)(Math.round(i * Math.pow(10, 1))
                 / Math.pow(10, 1));
    float lerpResult = exerpIn(0, 100, ival);
    lerpResult = (float)(Math.round(lerpResult * Math.pow(10, 1))
                 / Math.pow(10, 1));
    float invLerpResult = exerpInInverse(0, 100, lerpResult);
    invLerpResult = (float)(Math.round(invLerpResult * Math.pow(10, 1))
                 / Math.pow(10, 1));
    
    float dif = lerpResult - priorResult;
    dif = (float)(Math.round(dif * Math.pow(10, 1))
                 / Math.pow(10, 1));
    priorResult = lerpResult;
                            
    println(ival + ", " + lerpResult  + ", " + dif  + ", " + lerpResult  + ", " + invLerpResult);
    
  }
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
     float interp = exerpIn(0, 255, t);
     float inverse_time = exerpInInverse(0, 255, interp);
     float inverse_raw = exerpInInverse(0, 200, rawNum);
     blockIn.update(t, rawNum, interp, inverse_time, inverse_raw);
     
     // out function updates
     interp = exerpOut(0, 255, t);
     inverse_time = exerpOutInverse(0, 255, interp);
     inverse_raw = exerpOutInverse(0, 200, rawNum);
     blockOut.update(t, rawNum, interp, inverse_time, inverse_raw);
     
     // in out function updates
     interp = exerpInOut(0, 255, t);
     inverse_time = exerpInOutInverse(0, 255, interp);
     inverse_raw = exerpInOutInverse(0, 200, rawNum);
     blockInOut.update(t, rawNum, interp, inverse_time, inverse_raw);
     
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
    blockIn.reset();
    blockOut.reset();
    blockInOut.reset();
    
    rawNum = 0;
    t = 0.0;
    stage = 1;
    break;
   }
     
   // type of interpolation title
   fill(0);
   textSize(28);
   text("Expo Interpolation", width/2, 50);
  
    // y labels 
   textSize(12);
   text("In", 75, 175);
   text("Out", 75, 325);
   text("In/Out", 75, 475);
   
   text("v", 245, 175);
   text("t", 300, 230);
   text("v", 395, 175);
   text("t", 450, 230);
   
   // in display
   blockIn.display(100, 125, "Example");
   blockIn.displayInterpolation(250, 125, "Graph");
   blockIn.displayInverse(400, 125, "Inverse");
   
   // out display
   blockOut.display(100, 275, "");
   blockOut.displayInterpolation(250, 275, "");
   blockOut.displayInverse(400, 275, "");
   
   // in out display
   blockInOut.display(100, 425, "");
   blockInOut.displayInterpolation(250, 425, "");
   blockInOut.displayInverse(400, 425, "");
   
   saveFrame("output/exerp_interp_####.png");     
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
* between the first and second value to get the corresponding 
* value between 0.0 and 1.0. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per linear easing
*/
float lerpInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;
  return (v - a) / (b - a);
}

/**
* Interpolation function using the exponential in easing function
* by easing.net
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} t      amt between 0.0 and 1.0
* @return               value between first and second value given t
*/
float exerpIn(int a, int b, float t) {
  if(t <= 0) return a;
  if(t >= 1) return b;
  float in_t = pow(2, 10 * t - 10);
  return a + (b - a) * in_t;  
}

/**
* Inverse interpolation for exponential in interpolation. Pass a value
* between the first and second value to get the corresponding 
* value between 0.0 and 1.0 based on exponential in easing. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per exponential in easing
*/
float exerpInInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;  
  float t = (v - a) / (b - a);
  return log(1024 * t) / (10 * log(2));  
}

/**
* Interpolation function using the exponential out easing function
* by easing.net
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} t      amt between 0.0 and 1.0
* @return               value between first and second value given t
*/
float exerpOut(int a, int b, float t) {
  if(t <= 0) return a;
  if(t >= 1) return b;
  float out_t = 1 - pow(2, -10 * t);
  return a + (b - a) * out_t;
}

/** 
* Inverse interpolation for exponential out interpolation. Pass a value
* between the first and second value to get the corresponding 
* value between 0.0 and 1.0 based on exponential out easing. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per exponential out easing
*/
float exerpOutInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;  
  float t = (v - a) / (b - a);
  return -log(1-t)/(10 * log(2));
}

/**
* Interpolation function using the exponential in/out easing function
* by easing.net
*
* @param a      first value
* @param b      second value
* @param t      amt between 0.0 and 1.0
* @return       value between first and second value at t
*/
float exerpInOut(int a, int b, float t) {
  if(t <= 0) return a;
  if(t >= 1) return b;
  float out_t = t < 0.5 ? pow(2, 20 * t - 10) / 2
                 : (2 - pow(2, -20 * t + 10)) / 2;
  return a + (b - a) * out_t;
}

/** 
* Inverse interpolation for exponential in/out interpolation. Pass a value
* between the first and second value to get the corresponding 
* value between 0.0 and 1.0 based on exponential in/out easing. 
*
* @param {int}   a      first value
* @param {int}   b      second value
* @param {float} v      value between first and second value
* @return               value between 0.0 and 1.0 given v per exponential in/out easing
*/
float exerpInOutInverse(int a, int b, float v) {
  if(v <= a) return 0.0;
  if(v >= b) return 1.0;  
  float t = (v - a) / (b - a);
  return t < 0.5 ? log(2048 * t) / (20 * log(2))
         : -(log((1-t)/512)) / (20 * log(2));  
}
