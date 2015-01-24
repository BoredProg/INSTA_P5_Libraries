import povexport.ui.arcball.*;
import povexport.ui.*;
import povexport.*;
import povexport.povwriter.*;



/**
 * The purpose of this library is to allow the export of processing sketches to PovRAY
 * Copyright (C) 2012 Martin Prout
 * This library is free software; you can redistribute it and/or modify it under the terms
 * of the GNU Lesser General Public License as published by the Free Software Foundation; 
 * either version 2.1 of the License, or (at your option) any later version.
 * 
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */

/**
 * This sketch is adapted from the DXF export processing library example, and
 * demonstrates the use of povwriter2 library to export raw processing data to
 * povray SDL
 * @author Martin Prout
 */

ArcBall arcball;
PovExporter export;
int[] DATA = {
  -1, 0, 1
};

/**
 * Processing Setup
 */

void setup() {
  size(400, 400, P3D);
  export = new PovExporter(this);
  arcball = new ArcBall(this);
  export.chooseTemplate();
  export.createIniFile(dataPath("balls.ini"), Quality.MEDIUM);
  noStroke();
  sphereDetail(18);
}

/**
 * Processing Draw
 */

void draw() {  
  lights();        // this needs to be outside the record loop
  export.beginRaw(dataPath("balls.pov"));
  if (export.traced()) {
    display();
  } 
  else {
    background(200);
    render();
  }

  export.endRaw();
}

/**
 * Display ray-traced image in sketch window
 */
void display() {
  PImage img = loadImage(dataPath("balls.png"));
  background(img);
}

/**
 * Render processing sketch
 */
void render() {
  for (int y : DATA) {
    for (int x : DATA) {
      for (int z : DATA) {
        pushMatrix();
        translate(120 * x, 120 * y, 120 * z);
        fill(random(255), random(255), random(255)); // a nice test for my colorFactory class
        export.sphere(30);
        popMatrix();
      }
    }
  }
}

