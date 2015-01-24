/*
	
 	STUDIO LIGTHS.
 	easeSunflow plugin	
 	 
 	Create a set of studio lightning,
 	with parameters' palette,
 	for each lamp could be set the intensity, 
 	the distance, the height and the angle.
 	
 	On the top of studio is set a infinite plane 
 	with constant shader, useful for global illumination
 	and reflection.
 */
//------------------------------------------------------------------
//------------------------------------------------------------------
StudioLights studioLightsPlugIn;
void InitStudioLightPlugin() {
  if (studioLightsPlugIn==null) studioLightsPlugIn=new StudioLights(this);
}
public void studiolightsmenu() {
  if (controlP5.controller("studiolightsmenu").value()>0) studioLightsPlugIn.setVisible(true);
  else studioLightsPlugIn.setVisible(false);
}	

//------------------------------------------------------------------
//  studio lights  class
//------------------------------------------------------------------
class StudioLights implements ControlListener {

  PApplet applet;
  ControlP5 palettecontroller;
  Palette palette;
  StudioLightsBank leftbank, rightbank, frontbank;
  InfinitePlane toplight;
  Limbo studiolimbo;
  Ground studioground;
  SunflowShader diffuse_limbo;
  boolean 	active;
  float[] lightsstatus;

  StudioLights(PApplet _applet) {


    applet=_applet;

    palettecontroller=new ControlP5(applet);
    palettecontroller.setColorBackground(gui_backcolor);
    palettecontroller.setColorForeground(gui_forecolor);
    palettecontroller.setColorActive(gui_activecolor);
    palettecontroller.setColorValue(gui_valuecolor);
    palettecontroller.setColorLabel(color(130));
    palettecontroller.setMoveable(false);
    

    // create palette for studio lights 
    palette=new Palette(palettecontroller, "Studio Lights", this, 10, 10, 300, 400);
    palette.setBackground(color(30, 35, 39));
    palette.hide();

    active=true;
    lightsstatus=new float[4];
    lightsstatus[0]=0f;
    lightsstatus[1]=0f;
    lightsstatus[2]=0f;
    lightsstatus[3]=0f;


    initStudio();
    initGui();

    setStudioParameter("studioreset", 1);
    setStudioParameter("studiolightsflag", 0);
    //StudioLightsDump();
  }

