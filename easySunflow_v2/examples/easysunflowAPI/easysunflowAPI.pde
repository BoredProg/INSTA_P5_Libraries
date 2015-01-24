/**
 * 	easySunflow API v02
 * 	by Luigi De Aloisio, 2012
 *
 *	luigi.dealoisio@nostatic.it
 *	http://www.nostatic.it
 *
 *	
 *
 *
 */
import org.sunflow.SunflowAPI;
import org.sunflow.system.ImagePanel;

import javax.swing.JFrame;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.channels.FileChannel.MapMode;

import org.sunflow.PluginRegistry;
import org.sunflow.core.ShadingState;

import remixlab.proscene.*; 

//------------------------------------------------------------------------------
// easySunflow class
//------------------------------------------------------------------------------
public class easySunflowAPI {
  public final String COLORSPACE_SRGB_NONLINEAR = "sRGB nonlinear";
  public final String COLORSPACE_SRGB_LINEAR 	= "sRGB linear";
  public final String COLORSPACE_XYZ 			= "XYZ";

  public final String BUCKET_ORDER_COLUMN 		= "column";
  public final String BUCKET_ORDER_DIAGONAL 	= "diagonal";
  public final String BUCKET_ORDER_HILBERT 		= "hilbert";
  public final String BUCKET_ORDER_RANDOM 		= "random";
  public final String BUCKET_ORDER_ROW  		= "row";
  public final String BUCKET_ORDER_SPIRAL 		= "spiral";
  public final String FILTER_BLACKMAN_HARRIS 	= "blackman-harris";
  public final String FILTER_BOX 				= "box";
  public final String FILTER_CATMULL_ROM  		= "catmull-rom";
  public final String FILTER_GAUSSIAN  			= "gaussian";
  public final String FILTER_LANCZOS 			= "lanczos";
  public final String FILTER_MITCHELL  			= "mitchell";
  public final String FILTER_SINC 				= "sinc";
  public final String FILTER_TRIANGLE  			= "triangle";
  public final String FILTER_BSPLINE 			= "bspline";

  public final String PINHOLE 					= "pinhole";
  public final String THINLENS 					= "thinlens";
  public final String FISHEYE 					= "fisheye";
  public final String SPHERICAL 				= "spherical";

  public final String IMAGEFORMAT_TGA  			= ".tga";
  public final String IMAGEFORMAT_PNG  			= ".png";
  public final String IMAGEFORMAT_JPG  			= ".jpg";

  int imageSizeW, imageSizeH, currentImageSizeW, currentImageSizeH;
  int giPathDiffuse, giPathReflection, giPathRefraction, giPathSamples, giAOSamples, giAODistance;
  int aaMin, aaMax, previewAaMin, previewAaMax, currBucketSize;

  float fov, aspect, cameraFocalDistance, cameraLensRadius, scenedetails,cajitterdetail,cajitteramplitude;
  boolean renderIpr, renderflag, lightsflag, ibllightsflag, renderanimationflag,cameractionflag;
  String currCamera, cameraType, currBucketOrder, currFilter;
  String sketchfolder, colorSpace, imageFormat, GItype;

  SunflowAPI sunflow;
  SunflowShader defaultshader, defaultoverride, shaderOverride;
  SunLight thesun;
  IBLight ibllight;
  remixlab.proscene.Camera camera_;
  RenderWindow display;

  ArrayList _geometry, _shaders, _lights, _modifier, _toxiobj,_keyfov;
  //Point3 eye, target;
  //Vector3 up;
  PVector eye, target;
  PVector up;
  
  String imagesfolder="images/image";
  String renderfolder="render/frame";
 

  public easySunflowAPI() {
    Init();
  }
  private void Init() {


    sketchfolder=sketchPath("");
    setOutputSize(1280, 720);
    setScaledOutput(2);
    sunflow = new SunflowAPI();

    colorSpace				= COLORSPACE_SRGB_NONLINEAR;
    currBucketOrder 		= BUCKET_ORDER_SPIRAL;
    currFilter 				= FILTER_MITCHELL;
    currBucketSize  		= 64;
    // camera
    currCamera 				= "";
    cameraFocalDistance		= 100;
    cameraLensRadius		= 1;
    fov 					= 50;
    aspect 					= (float) imageSizeW/imageSizeH;
    // camera position
    eye = new PVector(0, 50, 100);
    target =new PVector(0, 0, 0);
    up 						= new PVector(0, 1, 0);
    GItype					="";
    giPathDiffuse			= 1;
    giPathReflection		= 4;
    giPathRefraction		= 4;
    giPathSamples			= 32;
    giAOSamples				= 64;
    giAODistance			= 60;
    //flag
    lightsflag				= true;
    renderflag				= false;
    renderanimationflag		= false;
    cameractionflag			= false;
    scenedetails			= 1;
    
    cajitterdetail=.02;
    cajitteramplitude=.5;

    _geometry				=new ArrayList();
    _shaders				=new ArrayList();
    _lights					=new ArrayList();
    _modifier				=new ArrayList();
    _toxiobj				=new ArrayList();
    _keyfov					=new ArrayList();


    // dafault parameter
    //--------------------------------------------------
    thesun=new SunLight();
    thesun.setLatitude(10);
    thesun.extendsky=true;

    ibllight	=new IBLight("hdri/sky_small.hdr");
    ibllight.setVisible(false);

    // default shader
    defaultshader	=new ShaderDiffuse("default", new SunflowColor(.9, .9, .9));
    defaultoverride	=new ShaderAO("AOoverridedefault", new SunflowColor(.9, .9, .9), 32, 64);
    

    // render parameters
    //--------------------------------------------------
    setColorSpace(COLORSPACE_SRGB_NONLINEAR);
    setRenderMode("ipr");
    setCameraType(PINHOLE);
    setRenderAnimation(false);
    

	// add
    PluginRegistry.shaderPlugins.registerPlugin("wireframeao", WireAOShader.class);
   	PluginRegistry.giEnginePlugins.registerPlugin("fake2", FakeGIEngine2.class);
    
    // scene parameters
    //--------------------------------------------------
  }
  //------------------------------------------------------------------------------
  // GETTER/SETTER
  //------------------------------------------------------------------------------
  
  SunflowShader PaletteShader(SunflowShader sh){
	
	color c0=sh.col.toColor();
	
 	 
 	
 	for (Iterator it=_shaders.iterator(); it.hasNext();) {
      SunflowShader shader = (SunflowShader)it.next();
      
      color c1=shader.col.toColor();
     
     
      if (toR(c0)==toR(c1) && toG(c0)==toG(c1)&& toB(c0)==toB(c1)){
      	return shader;
      }
      
    }
    addShader(sh);
    
 	return sh;
}
  
  
  public void setWidth(int width) {
    this.imageSizeW = width;
  }
  public int  getWidth() {
    return imageSizeW;
  }
  public void setHeight(int height) {
    this.imageSizeH = height;
  }
  public int  getHeight() {
    return imageSizeH;
  }
  public int  getAaMin() {
    return aaMin;
  }
  public void setAaMin(int aaMin) {
    this.aaMin = aaMin;
  }
  public int  getAaMax() {
    return aaMax;
  }
  public void setAaMax(int aaMax) {
    this.aaMax = aaMax;
  }
  public void setAA(int amin, int amax) {
    aaMin=amin;
    aaMax=amax;
  }
  /**
   *  setAA
   *
   * 	@param quality String
   * 	quick undersampled preview: -2 0
   *  	preview with some edge refinement: 0 1
   *  	final hi quality rendering: 1 2
   * 	dof best quality rendering: 1 4
   */
  public void 	setAA(String quality) {
    if (quality=="quick") {
      aaMin=-1;
      aaMax=-1;
    }
    if (quality=="preview") {
      aaMin=0;
      aaMax=1;
    }
    if (quality=="final") {
      aaMin=1;
      aaMax=2;
    }
    if (quality=="dof") {
      aaMin=1;
      aaMax=4;
    }
  }
  public void 	setOutputSize(int w, int h) {
    imageSizeW=w;
    imageSizeH=h;
    currentImageSizeW=imageSizeW;
    currentImageSizeH=imageSizeH;
  }

  public void setFilter(String f) {
    currFilter=f;
  }
  public void setColorSpace(String cs) {
    colorSpace=cs;
  }
  
  public int[] 	getOutputSize() {
    int[] dim= {
      currentImageSizeW, currentImageSizeH
    };
    return dim;
  }
  public void 	setScaledOutput(int d) {
    currentImageSizeW=(int)imageSizeW/d;
    currentImageSizeH=(int)imageSizeH/d;
  }
  public void 	setRenderProgress(boolean v) {
    renderflag=v;
  }
  public boolean getRenderProgress() {
    return renderflag;
  }
  public void 	setRenderAnimation(boolean v) {
    renderanimationflag=v;
  }
  public boolean getRenderAnimation() {
    return renderanimationflag;
  }
  
  // render mode ipr || bucket
  public void setRenderMode(String mode) {
    renderIpr=(mode=="ipr" || mode =="IPR")?true:false;
  }
  // global illumination
  public void setGI_NONE() {
    GItype="none";
  }
  public void setGI_PATHTRACING() {
    GItype="path";
  }
  public void setGI_AO() {
    GItype="ao";
  }
  public void setGI_INSTANT() {
    GItype="igi";
  }
  public void setGI_IRRADIANCE() {
    GItype="irradiance";
  }
  public void setGI_FAKE() {
    GItype="fake2";
  }
  public void setSHADEROVERRIDE() {
    GItype="shaderoverride";
  }

  public void setSceneDetails(float v) {
    scenedetails= v/100.0f;
  }
  public void setShadingMode(boolean flag) {
    shadingflag = flag;
  }
  public void setImageFormat(String type) {
    imageFormat=type;
  }

 

  public float getSceneDetails(int maxv) {
    float step =maxv/(maxv*scenedetails);
    return step;
  }
  public String getImageFormat( ) {
    return imageFormat;
  }

  //------------------------------------------------------------------------------
  // scene list
  //------------------------------------------------------------------------------
  public void addLight(SunflowLight light) {
    _lights.add(light);
    guiConsole("add light: "+light.name);
  }
  public void addGeometry(String name, Geometry obj) {
    obj.setName(name);
    Object[] item= {"geometry", obj};
    _geometry.add(item);
  }
  public void addModifier(SunflowModifier modifier) {
    _modifier.add(modifier);
  }
  public void addShader(SunflowShader shader) {
    _shaders.add(shader);
    guiConsole("add shader: "+shader.name);
  }

  public void includeGeometry(String path) {
    Object[] item= {"include", path};
    _geometry.add(item);
    
     
  }
  public void setOverrideShader(SunflowShader shader) {
    shaderOverride=shader;
  }
  public SunflowShader getOverrideShader( ) {
    if (shaderOverride!=null) return shaderOverride;
    return defaultoverride;
  }

	public void setIBL(String path) {
    ibllight.setPath(path);
    guiConsole("set IBL path: "+path);
  }
	public void setIBLLightsVisible(Boolean flag) {
    ibllight.setVisible(flag);
  }
	public void setSunVisible(boolean flag) {
    thesun.setVisible(flag);
  }
	public void setLightsVisible(boolean flag) {
	lightsflag=flag;
    for (int j = 0; j <_lights.size() ; j++) {
      	SunflowLight light = (SunflowLight)_lights.get(j);
      	boolean test=(light instanceof IBLight) || (light instanceof SunLight) || (light.extra);
   	 	if (!test) light.setVisible(flag);
    }
  }

  public void clearGeometry( ) {
    _geometry.clear();
     //_toxiobj.clear();
  }
  public void clearLights( ) {
    _lights.clear();
  }
  public void clearShaders( ) {
    _shaders.clear();
  }
  public void clearModifier( ) {
    _modifier.clear();
  }
  public void clearAll( ) {
    clearGeometry();
    clearLights();
    clearShaders();
    clearModifier( );

   

    if (thesun!=null) addLight(thesun);
    if (ibllight!=null) addLight(ibllight);

    addShader(defaultshader);
    addShader(defaultoverride);
    
  }
  //------------------------------------------------------------------------------
  // CAMERA
  //------------------------------------------------------------------------------
  	public remixlab.proscene.Camera getCamera() {
    	return camera_;
  	}
  	public void setTargetCamera(remixlab.proscene.Camera cam) {
    camera_=cam;
  	}
  	public void setCameraType(String type) {
    	cameraType=type;
  	}
  	private void setPinholeCamera(String name) {
    if (camera_==null) {
      guiConsole("camera not found");
      return;
    };
    readCameraData();
    sunflow.parameter("transform", Matrix4.lookAt(eye, target, up));
    sunflow.parameter("fov", fov);
    sunflow.parameter("aspect", aspect);

    sunflow.camera(name, PINHOLE);
    currCamera = name;
  }
  	private void setFisheyeCamera(String name) {
    if (camera_==null) {
      guiConsole("camera not found");
      return;
    };
    readCameraData();

    sunflow.parameter("transform", Matrix4.lookAt(eye, target, up));
    sunflow.camera(name, FISHEYE);
    currCamera = name;
  }
  	private void setSphericalCamera(String name) {
    if (camera_==null) {
      guiConsole("camera not found");
      return;
    };
    readCameraData();

    sunflow.parameter("transform", Matrix4.lookAt(eye, target, up));
    sunflow.camera(name, SPHERICAL);
    currCamera = name;
  }
  	private void setThinlensCamera(String name) {
    if (camera_==null) {
      guiConsole("camera not found");
      return;
    };

    readCameraData();
    sunflow.parameter("transform", Matrix4.lookAt(eye, target, up));
    sunflow.parameter("fov", fov);
    sunflow.parameter("aspect", aspect);
    sunflow.parameter("focus.distance", cameraFocalDistance);
    sunflow.parameter("lens.radius", cameraLensRadius);

    sunflow.parameter("sides", 6);
    sunflow.parameter("rotation", 36);

    sunflow.camera(name, THINLENS);
    currCamera = name;
  }
  	public void setCameraFocalDistance(float fdist) {
    cameraFocalDistance= fdist;
  }
  	public void setCameraLensRadius(float lensr ) {
    cameraLensRadius=lensr;
  }
  
  	// camera action 
  	public void ActionCameraSwitch(boolean flag){
  		cameractionflag=flag;
  	}
  	public void setActionCameraParameters(float _jitterdetail,float _jitteramplitude){
  		cajitterdetail=_jitterdetail;
  		cajitteramplitude=_jitteramplitude;
  	}
  	public void ActionCamera(){
  		if (!cameractionflag || cajitteramplitude==0) return;
  		
  		PVector cam=camera_.position().get();
		float jitter=.5-noise(cam.x*cajitterdetail,cam.z*cajitterdetail);
		 
		PVector offset=new PVector(0,jitter*cajitteramplitude,0);
		cam.add(offset);

		//camera_.setUpVector (new PVector(0,1,jitter*.1), true);
		camera_.setPosition(cam);
		
  	}
	
	
	//------------------------------------------------------------------------------
  	//  CAMERA UTILITY
  	//------------------------------------------------------------------------------
  	public PVector[] readCameraData() {
    if (camera_==null) guiConsole("no camera");

    //peasycam
    //-------------------------------------------------
    //float[] peasycameye=camera_.getPosition();
    //float[] peasycamtarget= camera_.getLookAt();
    //eye =new PVector(peasycameye[0],-peasycameye[1],peasycameye[2]);
    //target =new PVector(peasycamtarget[0],-peasycamtarget[1],peasycamtarget[2]);

    //proscene
    //-------------------------------------------------
    PVector center=camera_.position().get();
    PVector lookAt=camera_.at().get();
    PVector upv=camera_.upVector().get();

    eye =new Point3(center.x, -center.y, center.z);
    target =new Point3(lookAt.x, -lookAt.y, lookAt.z);
    up  =new Vector3(-upv.x, upv.y, -upv.z);

    //-------------------------------------------------
    PVector[] data={center,lookAt,upv};
    return data;
  }
	public void setFov(float fov) {
    	this.fov=fov;
    	camera_.setFieldOfView(radians(fov*.6));
  	}
	public void setCamera(float[] data) {
  		camera_.setPosition(new PVector(data[0], data[1], data[2]));
  		camera_.lookAt(new PVector(data[3], data[4], data[5]));
  		camera_.setUpVector(new PVector(data[6], data[7], data[8]), true);
  		setFov(data[9]);
	} 
	public void setCamera(PVector eye,PVector target,PVector up) {
		camera_.setUpVector(up, true);
  		camera_.setPosition(eye);
  		camera_.lookAt(target);
  		
	} 
	
