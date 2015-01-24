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

public class Custom extends PApplet {

/**
 *  This example show how to define your own custom Zone. It will
 *  draw whatever is placed in the drawCustom() method, and the
 *  touchCustom() method defines what happens when it is touched.
 *
 *  These methods are based of the name given to the Zone, so
 *  your Zone "Test123" would use the methods: drawTest123() and
 *  touchTest123()
 */


public void setup() {
  size(400, 400, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  SMT.add(new Zone("Custom",0,0,200,200));
}
public void draw() {
  background(79, 129, 189);
}
public void drawCustom(){
  background(0);
  fill(255);
  //ellipse(100,100,100,100); 
  box(100);
}
public void touchCustom(Zone z){
  z.rst();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Custom" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
