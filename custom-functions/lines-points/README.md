<h1 align="center">Functions for Lines and Points</h1>

<p>Common functions I've had to use when working with points and lines</p>
<h1></h1>

<p>Getting the midpoint of a segment can be useful on its own or part of another function/algorithm such as finding the circumcenter of a triangle.</p>

<details>  
  <summary>Mid Point</summary>
   
  ```java
  /**
   * getting the mid point between two points
   *
   * @param {PVector}   a      first point
   * @param {PVector}   b      second point
   * @return a point between a and b
   */
  PVector midpoint(PVector a, PVector b) {
    float x = (a.x + b.x) / 2;
    float y = (a.y + b.y) / 2;
    return new PVector(x, y);
  }
 ```
  <p> You can also get the mid point using Lerp by passing in 0.5 for t or any value along the segement given t.</p>
  
  ```java
  /**
   * getting the mid point between two points
   *
   * @param {PVector}   a      first point
   * @param {PVector}   b      second point
   * @param {float}    t      amount between 0.0 and 1.0
   * @return a point between a and b given t
   */
  PVector midLerp(PVector a, PVector b, float t) {
    float x = lerp(a.x, b.x, t);
    float y = lerp(a.y, b.y, t);
    return new PVector(x, y);
  }
 ```
</details>

<h1></h1>
<p>Get the angle from one point or another. This can be useful for working with dials or determing impact angles</p>

<details>  
  <summary>Angle</summary>
   
  ```java
  /**
   * get the angle between two points
   *
   * @param {PVector}   a      first point
   * @param {PVector}   b      second second
   * @return the angle in radians from a to b
   */
  float getAngle(PVector a, PVector b) {
    return atan2(b.y - a.y, b.x - a.x);
  }
 ```
</details>

<h1></h1>
<p>Getting the intersection between two lines can be used in collision detection</p>

<details>  
  <summary>Line Interesection</summary>
   
  ```java
  /**
   * find intersection of line. No bound checking
   *
   * @param {PVector}   a      first point
   * @param {PVector}   b      second point
   * @param {PVector}   c      third point
   * @param {PVector}   d      fourth point
   * @return point of intersecion or Float.MAX_VALUE if parallel
   */
  PVector intersectionLines(PVector a, PVector b, PVector c, PVector d) {
    PVector result;

    // line ab in standard form Ax + Bx = c;
    float a1 = b.y - a.y;
    float b1 = a.x - b.x;
    float c1 = (a1 * a.x) + (b1 * a.y);

    // line cd in standard form Ax + Bx = c;
    float a2 = d.y - c.y;
    float b2 = c.x - d.x;
    float c2 = (a2 * c.x) + (b2 * c.y);

    // check for unique solution
    float determinant = (a1 * b2) - (a2 * b1);

    // no unique solutions meaning the lines are parallel
    if(determinant == 0) {    
      result = new PVector(Float.MAX_VALUE, Float.MAX_VALUE);

    // a unique solution is possible
    } else {
      float dx = (b2 * c1) - (b1 * c2);
      float dy = (a1 * c2) - (a2 * c1);
      float x = dx / determinant;
      float y = dy / determinant;
      result = new PVector(x, y);   
    } 

    return result;
  }
 ```
  
  <p>If boundary checking is necessary</p>
  
 ```java
  /**
   * find intersection of line with bound checking
   *
   * @param {PVector}   a      first point
   * @param {PVector}   b      second point
   * @param {PVector}   c      third point
   * @param {PVector}   d      fourth point
   * @return point of intersecion or Float.MAX_VALUE if parallel
   *         or Float.MAX_VALUE if parallel if outside of line segement
   */
  PVector intersectionLines(PVector a, PVector b, PVector c, PVector d) {
    PVector result;

    // line ab in standard form Ax + Bx = c;
    float a1 = b.y - a.y;
    float b1 = a.x - b.x;
    float c1 = (a1 * a.x) + (b1 * a.y);

    // line cd in standard form Ax + Bx = c;
    float a2 = d.y - c.y;
    float b2 = c.x - d.x;
    float c2 = (a2 * c.x) + (b2 * c.y);

    // check for unique solution
    float determinant = (a1 * b2) - (a2 * b1);

    // no unique solutions meaning the lines are parallel
    if(determinant == 0) {    
      result = new PVector(Float.MAX_VALUE, Float.MAX_VALUE);

    // a unique solution is possible
    } else {
      float dx = (b2 * c1) - (b1 * c2);
      float dy = (a1 * c2) - (a2 * c1);
      float x = dx / determinant;
      float y = dy / determinant;

      // bound checking along line segments
      if(x >= min(a.x, b.x) && x <= max(a.x, b.x) && 
         y >= min(a.y, b.y) && y <= max(a.y, b.y) &&
         x >= min(c.x, d.x) && x <= max(c.x, d.x) && 
         y >= min(c.y, d.y) && y <= max(c.y, d.y)) {
           result = new PVector(x, y); 
       } else {
         // outside of line segments
         result = new PVector(Float.MAX_VALUE, Float.MAX_VALUE);
       } 
    } 

    return result;
  }
 ```  
</details>