  //------------------------------------------------------------------
  // STUDIO LIGHTS INIT
  //------------------------------------------------------------------
  void 	initStudio() {

	diffuse_limbo = new ShaderDiffuse("diffuse_limbo", new SunflowColor(.9, .9, .9));
    ESF.addShader(diffuse_limbo);

	studioground=new Ground();
  	studioground.setShader(diffuse_limbo); 
  	studioground.setTextureScale(200);
  	studioground.setVisible(false);
  	ESF.addGeometry("studioground",studioground);

	// create background
    studiolimbo=new Limbo(diffuse_limbo);

    // left yellow light bank
    leftbank=new StudioLightsBank("banksx", 1500, 270, 1500, 400, 100);  
    leftbank.setColor(color(255, 190, 126));
    leftbank.setPower(1);

    //  right cyan light bank
    rightbank=new StudioLightsBank("bankdx", 1500, 90, 1500, 400, 100);  
    rightbank.setColor(color(126, 190, 255));
    rightbank.setPower(1);

    //  frontal white light bank
    frontbank=new StudioLightsBank("bankfront", 500, 180, 1500, 400, 100);  
    frontbank.setColor(color(255, 255, 255));
    frontbank.setPower(1);

    //top light 
    ShaderConstant toplightshader=new ShaderConstant("studiotoplight_shader", new SunflowColor(.1, .1, .1));
    ESF.addShader(toplightshader);

    toplight=new InfinitePlane(new PVector(0, 3000, 0), InfinitePlane.XZ);
    toplight.setShader(toplightshader);
    toplight.setVisible(false);
    ESF.addGeometry("studiotoplight", toplight);
  }
  void 	initGui() {

    color c1=color(153, 133, 107);
    color c2=color(107, 133, 153);
    color c3=color(126, 126, 126);

    int lar =80;
    int px=20;
    int py=20;

    palette.addToggle("studiolightsflag", true, px, py, 40, 15).setLabel("lights off");
    palette.addToggle("limboflag", false, px+60, py, 40, 15).setLabel("limbo off"); 
    palette.addToggle("groundflag", false, px+120, py, 40, 15).setLabel("ground off"); 

    py+=60;
    Slider b1=palette.addSlider("leftbankpower", 0, 100, leftbank.getPower(), px+25, py, 80, 20);
    b1.setLabel("left light power (yellow)");
    b1.captionLabel().style().setMarginLeft(5);
    b1.setColorForeground(c1);
    palette.addToggle("leftbankflag", false, px, py, 20, 20).setLabel(""); 

    py+=24;
    b1=(Slider)palette.addSlider("leftbankdist", 10, 2000, leftbank.distance, px, py, lar, 15);
    b1.setLabel("left distance");
    b1.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b1.setColorForeground(c1);
    b1=(Slider)palette.addSlider("leftbankangle", 0, 360, leftbank.angle, px+85, py, lar, 15);
    b1.setLabel("left angle");
    b1.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b1.setColorForeground(c1);
    b1=(Slider)palette.addSlider("leftbankheight", 50, 2000, leftbank.height, px+170, py, lar, 15);
    b1.setLabel("left height");
    b1.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b1.setColorForeground(c1);

    py+=50;
    Slider b2=palette.addSlider("rightbankpower", 0, 100, rightbank.getPower(), px+25, py, lar, 20);
    b2.setLabel("right light power (blue)");
    b2.captionLabel().style().setMarginLeft(5);
    b2.setColorForeground(c2);
    palette.addToggle("rightbankflag", false, px, py, 20, 20).setLabel(""); 

    py+=24;
    b2=(Slider)palette.addSlider("rightbankdist", 10, 2000, rightbank.distance, px, py, lar, 15);
    b2.setLabel("right distance");
    b2.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b2.setColorForeground(c2);
    b2=(Slider)palette.addSlider("rightbankangle", 0, 360, rightbank.angle, px+85, py, lar, 15);
    b2.setLabel("right angle");
    b2.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b2.setColorForeground(c2);
    b2=(Slider)palette.addSlider("rightbankheight", 50, 2000, rightbank.height, px+170, py, lar, 15);
    b2.setLabel("right height");
    b2.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b2.setColorForeground(c2);

    py+=50;
    Slider b3=palette.addSlider("frontbankpower", 0, 100, frontbank.getPower(), px+25, py, lar, 20);
    b3.setLabel("front light power (white)");
    b3.captionLabel().style().setMarginLeft(5);
    b3.setColorForeground(c3);
    palette.addToggle("frontbankflag", false, px, py, 20, 20).setLabel(""); 

    py+=24;
    b3=(Slider)palette.addSlider("frontbankdist", 10, 2000, frontbank.distance, px, py, lar, 15);
    b3.setLabel("front distance");
    b3.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b3.setColorForeground(c3);
    b3=(Slider)palette.addSlider("frontbankangle", 0, 360, frontbank.angle, px+85, py, lar, 15);
    b3.setLabel("front angle");
    b3.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b3.setColorForeground(c3);
    b3=(Slider)palette.addSlider("frontbankheight", 50, 2000, frontbank.height, px+170, py, lar, 15);
    b3.setLabel("front height");
    b3.captionLabel().style().moveMargin(20, 0, 0, -lar);
    b3.setColorForeground(c3);

    py+=50;
    palette.addToggle("toplightflag", false, px, py, 20, 20).setLabel(""); 
    Slider b4=palette.addSlider("toplightpower", 0, 1, .1, px+25, py, lar, 20);
    b4.setLabel("top light power");
    b4.captionLabel().style().setMarginLeft(5);
    b4.setColorForeground(c3);

    py+=70;
    Button reset=palette.addButton("studioreset", 1, px, py, 60, 15);
    reset.setLabel("reset banks");

    Button save=palette.addButton("savedata", 0, px+65, py, 60, 15);
    save.setLabel("save data");

    Button load=palette.addButton("loaddata", 0, px+130, py, 60, 15);
    load.setLabel("load data");

    Button export=palette.addButton("exportdata", 0, px+200, py, 60, 15);
    export.setLabel("export data");

    // add plugin to menu
    guiAddPlugin("studiolightsmenu", "studio lights", false);
  }
  