	public void SaveCamera() {
		guiMessage("save camera");
		
		PVector[] cam= readCameraData();
		
		float[] data = {cam[0].x, cam[0].y, cam[0].z, cam[1].x, cam[1].y, cam[1].z, cam[2].x, cam[2].y, cam[2].z,fov};
		PrintWriter output = createWriter("data/camerastatus.txt");
		for (int i=0;i<data.length;i++) {
			output.println(data[i]);
		}
		output.flush();
		output.close();
	}
	public void LoadCamera() {
  		guiMessage("load camera");
  		String[] data = loadStrings("data/camerastatus.txt");
  		thecamera.setPosition(new PVector(float(data[0]), float(data[1]), float(data[2])));
  		thecamera.lookAt( new PVector(float(data[3]), float(data[4]), float(data[5])));
  		thecamera.setUpVector(new PVector(float(data[6]), float(data[7]), float(data[8])), true);
  		
  		guiSetFOV(int(data[9]));
	}
	
	public void addKeyFrame(PVector eye, PVector target, PVector up,float fov) {
  		setFov(fov);
  		setCamera(eye,target,up);
  		thecamera.addKeyFrameToPath(1);
  		 
  		
  		
  		
	}
	public void addKeyFrame(PVector eye, PVector target, PVector up) {
  		setCamera(eye,target,up);
  		thecamera.addKeyFrameToPath(1);
	}
	
	public void getkeyfov(float t){
	}
	public void getCameraData(){
 	
  		PVector[] data=ESF.readCameraData();
  
  		PVector eye=data[0];
  		PVector target=data[1];
  		PVector up=data[2];
  		 
   
  		float[] out = {eye.x, eye.y, eye.z, target.x, target.y, target.z, up.x, up.y, up.z,fov};
   
  		String camera="camera data {";
  		for (int i=0;i<out.length;i++) {
    	camera+=out[i]+",";
  	}
  		camera=camera.substring(0, camera.length()-1);
  		camera+="}";
  		guiConsole(camera);
  	 
	}
	
	public void CameraDump(){
	
		PVector[] data=ESF.readCameraData();
  
  		PVector eye=data[0];
  		PVector target=data[1];
  		PVector up=data[2];
		// console
    	println("eye: "+eye); 
    	println("target: "	+target); 
    	println("up: "+up);
    	println("fov: "		+fov); 
	}
	
  //------------------------------------------------------------------------------
  // GLOBAL ILLUMINATION
  //------------------------------------------------------------------------------
  public void setAmbientOcclusionEngine(SunflowColor bright, SunflowColor dark, int samples, float maxDist) {
    sunflow.parameter("gi.engine", "ambocc");
    sunflow.parameter("gi.ambocc.bright", 	colorSpace, bright.r, bright.g, bright.b);
    sunflow.parameter("gi.ambocc.dark", 	colorSpace, dark.r, dark.g, dark.b);
    sunflow.parameter("gi.ambocc.samples", 	samples);
    sunflow.parameter("gi.ambocc.maxdist", 	maxDist);
    sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
  }
  // fake gi engine
  public void setFakeGIEngine(Vector3 up, SunflowColor sky, SunflowColor ground) {
    sunflow.parameter("gi.engine", "fake2");
    sunflow.parameter("gi.fake2.up", up);
    sunflow.parameter("gi.fake2.sky", colorSpace, 	sky.r, sky.g, sky.b);
    sunflow.parameter("gi.fake2.ground", colorSpace, ground.r, ground.g, ground.b);
    sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
  }
  //Instant Gi Engine
  public void setInstantGIEngine(int samples, int sets, float c, int bias_samples) {
    sunflow.parameter("gi.engine", "igi");
    sunflow.parameter("gi.igi.samples", samples);
    sunflow.parameter("gi.igi.sets", 	sets);
    sunflow.parameter("gi.igi.c", 		c);
    sunflow.parameter("gi.igi.bias_samples", bias_samples);
    sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
  }
  // Irradiance Cache GI Engine
  public void setIrradianceCacheGIEngine(int samples, float tolerance, float minSpacing, float maxSpacing, String globalphotonmap) {
    sunflow.parameter("gi.engine", "irradiance");
    sunflow.parameter("gi.irr-cache.samples", 		samples);
    sunflow.parameter("gi.irr-cache.tolerance", 	tolerance);
    sunflow.parameter("gi.irr-cache.min_spacing", 	minSpacing);
    sunflow.parameter("gi.irr-cache.max_spacing", 	maxSpacing);
    sunflow.parameter("gi.irr-cache.gmap", 			globalphotonmap);
    sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
  }
  public void setPathTracingGIEngine() {
    sunflow.parameter("gi.engine", "path");
    sunflow.parameter("gi.path.samples", giPathSamples);
    sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
  }
  public void setPathTracingParameters(int diffuse, int reflection, int refraction, int transparency) {
    sunflow.parameter("depths.diffuse", 		diffuse);
    sunflow.parameter("depths.reflection", 	reflection);
    sunflow.parameter("depths.refraction", 	refraction);
    sunflow.parameter("depths.transparency", transparency);
    sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
  }
  //------------------------------------------------------------------------------
  // EXPORT
  //------------------------------------------------------------------------------
  public void SceneToProcessing() {

    for (int j = 0; j <_lights.size() ; j++) {
      SunflowLight light = (SunflowLight)_lights.get(j);
      if (light.isVisible( )) light.draw();
    }

    Object[] item;
    float step= 1;
    if (_geometry.size()>1000) step= getSceneDetails(_geometry.size());
    for (int j = 0; j <_geometry.size(); j+=step) {
      item = (Object[] )_geometry.get((int)j);
      if (item[1] instanceof Geometry) {
        ((Geometry)item[1]).draw();
      }
    }


    pushMatrix();
    scale(1, -1, 1);
    for (int j = 0; j <_toxiobj.size() ; j++) {
      Object obj = _toxiobj.get(j);

      //spline
      if (obj instanceof Spline3D)renderToxi.lineStrip3D(((Spline3D)obj).getDecimatedVertices(8));

      // 	plane
      // 	sphere
      if (obj instanceof toxi.geom.Sphere) 	renderToxi.sphere((toxi.geom.Sphere)obj, 6);

      // 	box
      //	line
      if (obj instanceof Line3D) 	renderToxi.points3D(((Line3D)obj).splitIntoSegments(null, 10, true));
    }
    popMatrix();
  }
  public void CreateScene() {
    guiConsole("start sunflow scene........");
    String output="";
    sunflow.reset();
    sunflow.searchpath("texture", sketchfolder);
    sunflow.searchpath("include", sketchfolder);
    
    // default primitive
    sunflow.geometry( "Cube_", "box" );
    sunflow.geometry( "Sphere_", "sphere" );

    //GI
    setPathTracingParameters(giPathDiffuse, giPathReflection, giPathRefraction, 10 );
    if (GItype=="path")  		setPathTracingGIEngine();
    if (GItype=="ao")  			setAmbientOcclusionEngine(new SunflowColor(1, 1, 1), new SunflowColor(0, 0, 0), giAOSamples, giAODistance);
    if (GItype=="fake2")  		setFakeGIEngine(up, new SunflowColor(1, 1, 1), new SunflowColor(0, 0, 0));
    if (GItype=="irradiance") 	setIrradianceCacheGIEngine(64, 0.01, 0.05, 5.0, "global 1000000 grid 100 0.75");
    if (GItype=="igi")  		setInstantGIEngine(32, 1, 0.01, 0);
   
   // add modifier
    guiConsole("add modifiers");
    for (int j = 0; j <_modifier.size() ; j++) {
      SunflowModifier modifier = (SunflowModifier)_modifier.get(j);
      modifier.toSCA(this);
    }
    // add lights
    guiConsole("add lights");
    for (int j = 0; j <_lights.size() ; j++) {
      SunflowLight light = (SunflowLight)_lights.get(j);
      if (light.isVisible( )) {
        light.toSCA(this);
      }
    }
    // add shaders
    guiConsole("add shaders");
    for (Iterator it=_shaders.iterator(); it.hasNext();) {
      SunflowShader shader = (SunflowShader)it.next();
      shader.toSCA(this);
    }
    // add geometry
    guiConsole("add geometry: wait...");
    for (int j = 0; j <_geometry.size() ; j++) {
      Object[] item = (Object[] )_geometry.get(j);
      if (item[0]=="include") {
        String path=(String)item[1];
        sunflow.include(path);
      }
      if (item[0]=="geometry") {
        Geometry obj=(Geometry)item[1];
        obj.toSCA(this);
      }
    }
    //camera
    guiConsole("set camera: "+cameraType);
    if (cameraType==PINHOLE) 	setPinholeCamera("maincamera");
    if (cameraType==THINLENS)  	setThinlensCamera("maincamera");
    if (cameraType==FISHEYE)	setFisheyeCamera("maincamera");
    if (cameraType==SPHERICAL)	setSphericalCamera("maincamera");
    
	// shader override
    if (GItype=="shaderoverride" ) {
    
        if (shaderOverride==null)	shaderOverride=defaultoverride;
        
     	sunflow.parameter("override.shader", shaderOverride.name);
       	sunflow.parameter("override.photons", false);
        sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
     	
      	guiConsole("set shader override: "+shaderOverride.name);
      	 
    }

    guiConsole("end sunflow scene........");
  }
  //------------------------------------------------------------------------------
  // RENDER
  //------------------------------------------------------------------------------
  private void setRenderParameters() {
    
    // rendering options
    sunflow.parameter("camera", 	currCamera);
    sunflow.parameter("resolutionX", (int)(currentImageSizeW));
    sunflow.parameter("resolutionY", (int)(currentImageSizeH));
    sunflow.parameter("aa.min", 	aaMin);
    sunflow.parameter("aa.max", 	aaMax);
    sunflow.parameter("aa.jitter", false);
    //sunflow.parameter("aa.contrast", .016f);
    //sunflow.parameter("samples",  4);

    if ( aaMin>0 || aaMax>0) sunflow.parameter("filter", currFilter);
    if (renderIpr)
    {
      sunflow.parameter("sampler", "ipr");
    }
    else
    {
      sunflow.parameter("sampler", "bucket");
      sunflow.parameter("bucket.order", currBucketOrder);
      sunflow.parameter("bucket.size", currBucketSize);
    }
    
    
    //
    if (display==null) display = new RenderWindow(currentImageSizeW, currentImageSizeH);
    display.setDimension(currentImageSizeW, currentImageSizeH);
  }
  public void RenderToScreen() {
    if (renderflag) return;
    guiMessage("render to screen");
    CreateScene();
    setRenderParameters();
    ThreadRender render = new ThreadRender(this, "");
    render.start();
  }
  public void RenderToFile(String name) {
    if (renderflag) return;
    
    guiMessage("render to file: "+name);
    CreateScene();
    setRenderParameters();
    ThreadRender render = new ThreadRender(this, name);
    render.start();
  }
  public void RenderToFileProgressive() {
    if (renderflag) return;
    timeline.setRepeat(false);

    guiMessage("render to file");
    CreateScene();
    setRenderParameters();
    String name=renderfolder+TimeStamp()+getImageFormat();
    ThreadRender render = new ThreadRender(this, name);
    render.start();
  }
  public void SaveImage(String name) {
    if (display==null) return;
    guiMessage("save current image: "+name);
    String path=sketchfolder+name;
    display.imagePanel.save(path);
  }
  public void SaveImage() {
    if (display==null) return;
    String name=imagesfolder+TimeStamp()+getImageFormat();
    display.imagePanel.save(sketchfolder+name);
    //guiMessage("save current image: "+name);
  }
	
  //------------------------------------------------------------------------------
  // SunflowEngine utility
  //------------------------------------------------------------------------------
  public Matrix4 setTransformMatrix(Geometry obj) {
    Matrix4 translate = Matrix4.IDENTITY.multiply(Matrix4.translation(obj.position.x, obj.position.y, obj.position.z ));
    Matrix4 scale  = Matrix4.IDENTITY.multiply(Matrix4.scale(obj.size.x, obj.size.y, obj.size.z) );
    Matrix4 rotate = Matrix4.IDENTITY
    .multiply( Matrix4.rotateZ(radians(obj.rotation.z)) )
    .multiply( Matrix4.rotateX(radians(obj.rotation.x)) )
    .multiply( Matrix4.rotateY(radians(obj.rotation.y)) );
    Matrix4 m = Matrix4.IDENTITY;
    m = scale.multiply(m);
    m = rotate.multiply(m);
    m = translate.multiply(m);
    return m;
  }
  public String MatrixToString(float[] m) {
    String s="";
    for (int i=0; i < m.length; i++) {
      s+=m[i]+" ";
    }
    return s;
  }
}

class ThreadRender extends Thread {
  String name;
  easySunflowAPI api;
  ThreadRender (easySunflowAPI api, String s) {
    name=s;
    this.api=api;
  }
  void start () {
    guiConsole("starting thread rendering");
    ESF.setRenderProgress(true);
    super.start();
  }
  void run () {
    noLoop();
    api.sunflow.options(SunflowAPI.DEFAULT_OPTIONS);
    api.sunflow.render(SunflowAPI.DEFAULT_OPTIONS, api.display.imagePanel);
    if (name!="") api.SaveImage(name);
    guiConsole("ending thread rendering");
    ESF.setRenderProgress(false);
    loop();
  }
  void quit() {
    guiConsole("ending thread rendering");
    interrupt();
  }
}
class RenderWindow extends JFrame {
  public ImagePanel imagePanel;
  RenderWindow(int w, int h) {
    super("rendering frame..."+w+"x"+h);
    setDefaultCloseOperation(1);
    addKeyListener(new KeyAdapter() {
      public void keyPressed(KeyEvent e) {
        if (e.getKeyCode() == 27)
          //System.exit(0);
        UI.taskCancel();
        guiConsole("abort thread rendering");
      }
    }
    );
    setPreferredSize(new Dimension(w, h));
    this.imagePanel = new ImagePanel();
    setContentPane(this.imagePanel);
    pack();
    setLocationRelativeTo(null);
    setVisible(true);
    setAlwaysOnTop(true);
  }
  void setDimension(int w, int h) {
    this.setTitle("rendering frame..."+w+"x"+h);
    setPreferredSize(new Dimension(w, h));
    pack();
    //setLocationRelativeTo(null);
    this.imagePanel.reset();
    setVisible(true);
  }
}

//------------------------------------------------------------------------------
// 	SunflowColor class
//------------------------------------------------------------------------------
class SunflowColor {
  float r=0;
  float g=0;
  float b=0;
  public SunflowColor(float r, float g, float b) {
    this.r=r;
    this.g=g;
    this.b=b;
  }
  public SunflowColor(color c) {
    this.r=(c >> 16 & 0xFF)/ 255f;
    this.g=(c >> 8 & 0xFF)/ 255f;
    this.b=(c & 0xFF)/ 255f;
  }
  color toColor() {
    return color(this.r*255, this.g*255, this.b*255);
  }
}

