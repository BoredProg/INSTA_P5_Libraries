//------------------------------------------------------------------
//  init the scene
//------------------------------------------------------------------
void initScene() {
	// seed
	randomSeed(1);
  	noiseSeed(1);
  	
  	
  	////////////////////////////////////////////////////////////////////////////////
  	//  set easysunflow properties
	ESF.clearAll();							// reset all
	ESF.setOutputSize(1280, 720); 			// output image size
	ESF.setScaledOutput(2); 				// output image divided by 2
	ESF.setImageFormat(ESF.IMAGEFORMAT_PNG);// output image kind
	ESF.setIBL("hdri/panorama01.hdr");		// set image for image-based lighting  
	
  	// set timeline fps and duration for animation
  	timeline.setFPS(25);
  	timeline.setDuration("00:00:15:00");
  	
	// 	Animator for PROSCENE CAMERA & FOV
	ProsceneAnimator();
	////////////////////////////////////////////////////////////////////////////////
	
	// 	init plugin
  	InitStudioLightPlugin();
  	InitCameraOrbitPlugIn();
  	
  	// shaders preset
 	//InitShaderPreset();
	
	// 	set scene properties
  	guiSetSceneDetails(80);
  	guiSetSunVisible(true);
  	guiSetShadingMode(false);
  	
  	
  	// 	add elements to scene
	//..............................................................
		EXAMPLE_PRIMITIVES();
		//EXAMPLE_LIGHTS();
		//EXAMPLE_COLORS();
		//EXAMPLE_SHADERS();
		//EXAMPLE_TIMELINE();
		//EXAMPLE_KEYFRAMES();
		//EXAMPLE_PARTICLES();
		//EXAMPLE_TOXILIBS();
		//EXAMPLE_TOXILIBS_INSTANCES();
		//EXAMPLE_TOXILIBS_STL();
		//EXAMPLE_HEMESH();
		//EXAMPLE_HEMESH_INSTANCES();
		//EXAMPLE_HEMESH_ANIMATION();
		//EXAMPLE_OBJLOADER();
		//EXAMPLE_OBJLOADER_INSTANCES();
		//EXAMPLE_OVERRIDESHADER(); 
		//EXAMPLE_MODIFIER();
		
	//..............................................................
	
	
	
	
	
	
  	
}
