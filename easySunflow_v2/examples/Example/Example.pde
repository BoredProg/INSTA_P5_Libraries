//------------------------------------------------------------------
/*   
	here is a list of examples that show the various 
	commands that can be used with easySunflow.
*/
//------------------------------------------------------------------


//------------------------------------------------------------------
//  PRIMITIVES
//------------------------------------------------------------------
void EXAMPLE_PRIMITIVES(){

	// set sun position
	guiSunPosition(-150,30);
	 
	// shader diffuse
	ShaderDiffuse diffuse_white =new ShaderDiffuse("diffuse_white", new SunflowColor(.9, .9, .9));
	ESF.addShader(diffuse_white);
	// shader shine
	ShaderShine shaderground=new ShaderShine("shaderground",new SunflowColor(.1, .1, .1),.1);
	ESF.addShader(shaderground);
	 
	// sphere parameters
	Sphere thesphere= new Sphere();
	thesphere.setSize(50);
	thesphere.setPosition(-300,50,0);
	thesphere.setShader(diffuse_white);
	ESF.addGeometry("thesphere", thesphere);
	 
	//cube parameters
	Cube thecube= new Cube();
	thecube.setSize(50);
	thecube.setPosition(-100,50,0);
	thecube.setShader(diffuse_white);
	ESF.addGeometry("thecube",thecube);
	 
	// cylinder parameters
	Cylinder thecylinder=new Cylinder();
	thecylinder.setSize(50);
	thecylinder.setPosition(100,50,0);
	thecylinder.setRotation(90,0,0);
	thecylinder.setShader(diffuse_white);
	ESF.addGeometry("thecylinder",thecylinder);
	 
	//torus parameters
	Torus thetorus=new Torus();
	thetorus.setSize(50);
	thetorus.setPosition(300,60,0);
	thetorus.setShader(diffuse_white);
	ESF.addGeometry("thetorus",thetorus);
	 
	//ground parameters
	Ground ground=new Ground();
	ground.setShader(shaderground);
	ESF.addGeometry("ground", ground);

}

//------------------------------------------------------------------
//  LIGHTS
//------------------------------------------------------------------
void  EXAMPLE_LIGHTS(){

	// disable sun light
	guiSetSunVisible(false);
	 
	//     SpericalLight
	SpericalLight spherical=new SpericalLight("sperical",new PVector(-300,100,-200));
	spherical.setColor(color(200,200,200));
	spherical.setPower(5);
	spherical.setSize(60);
	ESF.addLight(spherical);
	 
	//     PointLight
	PointLight  pointLight=new PointLight("pointLight",new PVector(300,100,-200));
	pointLight.setPower(200);
	ESF.addLight(pointLight);
	 
	//    Spotlight
	Spotlight spotlight=new Spotlight("spotlight",new PVector(0,200,100),new PVector(0,0,-450)); 
	spotlight.setPower(5);
	spotlight.setRadius(300);
	ESF.addLight(spotlight);
	 
	// shader diffuse
	ShaderDiffuse shaderground =new ShaderDiffuse("shaderground", new SunflowColor(.8, .8, .8));
	ESF.addShader(shaderground);
	 
	//cube parameters
	Cube room= new Cube();
	room.setSize(500);
	room.setPosition(0,500,0);
	room.setShader(shaderground);
	ESF.addGeometry("room",room);
	 
	ShaderDiffuse shadersphere =new ShaderDiffuse("shadersphere", new SunflowColor(1, 0, 0));
	ESF.addShader(shadersphere);
	 
	// sphere parameters
	Sphere thesphere= new Sphere();
	thesphere.setSize(50);
	thesphere.setPosition(-100,50,0);
	thesphere.setShader(shadersphere);
	ESF.addGeometry("thesphere", thesphere);

}