//------------------------------------------------------------------------------
// 	SunflowLight class
//------------------------------------------------------------------------------
class SunflowLight {
  PVector position;
  SunflowColor _color=new SunflowColor(1, 1, 1);
  String name;
  float size=10;
  boolean visible;
  boolean extra;
  int samples=32;
  float power=1;

  //constructor
  SunflowLight(String name) {
    this.name=name;
    this.visible=true;
  };
  SunflowLight(String name, PVector pos) {
    this.name=name;
    this.position=pos;
    this.visible=true;
  };

  void draw( ) {
  }
  //  getter/setter
  //----------------------------------------------------------------
  public void setVisible(boolean v) {
    this.visible=v;
  }
  public boolean isVisible( ) {
    return this.visible;
  }
  public PVector getPosition() {
    return position;
  }
  public void setPosition(PVector pos) {
    position=pos;
  }
  public void setName(String name) {
    this.name=name;
  }
  public String getName() {
    return this.name;
  }
  public void setSize(float s) {
    this.size=s;
  }
  public float getSize() {
    return this.size;
  }
  public SunflowColor getSunflowColor() {
    return _color;
  }
  public color getColor() {
    return color(_color.r*255, _color.g*255, _color.b*255);
  }
  public void setSunflowColor(SunflowColor col) {
    _color=col;
  }
  public void setSunflowColor(float r, float g, float b) {
    _color=new SunflowColor(r, g, b);
  }
  public void setPower(float power) {
    this.power=power;
  }
  public float getPower() {
    return power;
  }
  public void setColor(color col) {
    _color=new SunflowColor(col);
  }
  public void writeName(String name, PVector pos) {

    fill(160);
    textMode(SHAPE);
    textSize(3);
    text(name, pos.x, pos.y, pos.z);
  }
  
  
  void toSCA(easySunflowAPI api) {
  }
}
class SunLight extends SunflowLight {
  float distance, sunlatitude, sunLongitude, turbidity;
  boolean extendsky;
  color skyline = color(204, 102, 0);
  color zenit = color(255, 255, 20);

  SunLight() {
    super("sun");

    this.setSize(30);
    this.setColor(color(255, 100, 0));
    this.visible=true;
    this.distance=1500;
    this.extendsky=false;
    setTurbidity(3.0);
    setSamples(32);
    setLongitude(0);
    setLatitude(20);
  }


  void setLatitude(float angle) {
    sunlatitude=radians(angle);//[0 PI]
    Move();
  }
  void setLongitude(float angle) {
    sunLongitude=radians(angle);//[0 TWO_PI]
    Move();
  }
  void setTurbidity(float n) {
    this.turbidity=n;
  }
  void setSamples(int s) {
    this.samples=s;
  }
  void setDistance(float d) {
    this.distance=d;
    Move();
  }
  void Move() {
    PVector p=PolarToCartesian(distance, sunLongitude, sunlatitude );
    position=new PVector(p.x, p.y, p.z);
  }
  void setExtendsky(boolean v) {
    this.extendsky=v;
  }
  void setSize(float s) {
    this.size=s;
  }
  float getSize() {
    return this.size;
  }
  void draw() {
    if (!visible) return;
    noLights();
    noStroke();
    noFill();

    // billboard
    PVector viewDir = thecamera.viewDirection();
    float angleZ  = atan2( viewDir.y, viewDir.x );
    float hyp  = sqrt( sq( viewDir.x ) + sq( viewDir.y ) );
    float angleY  = atan2( hyp, viewDir.z );

    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateZ((angleZ));
    rotateY((angleY));
    color daycolor= lerpColor(skyline, zenit, abs(sin(sunlatitude)));
    for (int i=1;i<5;i++) {
      float r=i*i*5;
      stroke(daycolor, 100-r);
      ellipse(0, 0, 40+r, 40+r);
    }

    fill(daycolor);	
    ellipse(0, 0, 40, 40);
    popMatrix();

    // ray
    // stroke(250,192,80, 50);
    for (int i=-2;i<2;i++) {
      line(0, -i-2, 0, position.x, -position.y-i*10, position.z);
    }

    // sun illumination
    directionalLight(250, 255, 200, -position.x, position.y, -position.z);
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter( "up", new Vector3( 0, 1, 0 ));
    api.sunflow.parameter( "east", new Vector3( 1, 0, 0 ) );
    api.sunflow.parameter( "sundir", new Vector3( position.x, position.y, position.z ) );
    api.sunflow.parameter( "turbidity", turbidity );
    api.sunflow.parameter( "samples", samples );
    api.sunflow.parameter( "ground.extendsky", extendsky);
    api.sunflow.light( name, "sunsky");
  }
}
class IBLight extends SunflowLight {
  String texture="";
  IBLight(String path ) {
    super("ibl");
    this.visible=false;
    texture=path;
  }
  void draw() {
    if (!visible) return;
    pushMatrix();
    stroke(100);
    noFill();
    rotateX(radians(90));
    ellipse(0, 0, 500, 500);
    popMatrix();
  };
  public void setVisible(boolean v) {
    this.visible=v;
  }
  public void setPath(String path) {
    texture=path;
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter("center", new Vector3(0, 0, 1));
    api.sunflow.parameter("up", new Vector3(0, 1, 0));
    api.sunflow.parameter("samples", 100);
    api.sunflow.parameter("lowsamples", 32);
    api.sunflow.parameter("lock", true);
    api.sunflow.parameter("texture", texture);
    api.sunflow.light( name, "ibl" );
  }
}
class SpericalLight extends SunflowLight {
  SpericalLight(String name, PVector pos) {
    super(name, pos);
    this.power=10;
    this.setSize(30);
  }
  void draw() {
    if (!visible) return;
    noFill();

    color c =getColor();
    stroke(c);
    pushMatrix();
    translate(position.x, -position.y, position.z);
    scale(size);
    line(-.9, 0, 0, .9, 0, 0);
    line(0, -.9, 0, 0, .9, 0);
    stroke(c, 20);
    ellipse(0, 0, 1, 1);
    rotateX(radians(90) );
    ellipse(0, 0, 1, 1);
    popMatrix();
    writeName(getName(), new PVector(position.x+5, -position.y-5, position.z));
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter("radiance", 	api.COLORSPACE_SRGB_LINEAR, _color.r*power, _color.g*power, _color.b*power);
    api.sunflow.parameter("center", 	toPoint3(position));
    api.sunflow.parameter("radius", 	size);
    api.sunflow.parameter("samples", 	samples);
    api.sunflow.light( name, "sphere" );
  }
}
class PointLight extends SunflowLight {
  PointLight(String name, PVector pos) {
    super(name, pos);
    this.setSize(10);
    setPower(100);
  }

  public void setPower(float power) {
    this.power=power*10000;
  }
  void draw() {
    if (!visible) return;
    noFill();

    color c =getColor();
    pushMatrix();
    translate(position.x, -position.y, position.z);
    scale (size);
    stroke(c, 50);
    ellipse(0, 0, 1, 1);
    stroke(c);
    line(-1, 0, 1, 0);
    line(0, -1, 0, 1);
    line(0, 0, -1, 0, 0, 1);
    popMatrix();
    writeName(getName(), new PVector(position.x+5, -position.y-5, position.z));
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter("center", toPoint3(position));
    api.sunflow.parameter("power", api.COLORSPACE_SRGB_LINEAR, _color.r*power, _color.g*power, _color.b*power);
    api.sunflow.light( name, "point" );
  }
}
class Spotlight extends SunflowLight {
  PVector target;
  Spotlight(String name, PVector position, PVector target ) {
    super(name, position);
    this.setSize(30);
    setPower(100);
    this.target=target;
  }

  PVector getTarget() {
    return target;
  }
  void setRadius(float s) {
    setSize(s);
  }

  void draw() {
    if (!visible) return;

    color c =getColor();
    fill(c);
    noStroke();
    pushMatrix();
    translate(position.x, -position.y, position.z);
    sphere(1);
    popMatrix();
    pushMatrix();
    translate(target.x, 0, target.z);
    rotateX(radians(90));
    ellipse(0, 0, size, size);
    popMatrix();
    stroke(c, 60);
    line(position.x, -position.y, position.z, target.x, -target.y, target.z);
    writeName(getName(), new PVector((position.x+target.x)/2, (-position.y+target.y)/2, (position.z+target.z)/2));
  };
  void toSCA(easySunflowAPI api) {
    if (!visible) return;

    PVector dir=target.sub(target, position);
    dir.normalize();

    api.sunflow.parameter("source", toPoint3(position));
    api.sunflow.parameter("dir", toVector3(dir));
    api.sunflow.parameter("radius", size/2);
    api.sunflow.parameter("radiance",  api.COLORSPACE_SRGB_LINEAR, _color.r*power, _color.g*power, _color.b*power);
    api.sunflow.light( name, "directional" );
  }
}
class MeshLight extends SunflowLight {
  Matrix4 m;
  float[] points;
  float w, h;
  PVector center, target;


  MeshLight(String name, PVector center, PVector target, float w, float h ) {
    super(name);
    this.w=w;
    this.h=h;
    this.center=center;
    this.target=target;
    setPower(20);
    Init();
  }

  void 	Init() {
    float d=this.getSize();
    Matrix4 lookat = Matrix4.IDENTITY.multiply(Matrix4.lookAt(toPoint3(center), toPoint3(target), new Vector3(0, 1, 0)));
    m = Matrix4.IDENTITY;
    m = lookat.multiply(m);
    float[] pm= {
      -this.w, this.h, 0, this.w, this.h, 0, this.w, -this.h, 0, -this.w, -this.h, 0
    };
    for (int i =0;i<pm.length;i+=3) {
      Point3 p=new Point3(pm[i], pm[i+1], pm[i+2]);
      p=lookat.transformP(p);
      pm[i]=p.x;
      pm[i+1]=p.y;
      pm[i+2]=p.z;
    }
    this.points=pm;
  }

  void 	setCenter(PVector c) {
    center=c;
    target=new PVector(0, 0, 0);
    Init();
  }
  void 	setTarget(PVector t) {
    target=t;
    Init();
  }
  void 	setSize(float w, float h) {
    this.w=w;
    this.h=h;
    Init();
  }
  float 	getDistance() {
    return PVector.dist(target, center);
  }
  PVector	getDir() {
    PVector dir=target.sub(target, center);
    dir.normalize();
    return dir;
  }


  void 	draw() {
    if (!visible) return;

    color c =getColor();
    stroke(c, 80);
    noFill();

    beginShape(QUADS);
    for (int i =0;i<points.length;i+=3) {
      vertex(points[i], -points[i+1], points[i+2]);
    }
    endShape();

    stroke(c, 60);
    line(center.x, -center.y, center.z, target.x, target.y, target.z);
    writeName(getName(), new PVector((center.x+target.x)/2, (-center.y+target.y)/2, (center.z+target.z)/2));

    PVector dir= getDir();
    float power=getPower()/100.0;
    directionalLight(toR(c)*power, toG(c)*power, toB(c)*power, dir.x, -dir.y, dir.z);
  }
  void 	toSCA(easySunflowAPI api) {
    if (!visible) return;

    int[] triangles= {0, 1, 2, 0, 2, 3};
    api.sunflow.parameter("radiance",  api.COLORSPACE_SRGB_LINEAR, _color.r*power, _color.g*power, _color.b*power);
    api.sunflow.parameter("points", "point", "vertex", points);
    api.sunflow.parameter("triangles", triangles);
    api.sunflow.parameter("samples", samples);
    api.sunflow.light(this.name, "triangle_mesh");
  }
}


//------------------------------------------------------------------------------
// 	SunflowShader class
//------------------------------------------------------------------------------
class SunflowShader {
  String name, texture;
  SunflowColor col;
  int samples;
  public SunflowShader(String name, SunflowColor col) {
    this.name=name;
    this.col=col;
    this.samples=64;
    texture="";
  }
  public SunflowShader(String name) {
    this.name=name;
    this.col=new SunflowColor(1, 1, 1);
    this.samples=32;
    texture="";
  }
  //
  public void setName(String name) {
    this.name=name;
  }
  public String getName() {
    return this.name;
  }
  public String getType() {
    return this.getClass().getName();
  }
  void setColor(SunflowColor c) {
    this.col=c;
  }
  void setColor(color c) {
    this.col=new SunflowColor(c);
  }
  color getColor() {
    return this.col.toColor();
  }
  void setTexture(String path) {
    texture=path;
  }
  public void toSCA(easySunflowAPI api) {
  }
}
class ShaderMap extends SunflowShader {
	String map;
  	/*
  	quick_gray
  	simple
  	show_normals
  	show_instance_id
  	show_primitive_id
  	view_caustics
  	view_global
  	view_irradiance
  	*/
  
  public ShaderMap(String name, String _map) {
    super(name);
    this.map=_map;
  }
   
  public void toSCA(easySunflowAPI api) {
    api.sunflow.shader(name, map);
  }
}