  //------------------------------------------------------------------
  // STUDIO LIGHTS METHODS
  //------------------------------------------------------------------	
	void 	Enable(boolean flag){
		
		ControllerInterface[] n = palettecontroller.getControllerList();
		for (int i = 0; i < n.length; i++) {
			Controller e=((Controller)n[i]);
			String name=e.name();
			if (e.position().y<50 || e.position().y>300) continue;
			e.setLock(!flag);
		}
	}
	void 	setStudioParameter(String parameter, float v) {
		palette.setFieldValue(parameter, v);
	  }
	float 	getStudioParameter(String parameter) {
		return palette.getFieldValue(parameter);
	  }
	void 	SaveStudioLights() {
		guiMessage("save studio ligths");
	
		float[]data = StudioLightGet();
	
		PrintWriter output = createWriter("data/studiolightstatus.txt");
		for (int i=0;i<data.length;i++) {
		  output.println(data[i]);
		}
		output.flush();
		output.close();
	  }
	void 	LoadStudioLights() {
		guiMessage("load studio ligths");
		String[] tmp = loadStrings("data/studiolightstatus.txt");
	
		float[] data=new float[tmp.length];
		for (int i=0;i<tmp.length;i++) {
		  data[i]= Float.parseFloat(tmp[i]);
		}
		StudioLightConfigure(data);
	  }
	void 	StudioLightsDump() {
	
		float[] data=StudioLightGet	( );
		println("studio lights  parameters:");
	
		println("\nlimbo:");
		println("visible: \t"+data[1]);
		
		println("\nground:");
		println("visible: \t"+data[19]);
	
		println("\nleft:");
		println("active: \t"+data[2]);
		println("power: \t"+data[3]);
		println("angle: \t"+data[4]);
		println("distance: \t"+data[5]);
		println("heigth: \t"+data[6]);
	
		println("\nright:");
		println("active: \t"+data[7]);
		println("power: \t"+data[8]);
		println("angle: \t"+data[9]);
		println("distance: \t"+data[10]);
		println("heigth: \t"+data[11]);
	
		println("\nfront:");
		println("active: \t"+data[12]);
		println("power: \t"+data[13]);
		println("angle: \t"+data[14]);
		println("distance: \t"+data[15]);
		println("heigth: \t"+data[16]);
	
		println("\ntop:");
		println("visible: \t"+data[17]);
		println("power: \t"+data[18]);
		
		
	  }
	float[]	StudioLightGet	( ) {
		Palette sl=palette;
		float[] data= {
	
		  getStudioParameter("studiolightsflag"), 
		  getStudioParameter("limboflag"), 
	
		  getStudioParameter("leftbankflag"), 	
		  getStudioParameter("leftbankpower"), 	
		  getStudioParameter("leftbankdist"), 	
		  getStudioParameter("leftbankangle"), 	
		  getStudioParameter("leftbankheight"), 
	
		  getStudioParameter("rightbankflag"), 	
		  getStudioParameter("rightbankpower"), 	
		  getStudioParameter("rightbankdist"), 	
		  getStudioParameter("rightbankangle"), 
		  getStudioParameter("rightbankheight"), 
	
		  getStudioParameter("frontbankflag"), 	
		  getStudioParameter("frontbankpower"), 
		  getStudioParameter("frontbankdist"), 	
		  getStudioParameter("frontbankangle"), 
		  getStudioParameter("frontbankheight"), 
	
		  getStudioParameter("toplightflag"), 	
		  getStudioParameter("toplightpower"),
		  getStudioParameter("groundflag")
		  };
		  return  data;
	  }
	void	StudioLightConfigure	(float[] data ) {
		setStudioParameter("studiolightsflag", data[0]);
		setStudioParameter("limboflag", data[1]);
	
		setStudioParameter("leftbankflag", data[2]);
		setStudioParameter("leftbankpower", data[3]);
		setStudioParameter("leftbankdist", data[4]);
		setStudioParameter("leftbankangle", data[5]);
		setStudioParameter("leftbankheight", data[6]);
	
		setStudioParameter("rightbankflag", data[7]);
		setStudioParameter("rightbankpower", data[8]);
		setStudioParameter("rightbankdist", data[9]);
		setStudioParameter("rightbankangle", data[10]);
		setStudioParameter("rightbankheight", data[11]);
	
		setStudioParameter("frontbankflag", data[12]);
		setStudioParameter("frontbankpower", data[13]);
		setStudioParameter("frontbankdist", data[14]);
		setStudioParameter("frontbankangle", data[15]);
		setStudioParameter("frontbankheight", data[16]);
	
		setStudioParameter("toplightflag", 	data[17]);
		setStudioParameter("toplightpower", data[18]);
		setStudioParameter("groundflag", data[19]);
	
		controlP5.controller("studiolightsmenu").setValue(1);
		
	  }
	