//------------------------------------------------------------------
//  COLORS
//------------------------------------------------------------------
void EXAMPLE_COLORS(){

	int radius=300;
	int spherenum=16;
	float step=TWO_PI/spherenum;
	 
	for(int i=0;i<spherenum;i++){
		float angle=i*step;
		PVector position=new PVector(radius*cos(angle+PI),50,radius*sin(angle+PI));
		 
		// shader shine wi
		int thespherecolor=hsbColor(angle*57, 100,80);
		ShaderShine shader=new ShaderShine("color"+i,new SunflowColor(thespherecolor),.1);
		ESF.addShader(shader);
		 
		// sphere parameters
		Sphere thesphere= new Sphere(position);
		thesphere.setSize(50);
		thesphere.setShader(shader);
		ESF.addGeometry("thesphere"+i, thesphere);
	}
	 
	// ground shader
	ShaderDiffuse shaderground =new ShaderDiffuse("diffuse_white", new SunflowColor(.9, .9, .9));
	ESF.addShader(shaderground);
	 
	//ground parameters
	Ground ground=new Ground();
	ground.setShader(shaderground);
	ESF.addGeometry("ground", ground);
}

//------------------------------------------------------------------
//  SHADERS
//------------------------------------------------------------------
void EXAMPLE_SHADERS(){
	// set camera parameters
	ESF.setCamera(new float[]{-235.33,-288.22,507.12,-235.00,-287.78,506.28,-0.18,0.90,0.39,60.0});
	 
	// ground shader
	ShaderDiffuse shaderground =new ShaderDiffuse("shaderground", new SunflowColor(.4, .4, .45));
	ESF.addShader(shaderground);
	 
	//add ground
	Ground ground=new Ground();
	ground.setShader(shaderground);
	ESF.addGeometry("ground", ground);
	 
	 
	ShaderDiffuse diffuse_neutral = new ShaderDiffuse("diffuse_neutral", new SunflowColor(.95, .95, .95));
	ESF.addShader(diffuse_neutral);
	// sphere diffuse
	Sphere sphere1= new Sphere(new PVector(-270,50,0));
	sphere1.setSize(50);
	sphere1.setShader(diffuse_neutral);
	ESF.addGeometry("sphere1", sphere1);
	 
	 
	ShaderMirror mirror_neutral=new ShaderMirror("mirror_neutral", new SunflowColor(0.6, 0.6, 0.6));
	ESF.addShader(mirror_neutral);
	// sphere mirror
	Sphere sphere2= new Sphere(new PVector(-120,50,0));
	sphere2.setSize(50);
	sphere2.setShader(mirror_neutral);
	ESF.addGeometry("sphere2", sphere2);
	 
	 
	ShaderShine shiny_neutral = new ShaderShine("shiny_neutral", new SunflowColor(0.5, 0.5, 0.5), .5);
	ESF.addShader(shiny_neutral);
	// sphere shiny
	Sphere sphere3= new Sphere(new PVector(0,50,0));
	sphere3.setSize(50);
	sphere3.setShader(shiny_neutral);
	ESF.addGeometry("sphere3", sphere3);
	 
	ShaderGlass glass_neutral = new ShaderGlass("glass_neutral", new SunflowColor(.7, .7, .7), 3.1);
	ESF.addShader(glass_neutral);
	// sphere glass
	Sphere sphere4= new Sphere(new PVector(120,50,0));
	sphere4.setSize(50);
	sphere4.setShader(glass_neutral);
	ESF.addGeometry("sphere4", sphere4);
	 
	ShaderPhong phong_neutral=new ShaderPhong("phong_neutral", new SunflowColor(.5, .5, .5), new SunflowColor(1, 1, 1), 1, 1);
	ESF.addShader(phong_neutral);
	// sphere phong
	Sphere sphere5= new Sphere(new PVector(270,50,0));
	sphere5.setSize(50);
	sphere5.setShader(phong_neutral);
	ESF.addGeometry("sphere5", sphere5);
}