class ShaderDiffuse extends SunflowShader {
  public ShaderDiffuse(String name, SunflowColor col) {
    super(name, col);
    this.texture="";
  }
  public ShaderDiffuse(String name, SunflowColor col, String texture) {
    super(name, col);
    this.texture=texture;
  }
  public void toSCA(easySunflowAPI api) {
    if (texture=="") {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.shader(name, "diffuse");
    }
    else {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("texture", texture);
      api.sunflow.shader(name, "textured_diffuse");
    }
  }
}
class ShaderConstant extends SunflowShader {
  public ShaderConstant(String name, SunflowColor col) {
    super(name, col);
  }
  public void toSCA(easySunflowAPI api) {
    api.sunflow.parameter("color", api.colorSpace, col.r, col.g, col.b);
    api.sunflow.shader(name, "constant");
  }
}
class ShaderShine extends SunflowShader {
  float shiny;
  public ShaderShine(String name, SunflowColor col, float shiny) {
    super(name, col);
    this.shiny=shiny;
  }
  public ShaderShine(String name, SunflowColor col, float shiny, String texture) {
    super(name);
    this.shiny=shiny;
    this.texture=texture;
  }
  public void setShiny(float shiny) {
    this.shiny=shiny;
  }
  public void toSCA(easySunflowAPI api) {
    if (texture=="") {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("shiny", shiny);
      api.sunflow.shader(name, "shiny_diffuse");
    } 
    else {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("shiny", shiny);
      api.sunflow.parameter("texture", texture);
      api.sunflow.shader(name, "textured_shiny_diffuse");
    }
  }
}
class ShaderPhong extends SunflowShader {
  public SunflowColor specular;
  float power;
  String texture;
  public ShaderPhong(String name, SunflowColor col, SunflowColor specular, float power, int samples) {
    super(name, col);
    this.samples=samples;
    this.specular=specular;
    this.power=power;
    this.texture="";
  }
  public ShaderPhong(String name, SunflowColor col, SunflowColor specular, float power, int samples, String texture) {
    super(name, col);
    this.samples=samples;
    this.specular=specular;
    this.power=power;
    this.texture=texture;
  }
  public void toSCA(easySunflowAPI api) {
    if (texture=="") {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("specular", api.colorSpace, specular.r, specular.g, specular.b);
      api.sunflow.parameter("power", power);
      api.sunflow.parameter("samples", samples);
      api.sunflow.shader(name, "phong");
    } 
    else {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("specular", api.colorSpace, specular.r, specular.g, specular.b);
      api.sunflow.parameter("power", power);
      api.sunflow.parameter("samples", samples);
      api.sunflow.parameter("texture", texture);
      api.sunflow.shader(name, "textured_phong");
    }
  }
}
class ShaderWard extends SunflowShader {
  float xblur, yblur;
  public SunflowColor specular;
  String texture;
  public ShaderWard(String name, SunflowColor col, SunflowColor spec, float xblur, float yblur, int samples) {
    super(name, col);
    this.xblur=xblur;
    this.yblur=yblur;
    this.specular=spec;
    texture="";
  }
  public ShaderWard(String name, SunflowColor col, SunflowColor spec, float xblur, float yblur, int samples, String texture) {
    super(name, col);
    this.xblur=xblur;
    this.yblur=yblur;
    this.specular=spec;
    this.texture=texture;
  }
  public void toSCA(easySunflowAPI api) {
    if (texture=="") {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("specular", api.colorSpace, specular.r, specular.g, specular.b);
      api.sunflow.parameter("roughnessX", xblur);
      api.sunflow.parameter("roughnessY", yblur);
      api.sunflow.parameter("samples", (int)samples);
      api.sunflow.shader(name, "ward");
    } 
    else {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("specular", api.colorSpace, specular.r, specular.g, specular.b);
      api.sunflow.parameter("roughnessX", xblur);
      api.sunflow.parameter("roughnessY", yblur);
      api.sunflow.parameter("samples", (int)samples);
      api.sunflow.parameter("texture", texture);
      api.sunflow.shader(name, "textured_ward");
    }
  }
}
class ShaderAO  extends SunflowShader {
  public float distance=6;
  SunflowColor dark;
  public ShaderAO(String name, SunflowColor col, int samples, float distance) {
    super(name, col);
    this.samples=samples;
    this.distance=distance;
    dark=new SunflowColor(0, 0, 0);
    texture="";
  }
  public ShaderAO(String name, SunflowColor col, int samples, float distance, String texture) {
    super(name, col);
    this.samples=samples;
    this.distance=distance;
    dark=new SunflowColor(0, 0, 0);
    this.texture=texture;
  }
  public ShaderAO(String name, SunflowColor col, SunflowColor dark, int samples, float distance) {
    super(name, col);
    this.samples=samples;
    this.distance=distance;
    this.dark=dark;
    texture="";
  }
  public void setSamples(int s) {
    samples=s;
  }
  public void setDistance(int d) {
    distance=d;
  }
  public void toSCA(easySunflowAPI api) {
    if (texture=="") {
      api.sunflow.parameter("bright", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("dark", api.colorSpace, dark.r, dark.g, dark.b);
      api.sunflow.parameter("samples", (int)samples);
      api.sunflow.parameter("maxdist", distance);
      api.sunflow.shader(name, "ambient_occlusion");
    } 
    else {
      api.sunflow.parameter("bright", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("dark", api.colorSpace, dark.r, dark.g, dark.b);
      api.sunflow.parameter("samples", (int)samples);
      api.sunflow.parameter("maxdist", distance);
      api.sunflow.parameter("texture", texture);
      api.sunflow.shader(name, "textured_ambient_occlusion");
    }
  }
}
class ShaderGlass extends SunflowShader {
  float ior, absorptionDistance;
  public SunflowColor absorbtion;
  public ShaderGlass(String name, SunflowColor col, float ior) {
    super(name, col);
    this.ior=ior;
    this.absorbtion=null;
    this.absorptionDistance=0;
  }
  public ShaderGlass(String name, SunflowColor col, float ior, SunflowColor absorbtioncolor, float distance) {
    super(name, col);
    this.ior=ior;
    this.absorbtion=absorbtioncolor;
    this.absorptionDistance=distance;
  }
  public void toSCA(easySunflowAPI api) {
    api.sunflow.parameter("color", api.colorSpace, col.r, col.g, col.b);
    api.sunflow.parameter("eta", ior);
    if (absorbtion!=null) {
      api.sunflow.parameter("absorption.distance", absorptionDistance);
      api.sunflow.parameter("absorption.color", api.colorSpace, absorbtion.r, absorbtion.g, absorbtion.b);
    }
    api.sunflow.shader(name, "glass");
  }
}
class ShaderUber extends SunflowShader {
  public SunflowColor specular;
  float glossy, blend;
  String texture;
  public ShaderUber(String name, SunflowColor col, SunflowColor specular, float glossy) {
    super(name, col);
    this.blend=blend;
    this.glossy=glossy;
  }
  public ShaderUber(String name, SunflowColor col, SunflowColor specular, float glossy, String texture, float blend) {
    super(name, col);
    this.texture=texture;
    this.blend=blend;
    this.glossy=glossy;
  }
  public void toSCA(easySunflowAPI api) {
    if (texture=="") {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("specular", api.colorSpace, specular.r, specular.g, specular.b);
      api.sunflow.parameter("glossyness", glossy);
      api.sunflow.parameter("samples", samples);
    } 
    else {
      api.sunflow.parameter("diffuse", api.colorSpace, col.r, col.g, col.b);
      api.sunflow.parameter("specular", api.colorSpace, specular.r, specular.g, specular.b);
      //api.sunflow.parameter("diffuse.texture", texture);
      //api.sunflow.parameter("diffuse.blend", blend);
      api.sunflow.parameter("glossyness", glossy);
      api.sunflow.parameter("samples", samples);
    }
    api.sunflow.shader(name, "uber");
  }
}
class ShaderMirror extends SunflowShader {
  public ShaderMirror(String name, SunflowColor col) {
    super(name, col);
  }
  public void toSCA(easySunflowAPI api) {
    api.sunflow.parameter("color", api.colorSpace, col.r, col.g, col.b);
    api.sunflow.shader(name, "mirror");
  }
}

public static class WireAOShader extends WireframeShader {
    // set to false to overlay wires on regular shaders
    private boolean ambocc = true; 
    private boolean metalwireflag = false; 
    
    int samples;
    float maxDist;
    Color lineColor,fillColor;
    MirrorShader metalwire;
    
    
    public WireAOShader() {
        lineColor = Color.BLACK;
        fillColor = Color.WHITE;
        samples=16;
    	maxDist=60f;
    	metalwire =new MirrorShader();
    }
	 
	public boolean update(ParameterList pl, SunflowAPI api) {
        
        super.update(pl,api); 
        fillColor = pl.getColor("fill", fillColor);
        samples = pl.getInt("samples", samples);
        maxDist = pl.getFloat("maxdist", maxDist);
        if (maxDist <= 0) maxDist = Float.POSITIVE_INFINITY;
        return true;
    }
	
    public Color getFillColor(ShadingState state) {
    	return ambocc ? state.occlusion(samples, maxDist,fillColor,Color.BLACK) : state.getShader().getRadiance(state);
   	}
   
    public Color getLineColor(ShadingState state) {
       return metalwireflag ? metalwire.getRadiance(state) : lineColor;
    }
}
class ShaderWireframeAO extends SunflowShader {
	public SunflowColor lineColor,fillcol;
	float linewidth,distance;
 	boolean ambocc = true;
 	int samples;
 	
 	public ShaderWireframeAO(String _name, SunflowColor _fillcol, SunflowColor _linecolor, float _linewidth) {
    super(_name, _fillcol);
    fillcol=_fillcol;
    lineColor=_linecolor;
    linewidth=_linewidth;
  	}	
  	public ShaderWireframeAO(String _name, SunflowColor _fillcol, SunflowColor _linecolor, float _linewidth,int _samples,float _distance) {
    	super(_name, _fillcol);
    	lineColor=_linecolor;
    	fillcol=_fillcol;
    	linewidth=_linewidth;
    	samples=_samples;
    	distance=_distance;
  	}
  
  	public void toSCA(easySunflowAPI api) {
  		api.sunflow.parameter("line", api.COLORSPACE_SRGB_LINEAR, lineColor.r, lineColor.g, lineColor.b);
    	api.sunflow.parameter("fill", api.COLORSPACE_SRGB_LINEAR, fillcol.r, fillcol.g, fillcol.b);
    	api.sunflow.parameter("width", linewidth/1000f);
    	api.sunflow.parameter("samples", samples);
    	api.sunflow.parameter("maxdist", distance);
    	api.sunflow.shader(name, "wireframeao");
  	}
}
class ShaderWireframe extends SunflowShader {
	public SunflowColor lineColor;
	float linewidth;
 	boolean ambocc = true; 
 	
 	public ShaderWireframe(String name, SunflowColor fillcol, SunflowColor linecolor, float linewidth) {
    super(name, fillcol);
    this.lineColor=linecolor;
    this.linewidth=linewidth;
  	}
  
  	public void toSCA(easySunflowAPI api) {
  	api.sunflow.parameter("line", api.COLORSPACE_SRGB_LINEAR, lineColor.r, lineColor.g, lineColor.b);
    api.sunflow.parameter("fill", api.COLORSPACE_SRGB_LINEAR, col.r, col.g, col.b);
    api.sunflow.parameter("width", linewidth/1000f);
    api.sunflow.shader(name, "wireframe");
  	}
  
  
}


//------------------------------------------------------------------------------
// SunflowModifier class
//------------------------------------------------------------------------------
class SunflowModifier {
  public String name;
  public SunflowModifier(String name) {
    this.name=name;
  }
  public void setName(String name) {
    this.name=name;
  }
  public String getName() {
    return this.name;
  }
  public void toSCA(easySunflowAPI api) {
  }
}
class BumpMapModifier  extends SunflowModifier {
  public String texture;
  public float scale, size;
  public BumpMapModifier(String name, String texture, float scale ) {
    super(name);
    this.texture=texture;
    this.scale=scale;
    this.size=size;
  }
  public void setName(String name) {
    this.name=name;
  }
  public String getName() {
    return this.name;
  }
  void toSCA(easySunflowAPI api) {
    api.sunflow.parameter("texture", texture);
    api.sunflow.parameter( "scale", scale);
    api.sunflow.modifier(name, "bump_map");
  }
}
class NormalMapModifier extends SunflowModifier {
  public String texture;
  public NormalMapModifier(String name, String texture) {
    super(name);
    this.texture=texture;
  }
  public void setName(String name) {
    this.name=name;
  }
  public String getName() {
    return this.name;
  }
  void toSCA(easySunflowAPI api) {
    api.sunflow.parameter("texture", texture);
    api.sunflow.modifier(name, "normal_map");
  }
}
class PerlinNoiseModifier extends SunflowModifier {
  public float function=0;
  public float size=1;
  public float scale=.5;
  public PerlinNoiseModifier(String name, float function, float size, float scale) {
    super(name);
    this.function=function;
    this.size=size;
    this.scale=scale;
  }
  public void setName(String name) {
    this.name=name;
  }
  public String getName() {
    return this.name;
  }
  void toSCA(easySunflowAPI api) {
    api.sunflow.parameter("function", (int)function);
    api.sunflow.parameter("size", size);
    api.sunflow.parameter( "scale", scale);
    api.sunflow.modifier(name, "perlin");
  }
}


//------------------------------------------------------------------------------
// 	Geometry class
//-------------------------------------------------------------------------
class Geometry {
  PVector position;
  PVector rotation;
  PVector size;
  String name;
  SunflowShader shader;
  SunflowColor shadercolor;
  ArrayList modifiers;
  String type;
  String path;
  boolean visible;
  boolean nodecimate;
  //constructor
  Geometry(PVector pos) {
    init();
    position=pos;
  }
  Geometry() {
    init();
  }
  void init() {
    position=new PVector(0, 0, 0);
    rotation=new PVector(0, 0, 0);
    size=new PVector(1, 1, 1);
    shadercolor=new SunflowColor(1, 1, 1);
    shader=ESF.defaultshader;
    modifiers=new ArrayList();
    type="";
    visible=true;
    nodecimate=false;
  }
  //----------------------------------------------------------------
  //  getter/setter
  //----------------------------------------------------------------
void setVisible(boolean v) {
visible=v;
}
public boolean isVisible() {
return visible;
}
PVector getPosition() {
return position;
}
PVector getRotation() {
return rotation;
}
PVector getSize() {
return size;
}
void setSize(float s) {
size=new PVector(s, s, s);
}
void setSize(float sx, float sy, float sz) {
size=new PVector(sx, sy, sz);
}
void setSize(PVector s) {
size=s;
}
void setPosition(PVector p) {
position=p;
}
void setPosition(float x, float y, float z) {
position=new PVector(x, y, z);
}
void setX(float x) {
position.x=x;
}
void setY(float y) {
position.y=y;
}
void setZ(float z) {
position.z=z;
}
void setRotation(PVector r) {
rotation=r;
}
void setRotation(float rx, float ry, float rz) {
rotation=new PVector(rx, ry, rz);
}
void addModifier(String m) {
modifiers.add(m);
}
void setName(String s) {
name=s;
}
String getName() {
return name;
}
public void setShader(SunflowShader shader) {
if (shader==null) return;
this.shader=shader;
shadercolor=shader.col;
}
public SunflowShader getShader( ) {
return shader;
}
public void writeName(PVector pos) {

fill(160);
textMode(SHAPE);
textSize(8);
text(name, pos.x, pos.y, pos.z);
}
public void setShaderColor(SunflowColor c) {
shadercolor=c;
shader.col=c;
}
public void setShaderColor(color c) {
shadercolor=new SunflowColor(c);
shader.col=shadercolor;
}
public void setShaderName(String name) {
shader.name=name;
}
color getColor() {
return shader.getColor();
}


	void setDrawMode(){
	
	
	}



  void toSCA(easySunflowAPI api) {
  }
  void update() {
  }
  void draw( ) {
    if (!visible) return;
	
	 
    if (!shadingflag) {
      noFill();
      stroke(shader.col.toColor());
    }
    else {
      noStroke();
      fill(shader.col.toColor());
    }
    
    
    
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    rotateZ(radians(rotation.z));
    scale (size.x, size.y, size.z);
    this.update();
    popMatrix();
     
   
  }
  
  ArrayList CreateMesh(PVector[][] grid){

	int resx=grid[0].length;
	int resy=grid.length;
	
	// vertices
	float[] vertices =new float[resx*resy*3];
	int id=0;
	for (int y =0; y<resy; y++) {
	for (int x =0; x<resx; x++) {
  	 	PVector v= grid[y][x];
  	  	vertices[id++]=v.x;
		vertices[id++]=v.y;
		vertices[id++]=v.z;
		
  	  }
  	}

  	// faces
	ArrayList<Integer> indices = new ArrayList<Integer>();
	for (int i =0; i<resy-1; i++) {
		for (int j =0; j<resx-1; j++) {
  	 	
			int p1 = i*resx + j;
            int p2 = (i+1)*resx + j;
            int p3 = i*resx + j +1;
            int p4 = (i+1)*resx + j + 1;


			indices.add(p1); 
			indices.add(p2); 
			indices.add(p3); 
			
			indices.add(p2); 
			indices.add(p4); 
			indices.add(p3); 
			
		}
	}
  	
  	int[] triangles = new int[indices.size()];
    for (int i=0; i<indices.size(); i++){
        triangles[i]=indices.get(i);
    }
	
	ArrayList out=new ArrayList();
	out.add(vertices);
	out.add(triangles);
	
	return out;

}
}
class Ground  extends Geometry {
  int texturescale;
  Ground() {
    super();
    setSize(10);
    type="ground";
    texturescale=100;
  }
  void draw() {
  	 if (!visible) return;
    float d=300;
    writeName(new PVector(position.x-d, -position.y, position.z+d));
    color c =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(c);
    }
    else {
      noStroke();
      fill(c);
    }
    beginShape(QUAD);
    vertex(-d, 0, -d);
    vertex(d, 0, -d);
    vertex(d, 0, d);
    vertex(-d, 0, d);
    endShape();
  }
  void setTextureScale(int s) {
    texturescale=s;
  }
  void toSCA(easySunflowAPI api) {
  	 if (!visible) return;
    api.sunflow.parameter("center", toPoint3(position));
    api.sunflow.parameter("point1", new Point3(texturescale, 0, 0));
    api.sunflow.parameter("point2", new Point3(0, 0, texturescale));
    api.sunflow.geometry( name, "plane" );
    api.sunflow.parameter( "shaders", shader.name);
    if (modifiers.size()!=0) {
      for (int i=0;i<modifiers.size();i++) {
        api.sunflow.parameter("modifiers", (String)modifiers.get(i));
      }
    }
    api.sunflow.instance( name + ".instance", name );
  }
}
class Cube extends Geometry {
  Cube(PVector pos) {
    super(pos);
    type="box";
  }
  Cube() {
    super();
    type="box";
  }
  void update() {
    box(2);
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name, "Cube_" );
  }
}
class Sphere  extends Geometry {
  boolean particle;
  Sphere(PVector pos) {
    super(pos);
    particle=false;
    type="sphere";
  }
  Sphere( ) {
    particle=false;
    type="sphere";
  }
  void update() {
  	if (!visible) return;
    if (particle) {
      stroke(255);
      strokeWeight(1);
      point(0, 0, 0);
    } 
    else {
      sphere(1);
    }
  }
  void isParticle(boolean p) {
    particle=p;
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter( "shaders", shader.name);
    if (modifiers.size()!=0) {
      for (int i=0;i<modifiers.size();i++) {
        api.sunflow.parameter("modifiers", (String)modifiers.get(i));
      }
    }
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name, "Sphere_" );
  }
}
class Instance  extends Geometry {
  Geometry target;
  String targetname;
  String shadername;
  Instance(PVector pos, Geometry target, String shader) {
    super(pos);
    this.target=target;
    targetname=target.name;
    shadername=shader;
    type="instance";
    setRotation(target.getRotation());
    setSize(target.getSize());
  }
  Instance(PVector pos, String targetname, String shader) {
    super(pos);
    this.target=null;
    this.targetname=targetname;
    shadername=shader;
    type="instance";
    setRotation(0, 0, 0);
    setSize(1);
  }
  void draw() {
  	 if (!visible) return;
    stroke(shadercolor.toColor());
    noFill();
    float d=.5;
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    rotateZ(radians(rotation.z));
    //Axis(5);
    if (target!=null) {
      rotateX(radians(-target.rotation.x));
      rotateY(radians(-target.rotation.y));
      rotateZ(radians(-target.rotation.z));
      scale (max(size.x/target.size.x, .5), max(size.y/target.size.y, .5), max(size.z/target.size.z, .5));
      target.draw();
    } 
    else {
      scale (max(size.x, .5), max(size.y, .5), max(size.z, .5));
      /*
      line(-d, -d, -d, -.4, -d, -d);
      line(-d, d, -d, -.4, d, -d);
      line(d, d, -d, .4, d, -d);
      line(d, -d, -d, .4, -d, -d);
      line(-d, -d, d, -.4, -d, d);
      line(-d, d, d, -.4, d, d);
      line(d, d, d, .4, d, d);
      line(d, -d, d, .4, -d, d);
		*/
      //stroke(shadercolor.toColor());
      //line(0, d, 0, 0, .2, 0);
      stroke(shadercolor.toColor());
      box(1);
    }
    popMatrix();
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter( "shaders", shadername);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name, targetname );
  }
}
class Background extends Geometry {
  boolean visible;
  SunflowColor shadercolor;
  Background( ) {
    super();
    type="background";
    name="internal_background";
    visible=true;
    shadercolor=new SunflowColor(1, 1, 1);
  }
  void setColor(float r, float g, float b) {
    shadercolor=new SunflowColor(r/255, g/255, b/255);
  }
  void toSCA(easySunflowAPI api) {
    if (!this.visible) return;
    
  	if(api.sunflow.lookupGeometry(name) != null) api.sunflow.remove(name);
  
    api.sunflow.parameter("color", null, shadercolor.r, shadercolor.g, shadercolor.b);
    api.sunflow.shader("background.shader", "constant");
    
    api.sunflow.geometry(name, "background");
    api.sunflow.parameter("shaders", "background.shader");
    api.sunflow.instance(name + ".instance", name);
  }
}
class InfinitePlane extends Geometry {
  int orientation;
  int texturescale;
  final static int XZ=1;
  final static int XY=2;
  final static int ZY=3;
  InfinitePlane(PVector pos, int orientation) {
    super(pos);
    setSize(10);
    type="infiniteplane";
    this.orientation=orientation;
    texturescale=100;
  }
  void draw() {
  	 if (!visible) return;
    float d=10;
    stroke(shadercolor.toColor(), 50);
    noFill();
    beginShape(TRIANGLE_FAN);

    // orientation
    // 1 xz, 2 xy, 3 yz
    switch(orientation) {
    case 1:
      vertex(-d, 0, -d);
      vertex(d, 0, -d);
      vertex(d, 0, d);
      vertex(-d, 0, d);
      break;
    case 2:
      vertex(-d, -d, 0);
      vertex(d, -d, 0);
      vertex(d, d, 0);
      vertex(-d, d, 0);
      break;
    case 3:
      vertex(0, -d, -d);
      vertex(0, d, -d);
      vertex(0, d, d);
      vertex(0, -d, d);
      break;
    }
    endShape();
  }
  void setTextureScale(int s) {
    texturescale=s;
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    PVector p2, p3;
    int k=texturescale;
    p2=new PVector(position.x+k, position.y, position.z+k);
    p3=new PVector(position.x-k, position.y, position.z+k);
    switch(orientation) {
    case 1:
      p2=new PVector(position.x+k, position.y, position.z);
      p3=new PVector(position.x, position.y, position.z+k);
      break;
    case 2:
      p2=new PVector(position.x+k, position.y, position.z);
      p3=new PVector(position.x, position.y+k, position.z);
      break;
    case 3:
      p2=new PVector(position.x, position.y, position.z+k);
      p3=new PVector(position.x, position.y+k, position.z);
      break;
    }

    api.sunflow.parameter("center", toPoint3(position));
    api.sunflow.parameter("point1", toPoint3(p2));
    api.sunflow.parameter("point2", toPoint3(p3));
    api.sunflow.geometry( name, "plane" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.instance( name + ".instance", name );
  }
}
class Torus  extends Geometry {
  Torus(PVector pos) {
    super(pos);
    type="torus";
  }
  Torus() {
    super();
    type="torus";
  }
  void draw() {
  	 if (!visible) return;
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateZ(radians(rotation.z));
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    scale (size.x, size.y, size.z);
    int numc=20;
    int numt=20;
    float r1=1;
    float r2=.25;

    int i, j, k;
    float s, t, x, y, z, twopi;
    twopi = 1 * TWO_PI;

    for (i = 0; i < numc; i++) {
      beginShape( PConstants.QUAD_STRIP);
      for (j = 0; j <= numt; j++) {

        for (k = 1; k >= 0; k--) {
          s = (i + k) % numc + 0.5;
          t = j % numt;
          float a1=s*twopi/numc;
          float a2=t*twopi/numt;

          x = (r1+r2*cos(a1))*cos(a2);
          y = (r1+r2*cos(a1))*sin(a2);
          z = r2 * sin(s * twopi / numc);

          vertex(x, y, z);
        }
      }
      endShape();
    }
    popMatrix();
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.geometry( name, "torus" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name + ".instance", name );
  }
}
class Cylinder extends Geometry {

