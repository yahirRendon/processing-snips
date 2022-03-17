# Rotations
A Processing sketch with a function that rotates the x and y values in a PVector by a desired angle. The relevant code is below:

```java
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
```

In the sketch a sine wave is created using the built in sin() function and is displayed as the black sine wave. The red sine wave displays the rotated values returned by the rotation function. To place the origin of the sine wave at any desired location an offset amount is added to the generated values from the original sine wave (black) and the rotated sine wave (red). 

![Rotated Sine Gif](https://github.com/yahirRendon/Processing_Snips/blob/main/rotations/sine_rotation/data/sineRotate.gif)
