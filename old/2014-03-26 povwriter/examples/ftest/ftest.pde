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
 * This sketch demonstrates the use of retained shape in processing-2.0
 * @author Martin Prout
 */

PovExporter export;
ArcBall arcball;
PShape letterF;

/**
 * Processing Setup
 */

void setup() {
  size(500, 500, P3D);
  export = new PovExporter(this);
  arcball = new ArcBall(this);
  arcball.constrain(Constrain.YAXIS);
  export.chooseTemplate();
  
  // Quality PREVIEW, MEDIUM, HIGH, HIGHEST, GRAYSCALE
  export.createIniFile(dataPath("ftest.ini"), Quality.HIGH);
  export.scalePovray(1.5);           // use a declare to scale in povray
  letterF = createShape(PShape.GROUP);
  PShape stem = createShape(PShape.BOX, 50.0f, 200.0f, 50.0f);
  PShape top = createShape(PShape.BOX, 50.0f, 50.0f, 50.0f);
  PShape middle = createShape(PShape.BOX, 50.0f, 50.0f, 50.0f);
  letterF.addChild(stem);
  middle.translate(50.0f, 0.0f, 0);
  letterF.addChild(top);
  top.translate(50.0f, -75.0f, 0);
  letterF.addChild(middle);
  letterF.setFill(color(200, 0, 0));       // setting PShape fill directly 
}

/**
 * Processing Draw
 */

void draw() { 
  if (export.traced()) { // begin tracing
    display();
  } 
  else { 
    lights();        // this needs to be outside the record loop
    background(200);    
    export.beginRaw(dataPath("ftest.pov"));
    export.update();  // without this don't see button
    shape(letterF);
    export.endRaw();  //end tracing
  }
}


/**
 * Display ray traced image in sketch window
 */
void display() {
  background(loadImage(dataPath("ftest.png")));
}


