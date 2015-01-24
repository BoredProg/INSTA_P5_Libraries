
/*
	
 	CAMERA ORBITS.
 	easeSunflow plugin	
 	 
 	Create Camera animation around scene center
 	
 */
//------------------------------------------------------------------
//------------------------------------------------------------------
CameraOrbit CameraOrbitPlugIn;

void InitCameraOrbitPlugIn() {
  if (CameraOrbitPlugIn==null) CameraOrbitPlugIn=new CameraOrbit(this);
}
public void cameraorbitmenu() {
  if (controlP5.controller("cameraorbitmenu").value()>0) CameraOrbitPlugIn.palette.show();
  else CameraOrbitPlugIn.palette.hide();
}	

//------------------------------------------------------------------
//  Camera Orbit  class
//------------------------------------------------------------------
class CameraOrbit implements ControlListener {

  PApplet 	applet;
  ControlP5 controller;
  Palette 	palette;
  boolean 	active;
  PVector 	eye, target, up;
  float 	distance,height;
   
   float		last;
	boolean changed;
	
  CameraOrbit(PApplet _applet) {

    applet=_applet;

    controller=new ControlP5(applet);
    controller.setColorBackground(gui_backcolor);
    controller.setColorForeground(gui_forecolor);
    controller.setColorActive(gui_activecolor);
    controller.setColorValue(gui_valuecolor);
    controller.setColorLabel(color(130));
    controller.setMoveable(false);

    // create palette for studio lights 
    palette=new Palette(controller, "Camera Orbit", this, 10, 10, 300, 200);
    palette.setBackground(color(30, 35, 39));
    palette.hide();

    initOrbit();
    initPalette();

    
    
  }

  //------------------------------------------------------------------
  // STUDIO LIGHTS INIT
  //------------------------------------------------------------------
  void 	initOrbit() {

    active=false;
    eye=thecamera.position().get();
    target=new PVector(0, 0, 0);
    up=new PVector(0, 1, 0);
    distance=PVector.dist(eye,target);
	height= eye.y;

    Animator co=new Animator(this, "CameraOrbitAnimation");
    co.setInterpolationType(co.SIGMOID_INTERPOLATION);
    co.addKeyFrame(0, 0f);
    co.addKeyFrame(timeline.getEnd(), 1f);
    timeline.addAnimator(co);
    timeline.Stop();
    
   
    
    
  }
  	void 	initPalette() {

    int lar =80;
    int px=20;
    int py=20;
    palette.addToggle("co_flag", false, px, py, 40, 15).setLabel("camera orbit off");
    py+=60;
    
   	palette.addBang("co_update", px, py, 40, 15).setLabel("capture camera");
    
    py+=40;
    Slider b1=palette.addSlider("co_distance", 10, 3000, 1000, px, py, lar, 20);
    b1.setLabel("camera distance");
    b1.captionLabel().style().setMarginLeft(5);

    py+=30;
    b1=(Slider)palette.addSlider("co_height", -2000, 2000, 500, px, py, lar, 20);
    b1.setLabel("camera height");
    b1.captionLabel().style().setMarginLeft(5);

    // add plugin to menu
    guiAddPlugin("cameraorbitmenu", "camera orbit", false);
  }

  	//------------------------------------------------------------------
	// CAMERA ORBIT METHODS
  	//------------------------------------------------------------------	

  	void 	setStudioParameter(String parameter, float v) {
    palette.setFieldValue(parameter, v);
  }
  	float 	getStudioParameter(String parameter) {
    return palette.getFieldValue(parameter);
  }
  	void 	setDistance(float v) {
    setStudioParameter("co_distance", v);
  } 
  
  //------------------------------------------------------------------
  // CAMERA ORBIT EVENTS
  //------------------------------------------------------------------
  	void controlEvent(ControlEvent theEvent) {
    Controller controller	=theEvent.controller();
    String selected			=theEvent.name();
    float value 			=controller.value();
    boolean flag			=value>0;

	if (selected=="co_flag") {
		controller.setLabel((flag)?"camera orbit on":"camera orbit off");
		active=flag;
		update();
    }
    if (selected=="co_distance" ) 	distance=value;
    if (selected=="co_height" ) 	height=-value;
	if (selected=="co_update" ) 	update();
	
    CameraOrbitAnimation(last);
  }
  	void update(){
  		eye=thecamera.position();
		distance=PVector.dist(eye,target);
		height= eye.y;
  	}
  	void setTarget(PVector _target){
  		target=_target;
  		update();
  	}
  	void CameraOrbitAnimation(float t) 	{
    
		if (!active) return;
	
		float angle=(t*TWO_PI)+HALF_PI;
		float x	= target.x+distance*cos(angle);
		float z	= target.z+distance*sin(angle);
		float y	= target.y+height;
		
		
		thecamera.setUpVector (up, true);
		thecamera.setPosition(new PVector(x, y, z));
		thecamera.lookAt(target );
	
		last=t;
  	}

}

