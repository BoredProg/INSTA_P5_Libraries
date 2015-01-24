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

public class SlideReveal extends PApplet {

/**
 * This shows how the SlideRevealZone is used. The red arrow can
 * be dragged to reveal the hidden text.
 */


public void setup() {
  size(400, 400, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  SMT.add(new SlideRevealZone(100,100,200,50,"Some hidden text."));
}
public void draw() {
  background(79, 129, 189);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SlideReveal" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
