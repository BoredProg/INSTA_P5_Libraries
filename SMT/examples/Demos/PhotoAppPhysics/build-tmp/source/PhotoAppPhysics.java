import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import vialab.SMT.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PhotoAppPhysics extends PApplet {

/**
 *  A photo album sketch!
 *  This sketch loads a few images, makes a few copies, and
 *  puts them in randomly sized ImageZones. The ImageZones are
 *  configured to be tossed using the physics engine, and can
 *  collide, bounce, etc.
 */


public void setup() {
  
  size(displayWidth, displayHeight, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);

  final int IMAGE_FILES=5;
  final int IMAGE_COPIES=4;
  PImage[] img = new PImage[IMAGE_FILES];

  for (int i=0; i < IMAGE_FILES; i++) {  
    img[i] = loadImage(i + ".jpg");
  }

  for (int i=0; i < IMAGE_FILES*IMAGE_COPIES; i++) {  
    SMT.add(new ImageZone("ImageZone", 
                          img[i%IMAGE_FILES], 
                           (int)random(0, displayWidth-400), 
                           (int)random(0, displayHeight-400), 
                           (int)random(300, 500), (int)random(100, 200)));
  }
  
  for(Zone z : SMT.getZones()){
    z.physics=true; 
  }
}

public void touchImageZone(Zone z) {
  SMT.putZoneOnTop(z);
  z.toss();
}

public void draw() {
  background(79, 129, 189);
  text(round(frameRate)+" fps", width/2, 10);
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PhotoAppPhysics" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
