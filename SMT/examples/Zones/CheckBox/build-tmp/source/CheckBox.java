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

public class CheckBox extends PApplet {

/**
 *  This examples show the use of the CheckBoxZone, and its state.
 *  It also shows use of get() to do a class cast to access
 *  the CheckBoxZone specific variable.
 */


public void setup() {
  size(400, 400, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  SMT.add(new CheckBoxZone("Checkbox",100,100,200,200));
}
public void draw() {
  background(79, 129, 189);
  text("Checked:"+SMT.get("Checkbox",CheckBoxZone.class).checked,50,50);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CheckBox" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