  Cylinder(PVector pos) {
    super(pos);
    type="cylinder";
  }
  Cylinder() {
    super();
    type="cylinder";
  }
  void create(){
  }
  
	void draw() {
	 if (!visible) return;
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateZ(radians(rotation.z));
    rotateX(radians(rotation.x-90));
    rotateY(radians(rotation.y));
    scale (size.x, size.y, size.z);

	 
    float w=1;
    float h=2;
    int sides=12;
    float angle;
    float[] x = new float[sides+1];
    float[] z = new float[sides+1];

    //get the x and z position on a circle for all the sides
    for (int i=0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x[i] = sin(angle) * w;
      z[i] = cos(angle) * w;
    }

    //draw the top of the cylinder
    beginShape(TRIANGLE_FAN);
    vertex(0, -h/2, 0);
    for (int i=0; i < x.length; i++) {
      vertex(x[i], -h/2, z[i]);
    }
    endShape();

    //draw the center of the cylinder
    beginShape(QUAD_STRIP); 
    for (int i=0; i < x.length; i++) {
      vertex(x[i], -h/2, z[i]);
      vertex(x[i], h/2, z[i]);
    }
    endShape();

    //draw the bottom of the cylinder
    beginShape(TRIANGLE_FAN); 
    vertex(0, h/2, 0);
    for (int i=0; i < x.length; i++) {
      vertex(x[i], h/2, z[i]);
    }
    endShape();


    popMatrix();
  }
	void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.geometry( name, "cylinder" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name + ".instance", name );
  }
}
class BezierPatch extends Geometry {
  float[] points;
  int subdivision;
  boolean smooth;
  int nu, nv;
  float [][] patches;
  BezierMesh mesh;
  BezierPatch() {
    super();
    type="bezierpatch";
    subdivision=3;
    smooth=true;
    nu=1;
    nv=1;
    points=null;
    /*
        int id=0;
     int n=50;
     points=new float[n*n*3];
     int c=-(n/2)*10;
     for (int i = 0; i < n; i++) {
     for (int j = 0; j < n; j++) {
     float x=c+10*i;
     float y=sin(id*.1075*30+i)*10+sin(id*.1075*30+j)*10;
     float z=c+10*j;
     points[id]=x;id++;
     points[id]=y;id++;
     points[id]=z;id++;
     }
     }
     setGrid(n,n);
     setSubdivision(10);
     */
  }
  public boolean setPoints(float[] points_, int nu_, int nv_) {
    points=points_;
    boolean uwrap=false;
    boolean vwrap=false;
    nu=nu_;
    nv=nv_;
    /*
        ParameterList pl =new ParameterList();
     pl.addInteger("subdivs",subdivision);
     pl.addBoolean("smooth_normals",smooth);
     pl.addPoints("points", InterpolationType.VERTEX, points);
     PrimitiveList loaded;
     mesh=new BezierMesh();
     if (mesh.update(pl,ESF.sunflow)) {
     loaded=mesh.tesselate();
     println(loaded);
     }
     */
    return true;
  }
  public void setGrid(int nu_, int nv_) {
    nu=nu_;
    nv=nv_;
  }
  public void setSubdivision(int n) {
    subdivision=n;
  }
  public void setSmooth(boolean v) {
    smooth=v;
  }
  void draw() {
    if (!visible) return;
    if (points.length<1 || points==null)return;
    color c =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(c);
    }
    else {
      //stroke(127,20);
      noStroke();
      fill(c);
    }
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateZ(radians(-rotation.z));
    rotateX(radians(-rotation.x));
    rotateY(radians(rotation.y));
    scale (size.x, size.y, size.z);
    for (int i = 0; i < nv-1; i++) {
      for (int j = 0; j < nu-1; j++) {
        int s=3*nu;
        int r= 3*j;
        int id=r+(s*i);
        int id1=id+3;
        int id2=id+s;
        beginShape( PConstants.TRIANGLES);
        vertex(points[id], -points[id+1], points[id+2]);
        vertex(points[id1], -points[id1+1], points[id1+2]);
        vertex(points[id2], -points[id2+1], points[id2+2]);
        endShape();
        beginShape( PConstants.TRIANGLES);
        vertex(points[id2], -points[id2+1], points[id2+2]);
        vertex(points[id2+3], -points[id2+1+3], points[id2+2+3]);
        vertex(points[id1], -points[id1+1], points[id1+2]);
        endShape();
      }
    }
    popMatrix();
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter("subdivs", subdivision);
    api.sunflow.parameter("smooth", smooth);
    api.sunflow.parameter("quads", false);
    api.sunflow.parameter("nu", nu);
    api.sunflow.parameter("nv", nv);
    api.sunflow.parameter("uwrap", false);
    api.sunflow.parameter("vwrap", false);
    api.sunflow.parameter("points", "point", "vertex", points);
    api.sunflow.geometry( name, "bezier_mesh" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name + ".instance", name );
  }
}
class Mesh extends Geometry {
  boolean smooth;
  int[] triangles;
  float[] vertices;
  float[] normals;
  float[] uvs;
 

  Mesh(float[] _vertices, int[] _triangles, float[] _normals) {
    super();
    type="mesh";
    smooth=true;
    triangles =_triangles;
    vertices =_vertices;
    normals= _normals;
  }
  Mesh(float[] _vertices, int[] _triangles, float[] _normals, float[] _uvs) {
    super();
    type="mesh";
    smooth=true;
    triangles =_triangles;
    vertices =_vertices;
    uvs= _uvs;
  }
  Mesh(float[] _vertices, int[] _triangles) {
    super();
    type="mesh";
    smooth=true;
    triangles =_triangles;
    vertices =_vertices;
  }
  Mesh() {
    super();
    type="mesh";
    smooth=true;
  }

	void CreateMeshFromGrid(PVector[][] grid){
	ArrayList meshtmp=CreateMesh(grid);
	setMesh((float[])meshtmp.get(0),(int[])meshtmp.get(1));
}

	void setMesh(float[] _vertices, int[] _triangles) {

    triangles =_triangles;
    vertices =_vertices;
   
} 

  public void computeVertexNormals() {
    if (vertices.length<1) return;


    normals = new float[vertices.length];

    Point3 p0 = new Point3();
    Point3 p1 = new Point3();
    Point3 p2 = new Point3();
    Vector3 n = new Vector3();
    for (int i3 = 0; i3 < triangles.length; i3 += 3) {

      int v0 = triangles[i3 + 0];
      int v1 = triangles[i3 + 1];
      int v2 = triangles[i3 + 2];

      p0.set(vertices[3 * v0 + 0], vertices[3 * v0 + 1], vertices[3 * v0 + 2]);
      p1.set(vertices[3 * v1 + 0], vertices[3 * v1 + 1], vertices[3 * v1 + 2]);
      p2.set(vertices[3 * v2 + 0], vertices[3 * v2 + 1], vertices[3 * v2 + 2]);
      Point3.normal(p0, p1, p2, n); // compute normal

      // add face normal to each vertex
      // note that these are not normalized so this in fact weights
      // each normal by the area of the triangle

      normals[3 * v0 + 0] += n.x;
      normals[3 * v0 + 1] += n.y;
      normals[3 * v0 + 2] += n.z;

      normals[3 * v1 + 0] += n.x;
      normals[3 * v1 + 1] += n.y;
      normals[3 * v1 + 2] += n.z;

      normals[3 * v2 + 0] += n.x;
      normals[3 * v2 + 1] += n.y;
      normals[3 * v2 + 2] += n.z;
    }
    // normalize all the vectors
    for (int i = 0; i < normals.length; i += 3) {
      n.set(normals[i + 0], normals[i + 1], normals[i + 2]);
      n.normalize();
      normals[i + 0] = n.x;
      normals[i + 1] = n.y;
      normals[i + 2] = n.z;
    }
  }
  public void setSmooth(boolean flag) {
    smooth=flag;
  }
  public void draw() {
    if (vertices==null ||triangles==null || !visible) return;

    color co =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(co);
    }
    else
    {
      noStroke();
      fill(co);
    }
    
    
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateZ(radians(rotation.z));
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    scale (size.x, size.y, size.z);
    
    //decimate mesh with scenedetails var
    int count=0;
    int step= (nodecimate)?1:(int)ESF.getSceneDetails(triangles.length);
    