//------------------------------------------------------------------
//  ANIMATORS & TIMELINE
//------------------------------------------------------------------
SpericalLight spericallight;
void EXAMPLE_TIMELINE(){

	// set the sun position
	guiSunPosition(-30,-10);

	// ground shader
	ShaderShine shaderground = new ShaderShine("shaderground", new SunflowColor(0.5, 0.5, 0.5), .5);
	ESF.addShader(shaderground);
	 
	//ground parameters
	Ground ground=new Ground();
	ground.setShader(shaderground);
	ESF.addGeometry("ground", ground);
	 
	// FileGeometry use Sunflow standard parser
	FileGeometry model=new FileGeometry("examples/models/topmod1.obj",false);
	ESF.addGeometry("external_obj",model);
	model.setPosition(0,100,0);
	model.setSize(50);
	 
	// add light
	spericallight=new SpericalLight("Sperical",new PVector(-300,50,200));
	spericallight.setColor(color(200,200,200));
	spericallight.setPower(10);
	spericallight.setSize(50);
	ESF.addLight(spericallight);
	
	 
	 
	// 	some animators in action
	//------------------------------------------------------------------
	// sun animator
	Animator animsun=new Animator( ESF.thesun,"setLatitude");
	animsun.addKeyFrame(0,-10f);
	animsun.addKeyFrame(timeline.getEnd()/2,-20f);
	animsun.Dump();
	 
	// animator for model position
	Animator animpos=new Animator(model,"setPosition");
	animpos.addKeyFrame(0,                    new PVector(-300,100,0));
	animpos.addKeyFrame(timeline.getEnd()/2,new PVector(0,200,0));
	animpos.addKeyFrame(timeline.getEnd(),    new PVector(300,100,0));
	 
	// model rotation
	Animator animarot=new Animator(model,"setRotation");
	animarot.addKeyFrame(0,                    new PVector(0,0,0));
	animarot.addKeyFrame(timeline.getEnd(),    new PVector(0,180,0));
	 
	// animator for light color
	Animator animalc=new Animator(spericallight,"setColor");
	animalc.addKeyFrame(0,                    new SunflowColor (color(200,0,0)));
	animalc.addKeyFrame(timeline.getEnd()/2,new SunflowColor (color(0,200,0)));
	animalc.addKeyFrame(timeline.getEnd(),    new SunflowColor (color(200,200,200)));
	animalc.setInterpolationType(animpos.LINEAR_INTERPOLATION);
	 
	// animator with custom listener for movement
	Animator animsp=new Animator(this,"SpericalLightListener");
	animsp.addKeyFrame(0,                    0f);
	animsp.addKeyFrame(timeline.getEnd(),    1f);
	 
	// add  animators to timeline
	timeline.addAnimator(animsun);
	timeline.addAnimator(animpos);
	timeline.addAnimator(animarot);
	timeline.addAnimator(animalc);
	timeline.addAnimator(animsp);
	 
	// set timeline to frame 1
	timeline.Stop();
	
	
}
// custom animator listener
void SpericalLightListener(float t) {
    float a=t*(TWO_PI*4);
    PVector position=new PVector(-300+600*t,  50+abs(100*sin(a)), 300);
    spericallight.setPosition(position);
}
 
 
//------------------------------------------------------------------
//  CAMERA KEYFRAMES
//------------------------------------------------------------------
void EXAMPLE_KEYFRAMES(){

	// sphere parameters
	Sphere thesphere= new Sphere();
	thesphere.setSize(50);
	thesphere.setPosition(0,50,0);
	ESF.addGeometry("thesphere", thesphere);
	 
	// set keyframes for camera eye,target,up
	ESF.addKeyFrame(
	new PVector(-155.37,-44.077,2594.277),
	new PVector(-155.31,-44.093,2593.279),
	new PVector(-0.0090,1.0,-0.017),60);
	 
	ESF.addKeyFrame(
	new PVector(-70.165,-507.827,954.997),
	new PVector(-70.098,-507.43,954.082),
	new PVector(-0.02,0.918,0.397),60);
	 
	ESF.addKeyFrame(
	new PVector(637.068,-542.27,477.246),
	new PVector(636.412,-541.727,476.722),   
	new PVector(0.434,0.84,0.327),60);
	 
	ESF.addKeyFrame(
	new PVector(397.549,-53.279,-875.667),
	new PVector(397.113,-53.247,-874.767),
	new PVector(0.017,1.0,-0.026),60);
	 
	ESF.addKeyFrame(
	new PVector(-60.33,-259.086,-3207.984),
	new PVector(-60.319,-259.013,-3206.986),
	new PVector(0.0080,0.997,-0.073),60);
	 
	 
	// enable camera action
	guisetActionCamera(true);
	// set action camera jitter and amplitude
	guiSetActionCameraParameters(.1,10);
}

