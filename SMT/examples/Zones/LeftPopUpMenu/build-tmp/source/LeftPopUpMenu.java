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

public class LeftPopUpMenu extends PApplet {

/**
 *  This examples shows use of the LeftPopUpMenuZone, which is a
 *  red arrow that when touched will toggle the display of a menu
 *  with buttons as named in the constructor. Press methods for 
 *  these buttons can then be used.
 */


public void setup() {
  size(400, 400, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  SMT.add(new LeftPopUpMenuZone(300, 100, 50, 50, 200, 100, "Button1", "Button2"));
}
public void draw() {
  background(79, 129, 189);
}
public void pressButton1() {
  println("First Button Pressed");
}
public void pressButton2() {
  println("Second Button Pressed");
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LeftPopUpMenu" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
