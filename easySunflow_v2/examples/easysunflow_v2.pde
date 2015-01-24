/**
 <<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>>
 *  easySunflow v02
 *  by Luigi De Aloisio, 2012
 
 	new features:
 	hemesh 		
 	hemesh 	instance
 	toxilibs 	
 	toxilibs instance
 	objloader	
 	timeline	
 	animator
 	
 	
 	plugin:
 	studio lights
 	camera orbit
 
 *  
 <<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>><><<<>>>
 */



//  IMPORT LIBRARIES
//----------------------------------------------------------------------
import javax.media.opengl.*;
import processing.opengl.*;
import remixlab.proscene.*;
import controlP5.*;

// toxi library
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.math.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.physics.constraints.*;
import toxi.processing.*;
//import toxi.color.*;
import toxi.math.noise.*;
import toxi.volume.*;

// hemesh library
import wblut.hemesh.core.*;
import wblut.processing.*;
import wblut.hemesh.subdividors.*;
import wblut.hemesh.creators.*;
import wblut.hemesh.modifiers.*;
import wblut.geom.*;
import wblut.math.*; 
import wblut.hemesh.tools.*;

// objloader
import saito.objloader.*;

import java.lang.reflect.*;
import java.util.Collections;
import java.util.Comparator;
//----------------------------------------------------------------------
//  globals
//----------------------------------------------------------------------
int AppletW=				1280;
int AppletH=                720;

PApplet sketchPApplet=	    this;
easySunflowAPI              ESF;
remixlab.proscene.Scene     thescene;
remixlab.proscene.Camera    thecamera;
Timeline                    timeline;
KeyFrameInterpolator 	    keyframeinterpolator;
ControlP5 		    		controlP5;
PMatrix3D 		    		currCameraMatrix;
PGraphics3D 		    	g3;
PImage                      backgroundimage;
color                       backgroundcolor;
boolean 		    		axisflag,shadingflag,camerapathflag;
ArrayList		    		keyframeslist;
Animator 					fovanimator;
WB_Render           	    renderHemesh;
ToxiclibsSupport    	    renderToxi;
 
//----------------------------------------------------------------------
// INIT 
//----------------------------------------------------------------------
void setup(){
  	size(AppletW, AppletH, OPENGL);
  
  	// configure OPENGL
  	hint(DISABLE_OPENGL_2X_SMOOTH);
  	hint(DISABLE_OPENGL_ERROR_REPORT);
  	hint(DISABLE_DEPTH_SORT);
  
   	//init application, gui & scene
  	initApplication();
	initApplicationGUI();
 	initScene();
}
void draw()	{
   
  	// 	set background image or color
  	//	background(backgroundimage);
  	background(backgroundcolor);
	lights();
	
	
	//grids & axis
  	if (grid_==2)  DotGrid();
  	else if (grid_==3) LineGrid();
  	if (axisflag)   Axis(100);
	
  	//--------------------------------------------------------------

  	//draw scene in processing 
  	ESF.SceneToProcessing();
	
  	//--------------------------------------------------------------
  	
  	//redraw interface
  	guiRedraw();
  	
}
void initApplication() {

	noSmooth();
	sphereDetail(6);
	backgroundimage = loadImage("data/black_pattern.jpg");
	backgroundimage.resize(AppletW, AppletH);
	backgroundcolor=color(50);
	
	// 	interface controller
	//..............................................................
	controlP5 = new ControlP5(this);
	
	// 	timeline for animations
	//..............................................................
	timeline=new Timeline(this);

  	// 	proscene scene
  	//..............................................................
	thescene = new remixlab.proscene.Scene(this); 
	thescene.setAxisIsDrawn(false);
	thescene.setGridIsDrawn(false);
	thescene.setCameraPathsAreDrawn(true);
	thescene.setRadius(1000); 
	//	thescene.disableKeyboardHandling();
	
	// 	proscene camera
	//..............................................................
	
	thecamera=thescene.camera();
	thecamera.frame().setWheelSensitivity(2.0);
	thecamera.frame().setFlySpeed(.001);
	 
	// camera settings
	thecamera.setPosition(new PVector(-30, -100, 1000));
	thecamera.lookAt( thecamera.sceneCenter() );
	thecamera.setUpVector(new PVector(0, 1, 0), true);
	keyframeinterpolator = thecamera.keyFrameInterpolator(thescene.path('1'));
	keyframeslist=new ArrayList();
	
	
	thescene.unregisterCameraProfile("FIRST_PERSON");
	thescene.unregisterCameraProfile("WHEELED_ARCBALL");
	thescene.removeAllShortcuts();
	thescene.setShortcut('e', remixlab.proscene.Scene.KeyboardAction.CAMERA_TYPE);
	
	//  easySunflow 
	//..............................................................
	ESF=new easySunflowAPI();
	ESF.setTargetCamera( thecamera);
	ESF.setFov(50);
	
	// render controllers
	//..............................................................
	renderHemesh	=new WB_Render(this);
	renderToxi	=new ToxiclibsSupport(this);
	
}
//----------------------------------------------------------------------
//  KEYS EVENTS
//----------------------------------------------------------------------
void keyReleased() {

  	if (key == 'b') ESF.CreateScene();
  	if (key == 'r') ESF.RenderToScreen();
  	if (key == 'p') ESF.RenderToFileProgressive();
  	if (key == 'v' && ESF.display!=null) ESF.display.setVisible(true);
  	if (key == 'c')	ESF.getCameraData();
  	if (key == 'w')	guiSetShadingMode(!shadingflag);
  	if (key == 'x')	guiCloseAllMenu();
  
 	 // timeline play/pause
  	if (key ==' ') {
   		if (timeline.isActive()) timeline.Pause();
    	else timeline.Start();
  	}
  	if (keyCode == TAB) {
    	timeline.Stop();
  	}
  	// animation loop
  	if (key =='3') {
    if (timeline.isLoop()) timeline.setRepeat(false);
    else timeline.setRepeat(true);
  }
  
  	// add keyframe to the camera
  	if (key == 'k' ) {

	// set the camera
    thecamera.lookAt( thecamera.at());
    thescene.camera().addKeyFrameToPath(1);
	// read camera data
	PVector[] cameradata=ESF.readCameraData();
    PVector pos=cameradata[0].get();
    PVector at=cameradata[1].get();
    PVector up=cameradata[2].get();
    float fov=ESF.fov;
    
    // console
    println("position: "+pos); 
    println("lookAt: "	+at); 
    println("upVector: "+up);
    println("fov: "		+fov); 

    String info="ESF.addKeyFrame(new PVector("+round3(pos.x)+","+round3(pos.y)+","+round3(pos.z)+"),new PVector("+round3(at.x)+","+round3(at.y)+","+round3(at.z)+"),new PVector("+round3(up.x)+","+round3(up.y)+","+round3(up.z)+"),"+(int)fov+");";
    keyframeslist.add(info);
    
    
    
  }
  	// show all keysframes
  	if (key == 'K' ) {
    println("\nkeyframes:");
    for (int i=0;i< keyframeslist.size();i++) {
      println(keyframeslist.get(i));
    }
  }
  
   	// add keyframe for fov
  	if (key == 'f' ) {
    fovanimator.addKeyFrame(timeline.getNow(), ESF.fov);
  }
  	// show all keysframes for fov
  	if (key == 'F' ) {
    println("\n fov keyframes:");
    println(fovanimator.getAllKeyFrames());
  }
  
  	// save/load gui status
  	if (key == 'o' ) {
  		guiSaveStatus();
  	}
  	if (key == 'u') {
  		guiLoadStatus();
  	}
  	
}