    for (int i3 = 0; i3 < triangles.length; i3 +=3) {
      if ( count%step==0  ) {
         
        int v0 = triangles[i3 ]*3;
        int v1 = triangles[i3 + 1]*3;
        int v2 = triangles[i3 + 2]*3;
        
        beginShape( PConstants.TRIANGLES);
       
       if (smooth && normals!=null) {
          normal(normals[ v0 ], -normals[ v0 + 1], normals[ v0 + 2]);
          vertex(vertices[ v0 ], -vertices[ v0 + 1], vertices[ v0 + 2]);
          normal(normals[ v1 ], -normals[ v1 + 1], normals[ v1 + 2]);
          vertex(vertices[ v1 ], -vertices[ v1 + 1], vertices[ v1 + 2]);
          normal(normals[ v2 ], -normals[ v2 + 1], normals[ v2 + 2]);
          vertex(vertices[ v2 ], -vertices[ v2 + 1], vertices[ v2 + 2]);
        } 
        else {
          vertex(vertices[ v0 ], -vertices[ v0 + 1], vertices[ v0 + 2]);
          vertex(vertices[ v1 ], -vertices[ v1 + 1], vertices[ v1 + 2]);
          vertex(vertices[ v2 ], -vertices[ v2 + 1], vertices[ v2 + 2]);
          vertex(vertices[ v2 ], -vertices[ v2 + 1], vertices[ v2 + 2]);
        }

        endShape();
      }
      count++;
    }
    
    popMatrix();
  }
  public void toSCA(easySunflowAPI api) {
    if (!visible) return;

    api.sunflow.parameter("triangles", triangles);
    api.sunflow.parameter("points", "point", "vertex", vertices);
    api.sunflow.parameter("normals", "vector", "vertex", normals);

    if (uvs!=null) api.sunflow.parameter("uvs", "texcoord", "vertex", uvs);
    api.sunflow.geometry( name, "triangle_mesh" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name + ".instance", name );
  }
}

// 	Hairs
class Hair {
  float[] v;
  float[] s;
  boolean visible=true;
  SunflowShader shader=ESF.defaultshader;

  	Hair() {
  	}
  	Hair(PVector[] list, float[] size) {
    setHair(list, size);
  	}
	Hair(float[] list, float[] size) {
   	this.v=list;
    this.s=size;
  	}
  
  void setHair(PVector[] list, float[] size) {

    v=new float[list.length*3];
    for (int i=0;i<list.length;i++) {
      v[3*i]=list[i].x;
      v[3*i+1]=list[i].y;
      v[3*i+2]=list[i].z;
    }
    this.s=size;
     
  }


  void draw() {
    if (v==null) return;

    beginShape();
    for (int i=0;i<v.length;i+=3) {
      vertex(v[i], -v[i+1], v[i+2]);
    }
    endShape();
  }
}
class Hairs extends Geometry {
  ArrayList<Hair> _hairs;
  Hairs(PVector pos) {
    super(pos);
    type="hair";
    _hairs=new ArrayList<Hair>();
  }

  ArrayList getHairs() {
    return _hairs;
  }
  Hair getHair(int id) {
    return ( Hair)_hairs.get(id);
  }
  void addHair(PVector[] vertex, float[] size) {
    _hairs.add(new Hair(vertex, size));
  }
  void addHair(float[] vertex, float[] size) {
    _hairs.add(new Hair(vertex, size));
  }
  void addHair(Hair hair) {
    _hairs.add(hair);
  }
  void setHair(int id, PVector[] path, float[] size) {
    if (_hairs.get(id)!=null)  _hairs.get(id).setHair(path, size);
  }
	void reset(){
	_hairs.clear();
	}

  void draw() {
    if (!visible) return;
    stroke(shadercolor.toColor());
    noFill();
    float step= ESF.getSceneDetails(_hairs.size());
    for (float i = 0; i < _hairs.size(); i+=step) {
      Hair hair = _hairs.get((int)i);
      hair.draw();
    }
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;

    float[] v, s;
    String hairname=name;
    int segments;
    for (int i = 0; i < _hairs.size(); i++) {
    Hair hair = ( Hair)_hairs.get(i);
    v= hair.v;
    s= hair.s;
     
    segments= (v.length/3)-1;

    hairname=name+".h"+i;
    api.sunflow.parameter("segments", segments);
    api.sunflow.parameter("points", "point", "vertex", v);
    api.sunflow.parameter("widths", "float", "none", s);
    api.sunflow.geometry( hairname, "hair" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.instance( hairname + ".instance", hairname );
    }
  }
}

// 	Particles
class Particle {
  float x, y, z;
  float radius, diam;
  SunflowColor shadercolor;


  Particle(float x, float y, float z, SunflowColor c) {
    this.x = x;
    this.y = y;
    this.z = z;
    radius=.25;
    shadercolor=c;
  }
  Particle() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
    radius=.25;
  }

  void setPosition(float _x, float _y, float _z) {
    x=_x;
    y=_y;
    z=_z;
  }
 	void setPosition(PVector v) {
    x=v.x;
    y=v.y;
    z=v.z;
  }
  PVector getPosition(){
  	return new PVector(x,y,z);
  }
  void setRadius(float r) {
    radius=r;
  }
  void draw(boolean isphere) {

    color c=shadercolor.toColor();
    stroke(c);
    noFill();

    if (isphere) {
      pushMatrix();
      translate(x, -y, z);
      ellipse(0, 0, radius, radius);
      popMatrix();
    } 
    else {
    
      strokeWeight(1);
      point(x, -y, z);
      strokeWeight(1);
      
    }
  }
 
  
  
  
}
class Particles  extends Geometry {
  float radius;
  boolean isphere;
  ArrayList <Particle> _particles;

  Particles(PVector center) {
    super(center);
    initParticles();
  }
  Particles() {
    super();
    initParticles();
  }
  void initParticles() {
    type="particles";
    _particles=new ArrayList<Particle>();
    radius=.25;
    isphere=false;
  }
  Particle addParticle(PVector center) {
    Particle p=new Particle(center.x+position.x, center.y+position.y, center.z+position.z, shader.col);
    _particles.add(p);
    p.setRadius(radius);
    return p;
  }
  void setRadius(float r) {
    radius=r;
    for (int i=0;i<_particles.size();i++) {
      _particles.get(i).setRadius(radius);
    }
    draw();
  }
  int getCount() {
    return _particles.size();
  }
  Particle getParticle(int i) {
    return (Particle)_particles.get(i);
  }
  float getRadius() {
    return radius;
  }
  void showSphere(boolean v) {
    isphere=v;
  }

  void draw( ) {
    if (!visible) return;
    //decimate
    float step= ESF.getSceneDetails(_particles.size());
    Particle p;
    for (float i=0;i<_particles.size();i+=step) {
      p=_particles.get((int)i);
      p.draw(isphere);
    }
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    float[] particles = new float[_particles.size()*3];
    int id=0;
    for (int i=0;i<_particles.size();i++) {
      Particle p=(Particle)_particles.get(i);
      particles[id]=p.x;
      id++;
      particles[id]=p.y;
      id++;
      particles[id]=p.z;
      id++;
    }
    api.sunflow.parameter("particles", "point", "vertex", particles);
    api.sunflow.parameter("num", particles.length/3);
    api.sunflow.parameter("radius", radius);
    api.sunflow.geometry( name, "particles" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.instance( name + ".instance", name );
  }
  void SaveData(String file) {
    String path=sketchPath(file);
    try {
      FileOutputStream fs = new FileOutputStream(path);
      DataOutputStream ds = new DataOutputStream(fs);
      for (Iterator it=_particles.iterator(); it.hasNext();) {
        Particle p = (Particle)it.next();
        ds.writeFloat(p.x);
        ds.writeFloat(p.y);
        ds.writeFloat(p.z);
      }
      ds.flush();
      ds.close();
      guiConsole("particles system saved: "+path);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
  void LoadData(String path) {
    _particles.clear();
    String filename=sketchPath(path);
    try {
      File file = new File(filename);
      FileInputStream stream = new FileInputStream(filename);
      MappedByteBuffer map = stream.getChannel().map(FileChannel.MapMode.READ_ONLY, 0L, file.length());
      FloatBuffer buffer = map.asFloatBuffer();
      for (int i = 0; i < buffer.capacity()/3; i+=3) {
        addParticle(new PVector(buffer.get(i), buffer.get(i+1), buffer.get(i+2)));
      }
      stream.close();
    } 
    catch (FileNotFoundException e) {
      e.printStackTrace();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }
}

// 	Hemesh Models
class HemeshMesh extends Geometry {
  float[] vertices;
  int[] triangles;
  HE_Mesh mesh;
  boolean smooth;
  HemeshMesh(HE_Mesh m) {
    super();
    mesh=m;
    type="hemesh";
    smooth=true;
  }
  HemeshMesh(HE_DynamicMesh m) {
    super();
    mesh=m;
    type="hemesh";
    smooth=true;
  }

  void update() {
    ((HE_DynamicMesh)mesh).update();
  }
  void draw() {
    color c =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(c);
    }
    else {
      //stroke(60);
      noStroke();
      fill(c);
    }
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    rotateZ(radians(rotation.z));
    scale (size.x, size.y, size.z);
    //decimate mesh with scenedetails var
    int count=0;
    Iterator<HE_Face> faceItr = mesh.fItr();
    int step= (int)ESF.getSceneDetails(mesh.numberOfFaces());
    while (faceItr.hasNext ()) {
      HE_Face face = (HE_Face)faceItr.next();
      if (count%step==0) renderHemesh.drawFace(face);
      count++;
    }
    popMatrix();
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    float [] verticesHemeshOneDim;
    int [] facesHemeshOneDim;
    float [] normalsHemeshOneDim;
    mesh.validate(false, true);
    mesh.triangulateFaces();
    float [][] verticesHemesh = mesh.getVerticesAsFloat();
    verticesHemeshOneDim = new float[verticesHemesh.length * 3];
    int [][] facesHemesh = mesh.getFacesAsInt();
    facesHemeshOneDim = new int[facesHemesh.length * 3];
    guiConsole("export hemesh mesh: vertex= "+verticesHemesh.length+" faces= "+facesHemesh.length);
    for (int i=0; i<verticesHemesh.length; i++) {
      verticesHemeshOneDim[3*i] = (float)verticesHemesh[i][0];
      verticesHemeshOneDim[3*i+1] = -(float)verticesHemesh[i][1];
      verticesHemeshOneDim[3*i+2] = (float)verticesHemesh[i][2];
    }
    for (int i=0; i<facesHemesh.length; i++) {
      facesHemeshOneDim[i*3+0] = facesHemesh[i][0];
      facesHemeshOneDim[i*3+1] = facesHemesh[i][1];
      facesHemeshOneDim[i*3+2] = facesHemesh[i][2];
    }
    api.sunflow.parameter("triangles", facesHemeshOneDim);
    api.sunflow.parameter("points", "point", "vertex", verticesHemeshOneDim);
    if (smooth) {
      WB_Normal[] normalHemesh=mesh.getVertexNormals();
      normalsHemeshOneDim = new float[normalHemesh.length * 3];
      for (int i=0; i<normalHemesh.length; i++) {
        normalsHemeshOneDim[3*i] = (float)normalHemesh[i].x;
        normalsHemeshOneDim[3*i+1] = -(float)normalHemesh[i].y;
        normalsHemeshOneDim[3*i+2] = (float)normalHemesh[i].z;
      }
      api.sunflow.parameter("normals", "vector", "vertex", normalsHemeshOneDim);
    }
    api.sunflow.geometry( name, "triangle_mesh" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name + ".instance", name );
  }
  void setSmooth(boolean b) {
    smooth=b;
  }
  void setPosition(float x, float y, float z) {
    position=new PVector(x, y, z);
  }
}
class HemeshInstance extends Geometry {
  String shadername;
  HemeshMesh target;
  boolean onlycenter;

  HemeshInstance(HemeshMesh _target, SunflowShader shader) {
    super();

    target=_target;
    shadername=shader.getName();
    type="hemeshinstance";
    onlycenter=false;
  }

  void draw() {
    int count=0;
    color c =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(c);
    }
    else {
      stroke(60);
      fill(c);
    }
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    rotateZ(radians(rotation.z));
    scale (size.x, size.y, size.z);
    if (!onlycenter) {
      //decimate mesh with scenedetails var
      Iterator<HE_Face> faceItr = target.mesh.fItr();
      int step= (int)ESF.getSceneDetails(10000);
      while (faceItr.hasNext ()) {
        HE_Face face = (HE_Face)faceItr.next();
        if (count%step==0) renderHemesh.drawFace(face);
        count++;
      }
    } 
    else {
       
      beginShape(POINTS);
      count=0;
      stroke(200, 200, 200);
      Iterator vItr = target.mesh.vItr();
      while (vItr.hasNext ()) {
        HE_Vertex v = (HE_Vertex)vItr.next();
        if (count%50==0) {
          pushMatrix();
          vertex((float)v.x, (float)v.y, (float)v.z);
          popMatrix();
        }
        count++;
      }
      endShape();
    }
    Axis(10);
    popMatrix();
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter( "shaders", shadername);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name, target.getName() );
  }
  void notShow() {
    onlycenter=true;
  }
}

// 	ToxiLibs Models
class ToxiMesh extends Geometry {
  	float[] vertices;
  	int[] triangles;
  	WETriangleMesh mesh;
  	boolean smooth;
  	boolean showwireframe;
  	boolean shownormals;
  	boolean flipy;
 
 	ToxiMesh() {
		super();
		type="toximesh";
		smooth=true;
		showwireframe=false;
		shownormals =false;
		flipy=false;
	}
	ToxiMesh(WETriangleMesh m) {
		super();
		type="toximesh";
		mesh=m;
		smooth=false;
		showwireframe=true;
		shownormals =false;
		flipy=false;
		
	}
  
  	void setMesh(toxi.geom.mesh.TriangleMesh m) {
    	mesh=m.toWEMesh() ;
    }
  	void setMesh(WETriangleMesh m) {
    	mesh=m;
  	}
  	void setSmooth(boolean b) {
    smooth=b;
  	}
  	void showNormals(boolean n) {
    shownormals=n;
  	}
  	void showWireFrame(boolean n) {
    	showwireframe=n;
  	}
  	void setPosition(PVector pos){
  		position=pos;
  	
  	}
  	void setRotation0(PVector rot){
  		rotation=rot;
  	
  	}
  	void flipYAxis(boolean b) {
    	flipy=b;
  	}

  	void setRotation(PVector rot){
  		rotation=rot;
  		rotation.mult(new PVector(-1,1,-1));
  	}
  	void setRotation(float rx,float ry,float rz){
  		rotation=new PVector(rx,ry,rz);
  		rotation.mult(new PVector(-1,1,-1));
  	}
  	
  	boolean isFacing(toxi.geom.mesh.Face face,PVector position) {
  
		PVector c = toPVector(face.getCentroid());

		// this works out the vector from the camera to the face.
		PVector positionToFace = new PVector(position.x - c.x, position.y - c.y, position.z - c.z);

		// We now know the vector from the camera to the face,
		// and the vector that describes which direction the face
		// is pointing, so we just need to do a dot-product and
		// based on that we can tell if it's facing the camera or not
		// float result = PVector.dot(cameraToFace, faceNormal);
	
		// center - first vertex
		PVector aToB = PVector.sub(c, toPVector(face.a));
		// center - last vertex
		PVector cToB = PVector.sub(c, toPVector(face.c));
		PVector normal = cToB.cross(aToB);
		normal.normalize();
		normal.mult(-1);
		
		float result = positionToFace.dot(normal);

		// if the result is positive, then it is facing the camera.
		return result > 0;
	}
	
  	void draw() {
  	if (!visible) return;
    
    color co =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(co);
    }
    else {
      if (showwireframe) stroke(127, 30);
      else noStroke();
      fill(co);
    }
    
   
    pushMatrix();
    
		translate(position.x, -position.y, position.z);
		rotateZ(radians(-rotation.z));
		rotateX(radians(-rotation.x));
		rotateY(radians(rotation.y));
		
		
		scale (size.x, size.y, size.z); 
	
		//decimate mesh with scenedetails var
		int count=0;
		int step= (int)ESF.getSceneDetails(10000); 
		 
