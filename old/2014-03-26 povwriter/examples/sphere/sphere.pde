import povexport.*;
import povexport.ui.*;
import povexport.povwriter.*;

/**
 * The purpose of this example is to test the export of processing sketches to PovRAY
 * Copyright (C) 2011 Martin Prout
 * This library is free software; you can redistribute it and/or modify it under the terms
 * of the GNU Lesser General Public License as published by the Free Software Foundation; 
 * either version 2.1 of the License, or (at your option) any later version.
 * 
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */

PovExporter export;
float radius = 100.0;

void setup() {
  size(600, 600, P3D);       
  export = new PovExporter(this);        
  export.setPovrayPath("/usr/bin/povray"); // eg ArchLinux NB: normally set by installer
  export.chooseTemplate();
  export.createIniFile(dataPath("sphere.ini"), Quality.MEDIUM);
  export.lineWidth(1); // sets povray line width via a custom declare
}


void draw() {  
  lights();        // this needs to be outside the record loop
  export.beginRaw(dataPath("sphere.pov"));
  if (export.traced()) { // begin tracing
    display();
  } 
  else {
    background(100);
    translate(width / 2, height / 2, height / 2); // not using arcball
    export.setHue(Hue.RED_MARBLE);
    export.sphere(radius);
  }
  export.endRaw();  //end tracing
}

void display() {
  background(loadImage(dataPath("sphere.png")));
}

