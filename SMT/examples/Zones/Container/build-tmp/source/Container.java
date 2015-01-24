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

public class Container extends PApplet {

/**
 *  This example show the use of ContainerZone, which by default
 *  has no visual representation, and is perfect to use to hold
 *  other Zones. In this example it is used to apply a rotation
 *  to its child Zones, in this case a ButtonZone
 */


public void setup() {
  size(400, 400, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  SMT.add(new ContainerZone("RotatedContainer",0,0,400,400));
  SMT.get("RotatedContainer").rotateAbout(PI/4,CENTER);
  SMT.get("RotatedContainer").add(new ButtonZone("TestButton",100,100,200,200,"Button Text"));
}
public void draw() {
  background(79, 129, 189);
}
public void pressTestButton(){
  println("Button Pressed");
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Container" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