//------------------------------------------------------------------
//  PARTICLES SYSTEM
//------------------------------------------------------------------
void EXAMPLE_PARTICLES(){
	// shader diffuse
	ShaderDiffuse shader =new ShaderDiffuse("shader_particles", new SunflowColor(.9, .2, .2));
	ESF.addShader(shader);   
	 
	Particles particles=new Particles(new PVector(0,0,0));
	particles.setShader(shader);
	particles.setRadius(1);
	 
	int np =10000;
	float res=.005;
	float radius=300;
	PVector pos=new PVector(0,0,0);
	 
	for (int i=0;i<np;i++) {
		pos.x=(.5-noise(i*res))*radius;
		pos.y=(.5-noise(i*res*1.1))*radius;
		pos.z=(.5-noise(i*res*1.2))*radius;
		 
		particles.addParticle(pos);
	}
	ESF.addGeometry("particles_group",particles);
}

//------------------------------------------------------------------
//  TOXILIBS OBJECT
//------------------------------------------------------------------
void EXAMPLE_TOXILIBS(){
	
	// add shaders
	ShaderDiffuse shader =new ShaderDiffuse("diffuse_color", new SunflowColor(.8, .8, .8));
	ESF.addShader(shader);
	ShaderDiffuse groundshader =new ShaderDiffuse("groundshader", new SunflowColor(.3, .1, .1));
	ESF.addShader(groundshader);
	// add ground
	Ground ground=new Ground();
	ground.setShader(groundshader);
	ESF.addGeometry("ground", ground);
	 
	//------------------------------------------------------------------
	// source code: http://openprocessing.org/sketch/29202
	//------------------------------------------------------------------
	int VOXEL_RES=50;
	int VOXEL_STROKE_WEIGHT=5;
	int SPHERE_RES=50;
	int SMOOTH_ITER=12;
	 
	// create a hemi-sphere mesh
	WETriangleMesh     tmp=new WETriangleMesh().addMesh(new toxi.geom.Sphere(150).toMesh(SPHERE_RES));
	WETriangleMesh  obj=MeshLatticeBuilder.build(tmp, VOXEL_RES, VOXEL_STROKE_WEIGHT);
	 
	// smooth mesh filter
	for(int i=0; i<SMOOTH_ITER; i++) {
		new LaplacianSmooth().filter(obj,1);
	}
	//------------------------------------------------------------------
	 
	// add toxi mesh
	ToxiMesh  mesh=new ToxiMesh(obj);
	mesh.setShader(shader);
	mesh.setSmooth(true);
	mesh.showNormals(false);
	mesh.showWireFrame(true);
	mesh.setPosition(0,150,0);
	ESF.addGeometry("toxiobj",mesh);
}

