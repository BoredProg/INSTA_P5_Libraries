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

public class Button extends PApplet {

/**
 * Demos the ButtonZone class.
 */


public void setup() {
  size(400, 400, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  SMT.add(new MyButtonZone("TestButton",100,100,200,200,"Button Text"));
}
public void draw() {
  background(79, 129, 189);
}
public void pressTestButton(){
  println("Button Pressed");
}

// SEB
// Test if subclass allows redrawing because it's ugly !!
public class MyButtonZone extends ButtonZone
{
  public void draw()
  {
    box(100);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Button" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
