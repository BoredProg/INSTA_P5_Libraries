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

public class PImage extends PApplet {

/**
 * This examples shows use of the ImageZone to store a PImage
 */


public void setup() {
  size(800, 800, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  SMT.add(new ImageZone(loadImage("moonwalk.jpg")));
}
public void draw() {
  background(79, 129, 189);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PImage" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