		beginShape(TRIANGLES);
		for (Iterator i=mesh.faces.iterator(); i.hasNext();)
		{
			toxi.geom.mesh.Face f=(toxi.geom.mesh.Face)i.next();
		
			//if (!isFacing(f,thecamera.position())) continue;
			
			if (count%step==0) {
				if (smooth)
				{
					normal(f.a.normal.x, f.a.normal.y, f.a.normal.z);
					vertex(f.a.x, f.a.y, f.a.z);
					normal(f.b.normal.x, f.b.normal.y, f.b.normal.z);
					vertex(f.b.x, f.b.y, f.b.z);
					normal(f.c.normal.x, f.c.normal.y, f.c.normal.z);
					vertex(f.c.x, f.c.y, f.c.z);
				} 
				else
				{
					vertex(f.a.x, f.a.y, f.a.z);
					vertex(f.b.x, f.b.y, f.b.z);
					vertex(f.c.x, f.c.y, f.c.z);
				}
		  
			}
			count++;
			
		}
		endShape();
	
		// show normals
		if (shownormals) {
		  count=0;
		  for (Iterator i=mesh.faces.iterator(); i.hasNext();) {
			toxi.geom.mesh.Face f=(toxi.geom.mesh.Face)i.next();
			if (count%step==0) {
			  Vec3D c = f.a.add(f.b).addSelf(f.c).scaleSelf(0.333);
			  Vec3D d = c.add(f.normal.scale(5));
			  
			  //Vec3D n = f.normal.scale(10);
			  //n.addSelf(128,128,128);
			  stroke(co,80 );
			  line(c.x, c.y, c.z, d.x, d.y, d.z);
			}
			count++;
		  }
		}
    	Axis(1);
    	
    popMatrix();
  }
  	void toSCA(easySunflowAPI api) {
		if (!visible) return;
		
		guiConsole("add toxilibs mesh: vertex= "+mesh.getNumVertices()+" faces= "+mesh.getNumFaces()+" material= "+shader.name);
		
		WETriangleMesh meshtmp=mesh.copy();
		
		
		//if (flipy) meshtmp.flipYAxis();
		
		
		int[] triangles = meshtmp.getFacesAsArray();
		float[] vertices = new float[meshtmp.getNumVertices() * 3];
		float[] normals = new float[meshtmp.getNumVertices() * 3];
	   
		int id = 0;
		Iterator localIterator = meshtmp.vertices.values().iterator();
		while (localIterator.hasNext()){
			toxi.geom.mesh.Vertex v = (toxi.geom.mesh.Vertex)localIterator.next();
			vertices[id] = v.x;normals[id] = v.normal.x;id++;
			vertices[id] = v.y;normals[id] = v.normal.y;id++;
			vertices[id] = v.z;normals[id] = v.normal.z;id++;
		}
		 
		// to sunflow
		api.sunflow.parameter("triangles", triangles);
		api.sunflow.parameter("points", "point", "vertex", vertices);
		api.sunflow.parameter("normals", "vector", "vertex", normals);
	   
		api.sunflow.geometry( name, "triangle_mesh" );
		api.sunflow.parameter( "shaders", shader.name);
		api.sunflow.parameter( "transform", api.setTransformMatrix(this));
		
		if (modifiers.size()!=0) {
		
		println("--------------------------------");
			for (int i=0;i<modifiers.size();i++) {
        		api.sunflow.parameter("modifiers", (String)modifiers.get(i));

        	}
    	}
		api.sunflow.instance( name + ".instance", name );
		
	 
  	}
}
class ToxiInstance extends Geometry {
  String shadername;
  ToxiMesh target;
  ToxiInstance(ToxiMesh _target, SunflowShader _shader) {
    super();
    target=_target;
    shadername=_shader.name;
    setShader(_shader);
    type="instance";
    setRotation(target.getRotation());
    setSize(target.getSize());
   
  }
  	
  boolean isFacing(toxi.geom.mesh.Face face,PVector position) {
  
		PVector c = toPVector(face.getCentroid());

		// this works out the vector from the camera to the face.
		PVector positionToFace = new PVector(position.x - c.x, position.y - c.y, position.z - c.z);

		// We now know the vector from the camera to the face,
		// and the vector that describes which direction the face
		// is pointing, so we just need to do a dot-product and
		// based on that we can tell if it's facing the camera or not
		// float result = PVector.dot(cameraToFace, faceNormal);
	
		// center - first vertex
		PVector aToB = PVector.sub(c, toPVector(face.a));
		// center - last vertex
		PVector cToB = PVector.sub(c, toPVector(face.c));
		PVector normal = cToB.cross(aToB);
		normal.normalize();
		normal.mult(-1);
		
		float result = positionToFace.dot(normal);

		// if the result is positive, then it is facing the camera.
		return result > 0;
	}
  void draw() {
    color c =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(c);
    }
    else {
      stroke(c, 20);
      fill(c);
    }
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateZ(radians(-rotation.z));
    rotateX(radians(-rotation.x));
    rotateY(radians(rotation.y));
    scale (size.x, size.y, size.z);
    beginShape(TRIANGLES);
    //decimate mesh with scenedetails var
    int count=0;
    int step= (int)ESF.getSceneDetails(10000);
    
    for (Iterator i=target.mesh.faces.iterator(); i.hasNext();)
	{
      	toxi.geom.mesh.Face f=(toxi.geom.mesh.Face)i.next();
	
		if (!isFacing(f,thecamera.position())) continue;
      
      
      	if (count%step==0) {
        normal(f.a.normal.x, f.a.normal.y, f.a.normal.z);
        vertex(f.a.x, f.a.y, f.a.z);
        normal(f.b.normal.x, f.b.normal.y, f.b.normal.z);
        vertex(f.b.x, f.b.y, f.b.z);
        normal(f.c.normal.x, f.c.normal.y, f.c.normal.z);
        vertex(f.c.x, f.c.y, f.c.z);
      }
      	count++;
    }
    endShape();
    Axis(10);
    popMatrix();
  }
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name, target.getName() );
  }
  
}


//------------------------------------------------------------------------------
//	EXTERNAL MODELS
//------------------------------------------------------------------------------
// STL/OBJ/RA3 geometry (via Sunflow)
class FileGeometry extends Geometry {
  String path;
  boolean smooth;
  public MeshFile mesh;
  boolean loaded;
  boolean onlyvertex;
  
  FileGeometry(String path, boolean flag) {
    super();
    type="filemodel";
    this.path=path;
    this.smooth=flag;
    Init();
  }
  FileGeometry(String path) {
    super();
    type="filemodel";
    this.path=path;
    this.smooth=false;
    Init();
  }
  
  void Init() {
    onlyvertex=false;
    loaded=false;
    ParameterList pl =new ParameterList();
    pl.addString("filename", toPath(path));
    pl.addBoolean("smooth_normals", smooth);
    mesh=new MeshFile();
   	if (mesh.update(pl, ESF.sunflow)) loaded=(mesh.tesselate()!=null);
    
  }
  void draw() {
  
    if (!loaded || !visible) return;
    color co =shader.col.toColor();
    if (!shadingflag) {
      noFill();
      stroke(co);
    }
    else
    {
      stroke(co, 30);
      fill(co);
    }
    
    pushMatrix();
    translate(position.x, -position.y, position.z);
    rotateX(radians(-rotation.x));
    rotateY(radians(rotation.y));
    rotateZ(radians(-rotation.z));
    scale (size.x, size.y, size.z);
    
    //decimate mesh with scenedetails var
    int count=0;
    int step= (int)ESF.getSceneDetails(mesh.triangles.length);
    for (int i3 = 0; i3 < mesh.triangles.length; i3 += 3) {
      if ( count%step==0  ) {
         
        int v0 = mesh.triangles[i3 ]*3;
        int v1 = mesh.triangles[i3 + 1]*3;
        int v2 = mesh.triangles[i3 + 2]*3;
        if (onlyvertex) {
          beginShape( PConstants.POINTS);
        }
        else
        {
          beginShape( PConstants.TRIANGLES);
        }
        vertex(mesh.vertices[ v0 ], -mesh.vertices[ v0 + 1], mesh.vertices[ v0 + 2]);
        vertex(mesh.vertices[ v1 ], -mesh.vertices[ v1 + 1], mesh.vertices[ v1 + 2]);
        vertex(mesh.vertices[ v2 ], -mesh.vertices[ v2 + 1], mesh.vertices[ v2 + 2]);
        endShape();
      }
      count++;
    }
    popMatrix();
    
  }
  void swapYZ(){
  	 
  	 	for (int i = 0; i < mesh.vertices.length; i +=3) {
  	 	float tmp=mesh.vertices[i+1];
  	 	mesh.vertices[i+1]=mesh.vertices[i+2];
  	 	mesh.vertices[i+2]=tmp;
  		}
  	}
  
  void flipY(){
  	 	for (int i = 0; i < mesh.vertices.length; i +=3) {
  	 	mesh.vertices[i+1]*=-1;
  		}
  	}
  
  void toSCA(easySunflowAPI api) {
    if (!visible) return;
    
   // 
    api.sunflow.parameter("triangles", mesh.triangles);
    api.sunflow.parameter("points", "point", "vertex", mesh.vertices);
    if (this.smooth) api.sunflow.parameter("normals", "vector", "vertex", mesh.normals);
    api.sunflow.geometry( name, "triangle_mesh" );
    api.sunflow.parameter( "shaders", shader.name);
    api.sunflow.parameter( "transform", api.setTransformMatrix(this));
    api.sunflow.instance( name + ".instance", name );
  }
  void setSmooth(boolean b) {
    smooth=b;
  }
  void showOnlyVertex() {
    onlyvertex=true;
  }
}

// objLoader 
class ObjLoader extends Geometry {
  	String path;
  	boolean loaded;
   
  	float sizemodel;
  	OBJModel model;
  	ObjLoaderPart[] groups;
  	Hashtable<String, saito.objloader.Material> materials;
  	Hashtable<String, SunflowShader> shaders;
  	ArrayList<PVector> meshvertices;
  	boolean smooth=true;
  	boolean shownormals=false;
  	boolean showwireframe=true;
  	
  
  	ObjLoader(String _path,float _size) {
    super();
    type="ObjLoader";
    path=_path;
    sizemodel=_size;
    
    Init();
}
  
  	void Init() {
    
		loaded=false;

  		model = new OBJModel(sketchPApplet,path,"relative",TRIANGLES);
  		model.scale(sizemodel);
  		//model.translateToCenter();
  		
		groups = new ObjLoaderPart[model.getSegmentCount()];
		materials=(Hashtable<String, saito.objloader.Material>)getPrivateField("materials",model);
		shaders = new Hashtable<String, SunflowShader>();
		meshvertices=(ArrayList<PVector>)getPrivateField("vertices",model);
		 
		saito.objloader.Material segmentmaterial;
		
		// create list of shaders
		for( Iterator mat=materials.keySet().iterator(); mat.hasNext(); ) {
			
			String matname 		= (String) mat.next();
			segmentmaterial 	= (saito.objloader.Material) materials.get( matname );
			
			ShaderDiffuse shader =new ShaderDiffuse(matname, new SunflowColor(segmentmaterial.Kd[0], segmentmaterial.Kd[1], segmentmaterial.Kd[2]));
			shaders.put(matname,shader);
			ESF.addShader(shader);
	 
		}
		
		// create mesh
		for (int i = 0; i < model.getSegmentCount(); i++) {
  	
			Segment segment = model.getSegment(i);
		 
			groups[i] = new ObjLoaderPart("group"+i, getMeshFortSegment(segment));
			
			//if (flipy) groups[i].mesh.flipYAxis();
			//m.flipYAxis();
			//m.faceOutwards();
		 	//m.computeVertexNormals();
			
			segmentmaterial= (saito.objloader.Material)materials.get(segment.materialName); 
			if (segmentmaterial!=null) 	groups[i].setShader(shaders.get(segment.materialName));  
			
		}
		loaded=true;
	
		showNormals(false);
		showWireFrame(false);
		setSmooth(false);
		
  	}
  	void draw(){
  		if (!visible) return;

    	pushMatrix();
		translate(position.x, -position.y, position.z);
		rotateZ(radians(-rotation.z));
		rotateX(radians(-rotation.x));
		rotateY(radians(rotation.y));
		
		scale (size.x, size.y, size.z); 
    	
    	ObjLoaderPart part;
		for (int j = 0; j < groups.length; j++) {
			part=groups[j];
			
			
			color co =part.shader.col.toColor();
			if (!shadingflag) 
			{
			  noFill();
			  stroke(co);
			}
			else 
			{
			   if (showwireframe) stroke(127, 30);
			   else noStroke();
			  fill(co);
			}
			

			//decimate mesh with scenedetails var
			int count=0;
			int step= (int)ESF.getSceneDetails(10000); 
			
			beginShape(TRIANGLES);
			for (Iterator i=part.mesh.faces.iterator(); i.hasNext();)
			{
				toxi.geom.mesh.Face f=(toxi.geom.mesh.Face)i.next();
				
				
				
				
				if (count%step==0) {
					if (smooth)
					{
						normal(f.a.normal.x, f.a.normal.y, f.a.normal.z);
						vertex(f.a.x, f.a.y, f.a.z);
						normal(f.b.normal.x, f.b.normal.y, f.b.normal.z);
						vertex(f.b.x, f.b.y, f.b.z);
						normal(f.c.normal.x, f.c.normal.y, f.c.normal.z);
						vertex(f.c.x, f.c.y, f.c.z);
					} 
					else
					{
						normal(f.normal.x, f.normal.y, f.normal.z);
						vertex(f.a.x, f.a.y, f.a.z);
						vertex(f.b.x, f.b.y, f.b.z);
						vertex(f.c.x, f.c.y, f.c.z);
					}
				}
				count++;
			}
			endShape();
		
			// show normals
			if (shownormals) {
			  count=0;
			  for (Iterator i=part.mesh.faces.iterator(); i.hasNext();) {
				toxi.geom.mesh.Face f=(toxi.geom.mesh.Face)i.next();
				if (count%step==0) {
				  Vec3D c = f.a.add(f.b).addSelf(f.c).scaleSelf(0.333);
				  Vec3D d = c.add(f.normal.scale(5));
				  
				  Vec3D n = f.normal.scale(10);
				  n.addSelf(128,128,128);
				  
				  stroke(n.x , n.y, n.z );
				  line(c.x, c.y, c.z, d.x, d.y, d.z);
				}
				count++;
			  }
			}
		
		}
		Axis(10);
    	
		popMatrix();
		
  	}
  	void toSCA(easySunflowAPI api) {
		if (!visible) return;

		ObjLoaderPart part;
		for (int j = 0; j < groups.length; j++) {
			part=groups[j];
			SunflowShader shader=part.shader;
			String tname=name+"_"+part.name;
			WETriangleMesh mesh=part.mesh.copy();
			
			guiConsole("add toxilibs mesh: vertex= "+mesh.getNumVertices()+" faces= "+mesh.getNumFaces()+" material= "+shader.name);
			
			
			int[] triangles = mesh.getFacesAsArray();
			float[] vertices = new float[mesh.getNumVertices() * 3];
			float[] normals = new float[mesh.getNumVertices() * 3];
		   
			int id = 0;
			Iterator localIterator = mesh.vertices.values().iterator();
			while (localIterator.hasNext()){
				toxi.geom.mesh.Vertex v = (toxi.geom.mesh.Vertex)localIterator.next();
				vertices[id] = v.x;normals[id] = v.normal.x;id++;
				vertices[id] = -v.y;normals[id] = -v.normal.y;id++;
				vertices[id] = v.z;normals[id] = v.normal.z;id++;
			}
			 
			// to sunflow
			api.sunflow.parameter("triangles", triangles);
			api.sunflow.parameter("points", "point", "vertex", vertices);
			if(smooth) api.sunflow.parameter("normals", "vector", "vertex", normals);
		   
			api.sunflow.geometry( tname, "triangle_mesh" );
			api.sunflow.parameter( "shaders", shader.name);
			api.sunflow.parameter( "transform", api.setTransformMatrix(this));
			
			if (modifiers.size()!=0) {
			
				println("--------------------------------");
				for (int i=0;i<modifiers.size();i++) {
					api.sunflow.parameter("modifiers", (String)modifiers.get(i));
	
				}
			}
			api.sunflow.instance( tname + ".instance", tname );
			
			 
		}
	 
  	}
	void setRotation(PVector rot){
  		rotation=rot;
  		rotation.mult(new PVector(-1,1,-1));
  	}
  	void setRotation(float rx,float ry,float rz){
  		rotation=new PVector(rx,ry,rz);
  		rotation.mult(new PVector(-1,1,-1));
  	}
  	void setShader(SunflowShader _shader){
  		shader=_shader;
  		for (int i = 0; i < groups.length; i++) {
  			groups[i].shader=shader;
  		}
  	}
  	void setSmooth(boolean flag) {
    	smooth=flag;
  	}
  	void showNormals(boolean flag) {
    	shownormals=flag;
  	}
  	void showWireFrame(boolean flag) {
    	showwireframe=flag;
  	}
  
