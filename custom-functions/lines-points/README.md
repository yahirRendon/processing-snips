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

<p>Get the angle from one point or another. This can be useful for working with dials or determing impact angles</p>

<details>  
  <summary>Angel</summary>
   
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
