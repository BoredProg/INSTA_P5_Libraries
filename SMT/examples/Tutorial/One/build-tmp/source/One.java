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

public class One extends PApplet {

/**
 * Sketch for Basics Tutorial 1
 */



//Setup function for the applet
public void setup(){
	//SMT and Processing setup
	size( displayWidth, displayHeight, SMT.RENDERER);
	SMT.init( this, TouchSource.AUTOMATIC);

	//Make a new Zone
	Zone zone = new Zone( "MyZone");
	SMT.add( zone);
}

//Draw function for the sketch
public void draw(){
	background( 30);
}

//Draw function for "MyZone"
public void drawMyZone( Zone zone){
	fill( 0xff88dd88);
	rect( 0, 0, 100, 100);
}

public void pickDrawMyZone( Zone zone){
	rect( 0, 0, 100, 100);
}
//Touch function for "MyZone"
public void touchMyZone( Zone zone){
	zone.rst();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "One" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