	void 	setLeftPower(float v) {
		setStudioParameter("leftbankpower", v);
	  }
	void 	setRightPower(float v) {
		setStudioParameter("rightbankpower", v);
	  }
	void 	setFrontPower(float v) {
		setStudioParameter("frontbankpower", v);
	  }
	void 	setTopPower(float v) {
		setStudioParameter("toplightpower", v);
	  }
	void 	setLimboColor(int c) {
		studiolimbo.setColor(c);
		studioground.setShaderColor(c);
	  }
	  
	void 	setLimboVisible(boolean f) {
		setStudioParameter("limboflag", f?1:0);
	}
	void 	setGroundVisible(boolean f) {
		setStudioParameter("studioground", f?1:0);
	}
	void	setVisible(boolean flag){
		 if (flag)palette.show();
		 else palette.hide();
	}

  //------------------------------------------------------------------
  // STUDIO LIGHTS EVENTS
  //------------------------------------------------------------------
  	public void controlEvent(ControlEvent theEvent) {
    Controller item		=theEvent.controller();
    String selected		=theEvent.name();
    float value 		=item.value();
    boolean flag		=value>0;
    
    if (selected=="studiolightsflag") {
		item.setLabel((flag)?"lights on":"lights off");
		active=flag;
		
	 	// enable/disable controllers
	 	Enable(flag);
		
      	if (active) 
    	{
    		setStudioParameter("leftbankflag", lightsstatus[0]);
    		setStudioParameter("rightbankflag",lightsstatus[1]);
    		setStudioParameter("frontbankflag",lightsstatus[2]);
    		setStudioParameter("toplightflag", lightsstatus[3]);
		} 
		else
    	{
			lightsstatus[0]=getStudioParameter("leftbankflag");
			lightsstatus[1]=getStudioParameter("rightbankflag");
			lightsstatus[2]=getStudioParameter("frontbankflag");
			lightsstatus[3]=getStudioParameter("toplightflag");
			
			setStudioParameter("leftbankflag", 0);
			setStudioParameter("rightbankflag", 0);
			setStudioParameter("frontbankflag", 0);
			setStudioParameter("toplightflag", 0);
    	}
    }
    if (selected=="limboflag" ) {
		  item.setLabel((flag)?"limbo on":"limbo off");
		  studiolimbo.setVisible(flag);
	}
	if (selected=="groundflag" ) {
		  item.setLabel((flag)?"ground on":"ground off");
		  studioground.setVisible(flag);
	}
	
	
	if (selected=="toplightflag") 		toplight.setVisible(flag);
	if (selected=="leftbankflag" ) 		leftbank.setStatus(flag);
	if (selected=="rightbankflag")  	rightbank.setStatus(flag);
	if (selected=="frontbankflag" ) 	frontbank.setStatus(flag);
	
    // power
    if (selected=="leftbankpower") 	leftbank.setPower((int)value);
    if (selected=="rightbankpower") rightbank.setPower((int)value);
    if (selected=="frontbankpower") frontbank.setPower((int)value);
    if (selected=="toplightpower")	toplight.setShaderColor(new SunflowColor(value, value, value));
	
    // angle
    if (selected=="leftbankangle"  )	leftbank.setAngle(value);
    if (selected=="rightbankangle" )	rightbank.setAngle(value);	 
    if (selected=="frontbankangle" )	frontbank.setAngle(value);

    // distance
    if (selected=="leftbankdist"  )    leftbank.setDistance(value);
    if (selected=="rightbankdist" )    rightbank.setDistance(value);	 
    if (selected=="frontbankdist" )    frontbank.setDistance(value);	 	 
	
    // height
    if (selected=="leftbankheight"  )	leftbank.setHeigth(value);
    if (selected=="rightbankheight" )	rightbank.setHeigth(value);	 
    if (selected=="frontbankheight" )	frontbank.setHeigth(value);	 
	 
    if (selected=="studioreset" ) {

      setStudioParameter("studiolightsflag", 1);
      setStudioParameter("leftbankflag", 1);
      setStudioParameter("rightbankflag", 1);
      setStudioParameter("frontbankflag", 1);
      setStudioParameter("toplightflag", 0);
      
      setStudioParameter("leftbankpower", 2);
      setStudioParameter("leftbankangle", 270);
      setStudioParameter("leftbankdist", 1500);
      setStudioParameter("leftbankheight", 1500);

      setStudioParameter("rightbankpower", 2);
      setStudioParameter("rightbankangle", 90);
      setStudioParameter("rightbankdist", 1500);
      setStudioParameter("rightbankheight", 1500);

      setStudioParameter("frontbankpower", 4);
      setStudioParameter("frontbankangle", 180);
      setStudioParameter("leftbankdist", 1500);
      setStudioParameter("frontbankheight", 1500);
      setStudioParameter("toplightpower", .1);
    }
    
    
    if (selected=="savedata") 	SaveStudioLights();
    if (selected=="loaddata") 	LoadStudioLights();
    if (selected=="exportdata") {
      float[]data=StudioLightGet();
      println("Studio Lights data:");

      String out=" data [";
      for (int i=0;i<data.length;i++) {
        out+=data[i]+",";
      }
      out=out.substring(1, out.length()-1);
      out+="]";
      println(out);
    }
	
  }
  
}