//------------------------------------------------------------------
//  TOXILIBS INSTANCES
//------------------------------------------------------------------
void EXAMPLE_TOXILIBS_INSTANCES(){
	// low details
	guiSetSceneDetails(5);
	 
	 // create shaders
	ShaderDiffuse shader =new ShaderDiffuse("diffuse_color", new SunflowColor(.8, .8, .8));
	ESF.addShader(shader);
	ShaderDiffuse groundshader =new ShaderDiffuse("groundshader", new SunflowColor(.3, .1, .1));
	ESF.addShader(groundshader);
	ShaderMirror mirror_neutral=new ShaderMirror("mirror_neutral", new SunflowColor(0.6, 0.6, 0.6));
	ESF.addShader(mirror_neutral);
	ShaderPhong phong_neutral=new ShaderPhong("phong_neutral", new SunflowColor(.5, .5, .5), new SunflowColor(1, 1, 1), 1, 1);
	ESF.addShader(phong_neutral);
	 
	Ground ground=new Ground();
	ground.setShader(groundshader);
	ESF.addGeometry("ground", ground);
	 
	// Spherical Harmonics Mesh
	SurfaceMeshBuilder shape = new SurfaceMeshBuilder(new SphericalHarmonics(new float[]{2,4,6,4,0,6,4,2}));
	toxi.geom.mesh.TriangleMesh toximesh = (toxi.geom.mesh.TriangleMesh)shape.createMesh(null,60,50);
	 
	//  add toxi to the scene
	ToxiMesh  mesh=new ToxiMesh();
	mesh.setMesh(toximesh);
	mesh.setPosition(0,150,0);
	mesh.setShader(shader);
	ESF.addGeometry("toxiobj",mesh);
	 
	// create instances
	int n=10;
	int id=0;
	for (int z=0;z<n;z++) {
		for (int x=0;x<n;x++) {
			float caso=random(.1,.8);
			ToxiInstance inst=new ToxiInstance(mesh,random(1)>.5?mirror_neutral:phong_neutral);
			inst.setSize(caso);
			inst.setRotation(0,random(180),random(180));
			inst.setPosition(x*100,120,z*100);   
			ESF.addGeometry("ins"+id++,inst);
		}
	}
}

//------------------------------------------------------------------
//  TOXILIBS STLReader
//------------------------------------------------------------------
void EXAMPLE_TOXILIBS_STL(){


	// shader shine
	ShaderShine shaderground=new ShaderShine("shaderground",new SunflowColor(.3, .3, .3),.1);
	ESF.addShader(shaderground);
	
	//ground parameters
	Ground ground=new Ground();
	ground.setShader(shaderground);
	ESF.addGeometry("ground", ground);


	// load STL model
	toxi.geom.mesh.TriangleMesh stl = (toxi.geom.mesh.TriangleMesh)new STLReader().loadBinary(sketchPath("examples/models/giraffa.stl"),STLReader.TRIANGLEMESH);
	 
	ToxiMesh  m=new ToxiMesh();
	m.setMesh(stl);
	m.setPosition(0,0,0);
	m.setSize(100);
	m.setRotation(90,0,0);
	ESF.addGeometry("toxistl",m);
}