  	WETriangleMesh getMeshFortSegment(Segment seg) {
		WETriangleMesh mesh = new WETriangleMesh();
		for (int i = 0; i < seg.getFaceCount(); i++) {
			saito.objloader.Face face = seg.getFace(i);
			
			 
			if (face.getVertIndexCount()!=3){
				println("numbers of face vertex error");
				System.exit(0);
			}
			
			if (face.vertices.get(0) ==null || face.vertices.get(1)==null || face.vertices.get(2)==null ) {
				println("vertex error");
				System.exit(0);
			}
			
			Vec3D a = new Vec3D(face.vertices.get(0).x, face.vertices.get(0).y,face.vertices.get(0).z);
			Vec3D b = new Vec3D(face.vertices.get(1).x, face.vertices.get(1).y,face.vertices.get(1).z);
			Vec3D c = new Vec3D(face.vertices.get(2).x, face.vertices.get(2).y,face.vertices.get(2).z);
			mesh.addFace(a, b, c);
			 
		}
		return mesh;
	}
	Object getPrivateField(String field,OBJModel model){
	try{
    	Field f = OBJModel.class.getDeclaredField(field);
    	f.setAccessible(true);//Very important, this allows the setting to work.
  		return f.get(model);
	}catch (Exception e) {
     	e.printStackTrace();
   	}
 	return null;
	}
}
class ObjLoaderInstance extends Geometry{

	ObjLoader target;
	boolean smooth=true;
  	boolean shownormals=false;
  	boolean showwireframe=true;
	ObjLoaderPart[] groups;
	SunflowShader shader;
	
	ObjLoaderInstance(ObjLoader _target) {
	 	super();
		type="ObjLoaderInstance";
		target=_target;
		groups =new ObjLoaderPart[target.groups.length];
	
		for (int i=0;i<target.groups.length; i++) {
  		 	
  		 	groups[i] =new ObjLoaderPart("group"+i,target.groups[i].mesh);
  		 	groups[i].shader=target.groups[i].shader;
  		 	groups[i].name=_target.name+"_"+groups[i].name;
		}   
	}
	void draw(){
  		if (!visible) return;
		 
    	pushMatrix();
		translate(position.x, -position.y, position.z);
		rotateZ(radians(-rotation.z));
		rotateX(radians(-rotation.x));
		rotateY(radians(rotation.y));
		scale (size.x, size.y, size.z); 
    	
    	ObjLoaderPart group;
		for (int j = 0; j < groups.length; j++) {
			group=groups[j];
			
			
			color co =group.shader.col.toColor();
			if (!shadingflag) 
			{
			  noFill();
			  stroke(co);
			}
			else 
			{
			   if (showwireframe) stroke(127, 30);
			   else noStroke();
			  fill(co);
			}
			

			//decimate mesh with scenedetails var
			int count=0;
			int step= (int)ESF.getSceneDetails(10000); 
			
			beginShape(TRIANGLES);
			for (Iterator i=group.mesh.faces.iterator(); i.hasNext();)
			{
				toxi.geom.mesh.Face f=(toxi.geom.mesh.Face)i.next();
				
				if (count%step==0) {
					if (smooth)
					{
						normal(f.a.normal.x, f.a.normal.y, f.a.normal.z);
						vertex(f.a.x, f.a.y, f.a.z);
						normal(f.b.normal.x, f.b.normal.y, f.b.normal.z);
						vertex(f.b.x, f.b.y, f.b.z);
						normal(f.c.normal.x, f.c.normal.y, f.c.normal.z);
						vertex(f.c.x, f.c.y, f.c.z);
					} 
					else
					{
						normal(f.normal.x, f.normal.y, f.normal.z);
						vertex(f.a.x, f.a.y, f.a.z);
						vertex(f.b.x, f.b.y, f.b.z);
						vertex(f.c.x, f.c.y, f.c.z);
					}
				}
				count++;
			}
			endShape();
		
			// show normals
			if (shownormals) {
			  count=0;
			  for (Iterator i=group.mesh.faces.iterator(); i.hasNext();) {
				toxi.geom.mesh.Face f=(toxi.geom.mesh.Face)i.next();
				if (count%step==0) {
				  Vec3D c = f.a.add(f.b).addSelf(f.c).scaleSelf(0.333);
				  Vec3D d = c.add(f.normal.scale(5));
				  
				  Vec3D n = f.normal.scale(10);
				  n.addSelf(128,128,128);
				  
				  stroke(n.x , n.y, n.z );
				  line(c.x, c.y, c.z, d.x, d.y, d.z);
				}
				count++;
			  }
			}
		
		}
		Axis(10);
		popMatrix();
  	}
	void toSCA(easySunflowAPI api) {
		if (!visible) return;
		 
		ObjLoaderPart group;
		for (int j = 0; j < groups.length; j++) {
			group=groups[j];
			SunflowShader shader=group.shader;
			api.sunflow.parameter( "shaders", shader.name);
			api.sunflow.parameter( "transform", api.setTransformMatrix(this));
			api.sunflow.instance(name+"_"+group.name+".instance", group.name );
		}
  	}
  	void setShader(SunflowShader _shader){
  		for (int i = 0; i < groups.length; i++) {
  			groups[i].shader=_shader;
  		}
  	}
  	
  	void setSmooth(boolean flag) {
    	smooth=flag;
  	}
  	void showNormals(boolean flag) {
    	shownormals=flag;
  	}
  	void showWireFrame(boolean flag) {
    	showwireframe=flag;
  	}
  	void setRotation(PVector rot){
  		rotation=rot;
  		rotation.mult(new PVector(-1,1,-1));
  	}
  	void setRotation(float rx,float ry,float rz){
  		rotation=new PVector(rx,ry,rz);
  		rotation.mult(new PVector(-1,1,-1));
  	}
}
class ObjLoaderPart {

	WETriangleMesh mesh;
	SunflowShader shader=new ShaderDiffuse("default", new SunflowColor(.8,.8,.8));
	String name;
	
	ObjLoaderPart(String _name,WETriangleMesh _mesh){
		mesh=_mesh;
		name=_name;
	}
	ObjLoaderPart(){
		name="";
	}
	void setShader(SunflowShader _shader){
		shader=_shader;
	}
	void setMesh(WETriangleMesh _mesh){
		mesh=_mesh;
	}
	
}


//------------------------------------------------------------------------------
//	UTILITIES
//------------------------------------------------------------------------------
int 	toR(color c) {
  int r=c >> 16 & 0xFF;
  return r;
}
int 	toG(color c) {
  int g=c >> 8 & 0xFF;
  return g;
}
int 	toB(color c) {
  int b = c & 0xFF;
  return b;
}
int 	hsbColor(float h, float s, float b) {
  colorMode(HSB, 360, 100, 100);
  color col= color(h, s, b);
  colorMode(RGB, 255);
  return col;
}
String 	toPath(String name) {
  return sketchPath(name);
}
String 	Zerofill4(int n) {
  String number = str(n) ; 
  while (number.length () < 4) {
    number = "0" + number;
  }
  return number;
}
String 	Zerofill(int n, int car) {
  String strnum = str(n);
  int chars = strnum.length();
  boolean tooBig = chars>=car;
  if (!tooBig) {
    int dif = car-chars;
    for (int j = 0; j<dif; j++) {
      strnum = "0"+strnum;
    }
  }
  return strnum;
}
String 	TimeStamp() {
  return year() + "_" + nf(month(), 2) + "_" + nf(day(), 2) + "_" + nf(hour(), 2) + "" + nf(minute(), 2) + "" + nf(second(), 2);
}

Point3 	toPoint3(PVector p) {
  return new Point3(p.x, p.y, p.z);
}
Point3 	toPoint3(Vec3D p) {
  return new Point3(p.x, p.y, p.z);
}
Vector3 toVector3(PVector p) {
  return new Vector3(p.x, p.y, p.z);
}
PVector toPVector(Vec3D p) {
  return new PVector(p.x, p.y, p.z);
}

//	MATH
float round3(float x){
	return  Math.round(x*1000.0) / 1000.0;
}
float 	SnapTo(float number, float step) {
  return round(number/step)*step;
}

/**
 * Polar To Cartesian
 *
 * @param rho radius
 * @param theta angle
 * @param phi angle
 * @return a new PVector
 */
PVector PolarToCartesian(float rho, float theta, float phi) {
  float r = rho * cos(phi);
  float x=r * cos(theta);
  float y=rho * sin(phi);
  float z=r * sin(theta);
  return new PVector(x, y, z);
}
/**
 * Cartesian To Polar
 *
 * @param u nomalized x
 * @param v nomalized y
 * @param y elevation
 * @return a new PVector
 */
PVector CartesianToPolar(float u, float y, float v) {
  float  phi  =  (u * TWO_PI)-HALF_PI;
  float  theta = PI - (v * PI);
  float mx = y*sin(theta)*cos(phi);
  float my = y*sin(theta)*sin(phi);
  float mz = y*cos(theta);
  return new PVector (mx, my, mz);
}
PVector toCylinder(float r, float a, float h) {
  PVector pos =new PVector(r*cos(a), -h, r*sin(a));
  return pos;
}

// 	Catmull-Rom spline
PVector CatmullRom(PVector p1, PVector p2, PVector p3, PVector p4, float t) {
  float t2 = t*t;
  float t3 = t2*t;
  PVector p = new PVector();
  p.x = (((-p1.x+3*p2.x-3*p3.x+p4.x)*t3)+((2*p1.x-5*p2.x+4*p3.x-p4.x)*t2)+((-p1.x+p3.x)*t)+(2*p2.x))*.5;
  p.y = (((-p1.y+3*p2.y-3*p3.y+p4.y)*t3)+((2*p1.y-5*p2.y+4*p3.y-p4.y)*t2)+((-p1.y+p3.y)*t)+(2*p2.y))*.5;
  p.z = (((-p1.z+3*p2.z-3*p3.z+p4.z)*t3)+((2*p1.z-5*p2.z+4*p3.z-p4.z)*t2)+((-p1.z+p3.z)*t)+(2*p2.z))*.5;
  return p;
}



//------------------------------------------------------------------------------
//	PRESETS
//------------------------------------------------------------------------------

//  camera animation presets
void ProsceneAnimator() {

	// animator for PROSCENE
  Animator prosceneanimator=new Animator(this, "ProsceneAnimatorListener");
  prosceneanimator.setInterpolationType(prosceneanimator.LINEAR_INTERPOLATION);
  prosceneanimator.addKeyFrame(0, 0f);
  prosceneanimator.addKeyFrame(timeline.getEnd(), 1f);
  
  //animator for FOV
  fovanimator=new Animator(this, "guiSetFOV");
  fovanimator.setInterpolationType(fovanimator.COSINE_INTERPOLATION);
  
  timeline.addAnimator(prosceneanimator);
  timeline.addAnimator(fovanimator);
  timeline.Stop();
  
}
void ProsceneAnimatorListener(float t) {
	keyframeinterpolator = thecamera.keyFrameInterpolator(thescene.path('1'));
	if (keyframeinterpolator!=null) {
    	keyframeinterpolator.interpolateAtTime(t*keyframeinterpolator.duration());
  	}
  	
  	ESF.ActionCamera();
}

//  Shader presets
SunflowShader	diffuse_neutral, diffuse_red, diffuse_dark,glass_neutral, glass_dark, glass_light,mirror_neutral, mirror_dark, mirror_light;
SunflowShader	shiny_neutral, shiny_dark, shiny_light,phong_neutral, phong_less, phong_more,glow_neutral, glow_yellow,ward_neutral,ao;
void InitShaderPreset() {

  diffuse_neutral = new ShaderDiffuse("diffuse_neutral", new SunflowColor(.95, .95, .95));
  ESF.addShader(diffuse_neutral);

  diffuse_red = new ShaderDiffuse("diffuse_red", new SunflowColor(.9, 0, 0));
  ESF.addShader(diffuse_red);
  diffuse_dark = new ShaderDiffuse("diffuse_dark", new SunflowColor(.2, .2, .2));
  ESF.addShader(diffuse_dark);

  mirror_neutral=new ShaderMirror("mirror_neutral", new SunflowColor(0.6, 0.6, 0.6));
  ESF.addShader(mirror_neutral);
  mirror_dark=new ShaderMirror("mirror_dark", new SunflowColor(0.3, 0.3, 0.3));
  ESF.addShader(mirror_dark);
  mirror_light=new ShaderMirror("mirror_light", new SunflowColor(0.9, 0.9, 0.9));
  ESF.addShader(mirror_light);

  shiny_neutral = new ShaderShine("shiny_neutral", new SunflowColor(0.5, 0.5, 0.5), .5);
  ESF.addShader(shiny_neutral);
  shiny_dark = new ShaderShine("shiny_dark", new SunflowColor(0.2, 0.2, 0.2), .5);
  ESF.addShader(shiny_dark);
  shiny_light = new ShaderShine("shiny_light", new SunflowColor(0.9, 0.9, 0.9), .5);
  ESF.addShader(shiny_light);

  glass_neutral = new ShaderGlass("glass_neutral", new SunflowColor(.6, .6, .6), 1.33);
  ESF.addShader(glass_neutral);
  glass_dark = new ShaderGlass("glass_dark", new SunflowColor(.4, .4, .4), 1.33);
  ESF.addShader(glass_dark);
  glass_light = new ShaderGlass("glass_light", new SunflowColor(1, 1, 1), 2.33);
  ESF.addShader(glass_light);

  phong_neutral=new ShaderPhong("phong_neutral", new SunflowColor(.5, .5, .5), new SunflowColor(1, 1, 1), 400, 100);
  ESF.addShader(phong_neutral);
  phong_less=new ShaderPhong("phong_less", new SunflowColor(.8, .8, .8), new SunflowColor(1, 1, 1), 50, 100);
  ESF.addShader(phong_less);
  phong_more=new ShaderPhong("phong_more", new SunflowColor(.8, .8, .8), new SunflowColor(1, 1, 1), 400, 100);
  ESF.addShader(phong_more);

  ao=new ShaderAO("ao", new SunflowColor(.98, .98, .98), 64, 64);
  ESF.addShader(ao); 

  glow_neutral=new ShaderConstant("glow_neutral", new SunflowColor(1000, 1000, 1000));
  ESF.addShader(glow_neutral);
  glow_yellow=new ShaderConstant("glow_yellow", new SunflowColor(100, 50, 0));
  ESF.addShader(glow_yellow);

  ShaderWard ward_neutral=new ShaderWard("ward_neutral", new SunflowColor(.3, 1, 1), new SunflowColor(1, 1, 1), .02, .02, 4);
  ESF.addShader(ward_neutral);
}