//------------------------------------------------------------------
//  studio lights Limbo class
//------------------------------------------------------------------
class Limbo {
  int width, heigth, depth;
  int curve, curveres;
  int heigthtmp, depthtmp;
  ArrayList<PVector> profilo;
  Mesh mesh;
  SunflowShader shader;

  Limbo(SunflowShader _shader) {

    width	=6000;
    heigth	=2000;
    depth	=4000;
    curve	=1000;
    curveres=10;
	shader=_shader;

    

    mesh=new Mesh();
    mesh.setShader(shader); 
    mesh.setVisible(false);

    createLimbo();
  }

  void createLimbo() {

    ArrayList<PVector> points=new ArrayList<PVector>();
    heigthtmp	=heigth-curve;
    depthtmp	=depth-curve;
    int r        =curve/2;
    float mx    =width/2;

    //wall
    points.add(new PVector(-mx, heigth, 0));
    points.add(new PVector(mx, heigth, 0));

    // curve
    float grid=90/curveres;
    for (int i=0;i<curveres;i++) {
      float a=radians(i*grid);
      for (int j=0;j<2;j++) {
        PVector pos=new PVector(-mx+width*j, r-r*sin(a), r-r*cos(a));
        points.add(pos);
      }
    }

    // ground
    points.add(new PVector(-mx, 0, depthtmp));
    points.add(new PVector(mx, 0, depthtmp)); 

    // create faces
    ArrayList<int[]> faces=new ArrayList<int[]>();
    for (int i=0;i<points.size()-3;i+=2) {
      int v0=i; 
      int v1=i+1; 
      int v2=i+2;
      int v3=i+3;

      faces.add(new int[] {
        v0, v1, v2
      }
      );
      faces.add(new int[] {
        v1, v3, v2
      }
      );
    }

    // 	arrays for vertex and faces
    float[] vertices=new float[points.size()*3];
    for (int i=0;i<points.size();i++) {
      PVector p=(PVector)points.get(i);
      vertices[3*i+0]=p.x;
      vertices[3*i+1]=p.y;
      vertices[3*i+2]=p.z;
    }

    int[] triangles=new int[faces.size()*3];
    for (int i=0;i<faces.size();i++) {
      int[] p=(int[])faces.get(i);
      triangles[i*3+0]=p[0];
      triangles[i*3+1]=p[1];
      triangles[i*3+2]=p[2];
    }

    
    mesh.setMesh(vertices, triangles);
    mesh.computeVertexNormals();
 	mesh.nodecimate=true;
    mesh.setSmooth(true);
    mesh.setPosition(0, 1, -depthtmp/2);
    ESF.addGeometry("studiolimbo", mesh);
  }