//------------------------------------------------------------------
//  HEMESH OBJECT
//------------------------------------------------------------------
void EXAMPLE_HEMESH(){
	// disable sun light
	guiSetSunVisible(false);
	ESF.setGI_AO();


	// hemesh creator
	HEC_Cube cube = new HEC_Cube().setEdge(300).setWidthSegments(1).setHeightSegments(1).setDepthSegments(1);
	 
	// hemesh modifiers
	HEM_Lattice lattice = new HEM_Lattice().setDepth(6).setWidth(6);
	HES_Planar planar = new HES_Planar().setRandom(true).setRange(0.7);
	HES_Smooth sm = new HES_Smooth();
	 
	// add modifiers to mesh
	HE_Mesh m = new HE_Mesh(cube);
	m.subdivide( planar, 2 );
	m.subdivide( sm, 1);
	m.modify(lattice);
	 
	// add hemesh to scene
	HemeshMesh mesh=new HemeshMesh(m);
	mesh.setPosition(0,150,0);
	mesh.setSmooth(false);
	ESF.addGeometry("hemesh_",mesh);
	
	// ground shader
	ShaderDiffuse shaderground =new ShaderDiffuse("shaderground", new SunflowColor(.4, .4, .42));
	ESF.addShader(shaderground);
	
	//ground parameters
	Ground ground=new Ground();
	ground.setShader(shaderground);
	ESF.addGeometry("ground", ground);
	
}
//------------------------------------------------------------------
//  HEMESH INSTANCES
//------------------------------------------------------------------
void EXAMPLE_HEMESH_INSTANCES(){

	// shader diffuse
	ShaderDiffuse shaderground =new ShaderDiffuse("shaderground", new SunflowColor(.2, .2, .2));
	ESF.addShader(shaderground);
	//ground parameters
	Ground ground=new Ground();
	ground.setShader(shaderground);
	ESF.addGeometry("ground", ground);
	 
	 
	//------------------------------------------------------------------
	// hemesh creator
	HEC_Cube cube = new HEC_Cube().setEdge(100).setWidthSegments(1).setHeightSegments(1).setDepthSegments(1);
	 
	//hemesh modifiers
	HEM_Lattice lattice = new HEM_Lattice().setDepth(2).setWidth(2);
	HES_Planar planar = new HES_Planar().setRandom(true).setRange(0.7);
	HES_Smooth sm = new HES_Smooth();
	 
	// add modifiers to mesh
	HE_Mesh m = new HE_Mesh(cube);
	 
	m.subdivide( planar, 2 );
	m.subdivide( sm, 1);
	m.modify(lattice);
	//------------------------------------------------------------------
	 
	// add emesh to scene
	HemeshMesh mesh=new HemeshMesh(m);
	mesh.setPosition(0,60,0);
	mesh.setSmooth(false);
	ESF.addGeometry("hemesh_",mesh);
	  
	 
	ShaderDiffuse shader =new ShaderDiffuse("diffuse", new SunflowColor(.9, .9, .9));
	ESF.addShader(shader);
	 
	int instancenum=3;
	for (int i=0;i<=instancenum;i++) {
	  HemeshInstance  item=new HemeshInstance(mesh, shader);
	  item.setPosition(new PVector(0,120+100*i,0));
	  item.setRotation(new PVector(0,45*i,0));
	  ESF.addGeometry("hemeshinstance"+i, item);
	}
}

//------------------------------------------------------------------
//  HEMESH MODIFIERS ANIMATION
//------------------------------------------------------------------
HEM_Lattice lattice;
HemeshMesh themesh;
void EXAMPLE_HEMESH_ANIMATION(){

	
	guiSetShadingMode(true);

	//hemesh creator
	HEC_Cube cube = new HEC_Cube().setEdge(400).setWidthSegments(4).setHeightSegments(4).setDepthSegments(4);
	 
	//hemesh modifiers
	lattice = new HEM_Lattice().setDepth(6).setWidth(6);
	  
	// create dynamic mesh
	HE_DynamicMesh hm = new HE_DynamicMesh(new HE_Mesh(cube));
	// add modifiers and update
	hm.add(lattice);
	hm.update();
	 
	ShaderDiffuse shader  =new ShaderDiffuse("shader", new SunflowColor(.8,.01, .02));
	ESF.addShader(shader);
	 
	 
	themesh=new HemeshMesh(hm);
	themesh.setPosition(0,200,0);
	themesh.setSmooth(false);
	themesh.setShader(shader);
	ESF.addGeometry("hemesh_",themesh);
	 
	// animator for hemesh modifiers
	Animator animmesh=new Animator(this,"HemeshMeshListener");
	animmesh.addKeyFrame(0,0.0);
	animmesh.addKeyFrame(timeline.getEnd()/2,1.0);
	animmesh.addKeyFrame(timeline.getEnd(),.5);
	timeline.addAnimator(animmesh);
	timeline.Stop();
}
// custom animator listener
void HemeshMeshListener(float t){
	float a=t*TWO_PI*2;
	float c=cos(a);
	float s=sin(a);
	  
	lattice.setDepth(30+10*c);
	lattice.setWidth(15+10*s);
	themesh.update();
}

