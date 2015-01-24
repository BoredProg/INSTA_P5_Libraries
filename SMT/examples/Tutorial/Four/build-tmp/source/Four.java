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

public class Four extends PApplet {

/**
 * Sketch for Basics Tutorial 4
 */



//Setup function for the applet
public void setup(){
	//SMT and Processing setup
	size( 1200, 800, SMT.RENDERER);
	SMT.init( this, TouchSource.AUTOMATIC);

	//Single transformation zones
	Zone spinny = new Zone( "SpinnyZone", 110, 110, 100, 100);
	Zone draggy = new Zone( "DraggyZone", 220, 110, 100, 100);
	Zone scaley = new Zone( "ScaleyZone", 330, 110, 100, 100);

	//Double transformations
	Zone spinnydrag = new Zone( "SpinnyDragZone", 110, 310, 100, 100);
	Zone draggyscale = new Zone( "DraggyScaleZone", 220, 310, 100, 100);
	Zone scaleyspin = new Zone( "ScaleySpinZone", 330, 310, 100, 100);

	//Rst Zones
	Zone rst_a = new Zone( "RstZoneA", 110, 510, 100, 100);
	Zone rst_b = new Zone( "RstZoneB", 220, 510, 100, 100);
	Zone rst_c = new Zone( "RstZoneC", 330, 510, 100, 100);
	Zone rst_d = new Zone( "RstZoneD", 440, 510, 100, 100);
	Zone rst_e = new Zone( "RstZoneE", 550, 510, 100, 100);
	Zone rst_f = new Zone( "RstZoneF", 660, 510, 100, 100);

	//add all the zones
	SMT.add( spinny);
	SMT.add( draggy);
	SMT.add( scaley);
	SMT.add( spinnydrag);
	SMT.add( draggyscale);
	SMT.add( scaleyspin);
	SMT.add( rst_a);
	SMT.add( rst_b);
	SMT.add( rst_c);
	SMT.add( rst_d);
	SMT.add( rst_e);
	SMT.add( rst_f);
}

//Draw function for the sketch
public void draw(){
	background( 30);
	pushStyle();
	noStroke();
	fill( 200, 200);
	textAlign( LEFT, BOTTOM);
	textSize( 54);
	text( "Single Transformation Zones", 130, 100);
	text( "Double Transformation Zones", 130, 300);
	text( "Rst Zones", 130, 500);
	popStyle();
}

//Single transformation zone functions

public void drawSpinnyZone( Zone zone){
	noStroke();
	fill( 140, 160, 200, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchSpinnyZone( Zone zone){
	//this zone only spins
	zone.rotate();
}

public void drawDraggyZone( Zone zone){
	noStroke();
	fill( 200, 160, 140, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchDraggyZone( Zone zone){
	//this zone only drags
	zone.drag();
}

public void drawScaleyZone( Zone zone){
	noStroke();
	fill( 140, 200, 160, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchScaleyZone( Zone zone){
	//this zone only scales
	zone.scale();
}

//Double transformation zone functions

public void drawSpinnyDragZone( Zone zone){
	noStroke();
	fill( 200, 140, 160, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchSpinnyDragZone( Zone zone){
	//this zone spins and drags
	zone.rnt();
}

public void drawDraggyScaleZone( Zone zone){
	noStroke();
	fill( 180, 200, 140, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchDraggyScaleZone( Zone zone){
	//this zone drags and scales
	zone.pinch();
}

public void drawScaleySpinZone( Zone zone){
	noStroke();
	fill( 160, 140, 120, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchScaleySpinZone( Zone zone){
	//this zone spins and scales
	zone.rs();
}

//Rst zone functions

public void drawRstZoneA( Zone zone){
	noStroke();
	fill( 140, 120, 120, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchRstZoneA( Zone zone){
	//this zone spins, scales, and drags
	zone.rst();
}

public void drawRstZoneB( Zone zone){
	noStroke();
	fill( 180, 160, 200, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchRstZoneB( Zone zone){
	zone.rst( false, true, true);
}

public void drawRstZoneC( Zone zone){
	noStroke();
	fill( 180, 200, 160, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchRstZoneC( Zone zone){
	zone.rst( true, false, true);
}

public void drawRstZoneD( Zone zone){
	noStroke();
	fill( 220, 180, 110, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchRstZoneD( Zone zone){
	zone.rst( true, true, false);
}

public void drawRstZoneE( Zone zone){
	noStroke();
	fill( 180, 1140, 220, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchRstZoneE( Zone zone){
	zone.rst( true, true, true, false);
}

public void drawRstZoneF( Zone zone){
	noStroke();
	fill( 240, 240, 240, 180);
	rect( 0, 0, zone.width, zone.height);
}
public void touchRstZoneF( Zone zone){
	zone.rst( true, true, false, true);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Four" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