  public void setVisible(boolean flag) {
    mesh.setVisible(flag);
  }
  public boolean isVisible() {
    return mesh.isVisible();
  }
  public void setColor(int c) {
    mesh.setShaderColor(c);
  }
}
//------------------------------------------------------------------
//  studio lights Bank class
//------------------------------------------------------------------
class StudioLightsBank extends SunflowLight {
  public float distance, angle, height, lar, alt;
  public color  lightcolor;
  public MeshLight light;
  public int power;
  public String name;
  public boolean active;


  StudioLightsBank(String _name, float _distance, float _angle, float _height, float _lar, float _alt) {
    super(_name);
    name=_name;


    lightcolor=color(255, 255, 255);
    power=1;

    lar=_lar;
    alt=_alt;


    light=new MeshLight(name, new PVector(0, 0, 0), new PVector(0, 0, 0), lar, alt);  
    light.setPower(power);
    light.setColor(lightcolor);
    light.extra=true;
    ESF.addLight(light);


    setSize(lar, alt);
    setParameters(_distance, _angle, _height);
    setStatus(false);
    setCenter();
  }

  public void setParameters(float _distance, float _angle, float _height) {
    setDistance(_distance);
    setAngle(_angle);
    setHeigth(_height);
    setCenter();
  }


  public void setCenter() {
    float a=radians(angle);
    float x=distance*cos(a);
    float y=height;
    float z=distance*sin(a);
    light.setCenter(new PVector(x, y, z));
  }
  public void setAngle(float a) {
    angle=a-90;
    setCenter();
  }
  public void setHeigth(float _height) {
    height=_height;
    setCenter();
  }
  public void setDistance(float _distance) {
    distance=_distance;
    setCenter();
  }
  public void setPower(int v) {
    light.setPower(v);
  }
  public void setStatus(boolean b) {
    active=b;
    light.setVisible(b);
  }

  public void setColor(color c) {
    light.setColor(c);
  }
  public void setTarget(PVector p) {
    light.setTarget(p);
  }
  public void setSize(float w, float h) {
    light.setSize(w, h);
  }

  public float getPower() {
    return light.getPower();
  }
  public float getDistance() {
    return distance;
  }
  public float getAngle() {
    return angle;
  }
  public float getHeigth() {
    return height;
  }

  boolean  getStatus() {
    return active;
  }

  public void draw() {
    if (!isVisible())return;
  }
}