//------------------------------------------------------------------
//  OBJLOADER EXAMPLE
//------------------------------------------------------------------
void EXAMPLE_OBJLOADER(){
	// disable sun light
	guiSetSunVisible(false);
	 
	// custom wire shader
	// name,fill color,wire color,wire size,samples,distance
	ShaderWireframeAO  wire=new ShaderWireframeAO("wire",new SunflowColor(.9,.9,.9),new SunflowColor(.5,.5,.5),.5,32,200);
	ESF.addShader(wire);
	 
	// ObjLoader load model and set the scale to 80
	ObjLoader topmod=new ObjLoader("examples/models/topmod2.obj",80);
	topmod.setShader(wire);
	topmod.setPosition(0,250,0);
	ESF.addGeometry("topmod_",topmod);
	 
	// add background
	Background back=new Background();
	back.setColor(10,41,102);
	ESF.addGeometry("background_",back);
}

//------------------------------------------------------------------
//  OBJLOADER INSTANCES
//------------------------------------------------------------------
void EXAMPLE_OBJLOADER_INSTANCES(){
	// low details
	guiSetSceneDetails(5);
	 
	ObjLoader model=new ObjLoader("examples/models/girl.obj",.5);
	ESF.addGeometry("_model_",model); 
	// create instances
	int n=10;
	int m=10;
	int id=0;
	for (int y=0;y<m;y++) {
	for (int x=0;x<n;x++) {
		 
		float radius=200;
		float phi=(float)x/n*TWO_PI;
		float theta=(float)y/m*PI;
		 
		PVector pos=PolarToCartesian(radius, theta, phi);
		 
		ObjLoaderInstance item=new ObjLoaderInstance(model);
		item.setPosition(pos);
		item.setSize(random(.3,1));
		item.setRotation(new PVector( random(-30,30),random(-30,30),random(-30,30)));
		ESF.addGeometry("item"+id++,item);
	 
	}
	}
}

//------------------------------------------------------------------
//  OVERRIDE SHADER
//------------------------------------------------------------------
void EXAMPLE_OVERRIDESHADER(){

	 // create shaders
	ShaderAO shader =new ShaderAO("AOoverride", new SunflowColor(.9, .2, .2), 32, 64);
	ESF.addShader(shader);
	
	// set shader as override shader
	ESF.setOverrideShader(shader);
	
	// update gui 
	guisetOverrideShader();
}

//------------------------------------------------------------------
//  MODIFIERS
//------------------------------------------------------------------
void EXAMPLE_MODIFIER(){
	
	ShaderMirror mirror_neutral=new ShaderMirror("mirror_neutral", new SunflowColor(0.6, 0.6, 0.6));
	ESF.addShader(mirror_neutral);
	
	Sphere ball= new Sphere(new PVector(0,200,0));
   	ball.setSize(200);
   	ball.setShader(mirror_neutral);
   	ESF.addGeometry("ball",ball);
	
	
	ShaderMirror mirror_dark=new ShaderMirror("mirror_dark", new SunflowColor(0.1, 0.1, 0.15));
	ESF.addShader(mirror_dark);
	
	Ground ground=new Ground();
	ground.setShader(mirror_dark);
	ESF.addGeometry("ground", ground);
	ground.setTextureScale(1000);
	
	
	// try different modifier
	
	//ESF.addModifier(new PerlinNoiseModifier("perlinmap", 2, .01, 1));
	//ground.addModifier("perlinmap"); 
	
	//ESF.addModifier(new BumpMapModifier("bumpmap", "examples/texture/bump2.jpg", 10));
	//ground.addModifier("bumpmap"); 
	
	ESF.addModifier(new NormalMapModifier("normalmap", "examples/texture/normal3.jpg"));
	ground.addModifier("normalmap"); 
	
}



//------------------------------------------------------------------
//  GUI METHODS
//------------------------------------------------------------------
//	guiSetSceneDetails(50); //[0,100]
//	guiSetShadingMode(true);
//	guiSetFOV(80);

//	guiSetIBLVisible(false);
//	guiSetLightsVisible(false);
// 	guiSetIBLVisible(true);

// 	studio lights
//	guiSetStudioLightsVisible(true);
//	studioLightsPlugIn.setLimboColor(color(200,50,0));

// 	guisetActionCamera(true);
//	guiSetActionCameraParameters(.1,20);//jitter and amplitude