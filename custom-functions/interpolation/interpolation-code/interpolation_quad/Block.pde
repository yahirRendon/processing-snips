/**************************************************************
 class for visually displaying elements of the interpolation
 functions. Nothing to specific or special. 
 **************************************************************/
class Block {
  ArrayList<Float> timeSteps;              // time steps in terms of t and tspd
  ArrayList<Float> rawNums;                // raw numbers measued in frame rates
  ArrayList<Float> interpResults;          // interpolation results based on t
  ArrayList<Float> inverseResults_time;    // inverse interp. results based on exact passing values found from interp. function 
  ArrayList<Float> inverseResults_raw;     // inverse interp. results based on passing in raw numbers measured in frames

  float value;                             // current value
  int padding;                             // padding for displaying curve and inverse 
  int blockSize;                           // size of each block
 
  /**
  * Constructor method creating block
  *
  * @param {int} _x    the x position of the Cell (index)
  * @param {int} _y    the y position of the Cell (index)
  */
  Block() {
    blockSize = 100;
    padding = 5;
    
    timeSteps = new ArrayList<Float>();
    rawNums = new ArrayList<Float>();
    interpResults = new ArrayList<Float>();
    inverseResults_time = new ArrayList<Float>();
    inverseResults_raw = new ArrayList<Float>();   
  }
  
  /**
   * update values
   *
   * @param {float}  t      t amount
   * @param {float}  v      value given t
   * @param {float}  inv    inverse value give v
   */
  void update(float t, float raw, float interp, float inv_time, float inv_raw) {
    value = interp;
    
    timeSteps.add(t);
    interpResults.add(interp);
    inverseResults_time.add(inv_time);
    inverseResults_raw.add(inv_raw);
    rawNums.add(raw);
  }
  
  /**
   * reset/clear arrays
   *
   */
  void reset() {
    timeSteps.clear();
    interpResults.clear();
    inverseResults_time.clear();
    inverseResults_raw.clear();
    rawNums.clear();
  }
  
  /**
   * display block with fade in element
   *
   * @param {int}     x       x position of block (right corner)
   * @param {int}     y       y position of block (rgiht corner)
   * @param {String}  title   title above block
   */
  void display(int x, int y, String title) {
    // display title if necessary
    fill(dark);
    
    stroke(dark);
    text(title, x + blockSize/2, y - 15);
    
    // block boundary rect with fade fill based on current value
    // running in interpolation function
    fill(purple, value);
    rect(x, y, blockSize, blockSize, 5, 0, 5, 0);
  }
  
  /**
   * display example of easing curve
   *
   * @param {int}     x       x position of block (right corner)
   * @param {int}     y       y position of block (rgiht corner)
   * @param {String}  title   title above block
   */
  void displayInterpolation(int x, int y, String title) {
    // display title if necessary
    fill(dark);
    stroke(dark);
    text(title, x + blockSize/2, y - 15);
    
    // block boundary rect
    noFill();
    rect(x, y, blockSize, blockSize, 5, 0, 5, 0);
    
    // draw current value with larger ellipse to hightlight
    fill(teal);
    stroke(teal);
    ellipse(x + map(t, 0, 1, padding, blockSize - padding), map(value, 0, 255, y + blockSize - padding, y + padding), 5, 5);
    
    // graph time steps against results of interpolation
    stroke(teal);    
    for(int i = 0; i < timeSteps.size(); i++) {
      float xpos = x + map(timeSteps.get(i), 0, 1, padding, blockSize - padding);
      float ypos = y + blockSize - map(interpResults.get(i), 0, 255, padding, blockSize - padding);
      ellipse(xpos, ypos, 2, 2);
    }
  }
  
  /**
   * display block graph of inverse. 
   * purple line represents:
   * x axis: time steps
   * y axis: inverse results when passing in exact values returned 
   *         from initial interpolation function. 
   * Since time steps increment consistently per tspd. The result 
   * is a linear line. 
   *
   * teal line represents:
   * x axis: inverse interpolation when passing raw numbers
   * y axis: raw numbers
   * This is checking whether the values returned when not passing
   * exact values returned from interpolation function but rather
   * using linear raw values returns the same curve of the
   * interpolation function when running inversely 
   *
   * @param {int}     x       x position of block (right corner)
   * @param {int}     y       y position of block (rgiht corner)
   * @param {String}  title   title above block
   */ 
  void displayInverse(int x, int y, String title) {
    // title if necessary
    fill(dark);
    stroke(dark);
    text(title, x + blockSize/2, y - 15);
    
    // block boundary rect
    noFill();
    rect(x, y, blockSize, blockSize, 5, 0, 5, 0);
    
    // graphing inverse results given raw nums against those raw nums 
    stroke(teal);
    fill(teal);
    for(int i = 0; i < rawNums.size(); i++) { 
      float xval = inverseResults_raw.get(i);
      float yval = rawNums.get(i);
     
      float xpos = x + map(xval, 0, 1, padding, blockSize - padding);
      float ypos = y + blockSize - map(yval, 0, 201, padding, blockSize - padding);         
      ellipse(xpos, ypos, 2, 2);
    }
    
    // graphing time steps and inverse based on t results
    stroke(purple);
    fill(purple);
    float ty = inverseResults_time.size() > 0 ? inverseResults_time.get(inverseResults_time.size() - 1) : 0;
    ellipse(x + map(t, 0, 1, padding, blockSize - padding), y + blockSize - map(ty, 0, 1, padding, blockSize - padding), 5, 5);
    
    for(int i = 0; i < timeSteps.size(); i++) {
      float xval = timeSteps.get(i);
      float yval = inverseResults_time.get(i);  
      
      float xpos = x + map(xval, 0, 1, padding, blockSize - padding);
      float ypos = y + blockSize - map(yval, 0, 1, padding, blockSize - padding);
      ellipse(xpos, ypos, 2, 2);
    }
  }
}
