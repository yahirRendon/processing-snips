/**************************************************************
 Project:  An example of using two windows in a sketch
 Author:   Yahir
 Date:     October 2021
 
 **************************************************************/

import processing.core.*;
PWindow sketch2;            // second sketch window object

// test variables
float radius;
float sw;
boolean solid;

boolean sketch2Loaded = false;

/**************************************************************
 SETTINGS AND SETUP 1
 **************************************************************/
public void settings() {
  size(900, 900);
}

void setup() { 
  sketch2 = new PWindow();
  surface.setTitle("Sketch 1");
  surface.setLocation(10, 25);

  radius = 0;
  sw = 0;
  solid = false;
}

/**************************************************************
 DRAW METHOD 1
 **************************************************************/
void draw() {
  background(255);
  
  // once second window loaded
  if (sketch2Loaded) {
    radius = sketch2.s1.getValue();
    sw = sketch2.s2.getValue();
    solid = sketch2.b1.getValue();
  }
  
  // example
  if (solid) {
    fill(0);
  } else {
    noFill();
  }
  strokeWeight(sw);
  ellipse(width/2, height/2, radius, radius);
}

/**************************************************************
 MOUSE CLICKED
 **************************************************************/
void mouseClicked() {
  println("Click in sketch 1");
}

/**************************************************************
 kEY PRESSED
 **************************************************************/
void keyPressed() {
  println(key, "pressed in sketch 1");
}
