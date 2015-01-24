//---------------------------------------------------
//	GUI PARAMETERS
//---------------------------------------------------
int MENU_WIDTH		=150;
int	MENU_HEIGHT	=300;
int	MENU_SPACE	=1; 

color gui_backcolor	=color(60, 65, 70);
color gui_forecolor	=color(120, 120, 120);
color gui_activecolor	=color(120, 120, 120);
color gui_valuecolor	=color(200, 200, 200);
color gui_labelcolor 	=color(150, 150, 150);
color gui_palettebgcolor=color(0, 200);

int idlabel		=1;
int menupos		=1;
boolean initflag		=false;
String currentMessage	="";
String lastmessage	="";
int spheredetails	=6;
int scenedetailspercent	=1;
int grid_			=2;
int pluginid		=0;
int guipathdiffuse, guipathreflection, guipathrefraction, guipathsamples;
int aosamples, igisamples, fieldofview, overridesample, overridedistance;
int leftbankpower, rightbankpower, frontbankpower;
int numsunlongitude,numsunlatitude;

//--------------------------------------------------
//	GUI VARIABLES
//--------------------------------------------------
ControlGroup menu_display;
ControlGroup menu_render;
ControlGroup menu_sunsky;
ControlGroup menu_view;
ControlGroup menu_gi;
ControlGroup menu_camera;
ControlGroup menu_plugin;

ControlGroup gsunsky, gipath, giao, giinstant, gioverride;
Textlabel message;
ArrayList themeColor;
Textarea help;

//--------------------------------------------------
//  THEMES  MANAGER
//--------------------------------------------------
void guiThemesCreate() {

  // 	green
  //--------------------------------------------------
  Theme palette1= new Theme();
  palette1.setBackGround(color(60, 63, 60));
  palette1.setPaletteBackGround(color(0, 30));
  palette1.setValuecolor(color(250, 250, 250));
  palette1.setLabelcolor(color(200, 200, 200));
  palette1.setForegcolor(color(0, 180, 140));
  palette1.setActivecolor(color(0, 180, 140));

  // 	magenta
  //--------------------------------------------------
  Theme palette2= new Theme();
  palette2.setBackGround(color(70, 70, 70));
  palette2.setPaletteBackGround(color(0, 200));
  palette2.setValuecolor(color(250, 250, 250));
  palette2.setLabelcolor(color(200, 200, 200));
  palette2.setForegcolor(color(230, 20, 125));
  palette2.setActivecolor(color(230, 20, 125));

  // 	blue
  //--------------------------------------------------
  Theme palette3= new Theme();
  palette3.setBackGround(color(60, 65, 70));
  palette3.setPaletteBackGround(color(10, 200));
  palette3.setValuecolor(color(250, 250, 250));
  palette3.setLabelcolor(color(200, 200, 200));
  palette3.setForegcolor(color(0, 90, 200));
  palette3.setActivecolor(color(0, 90, 200));

  // 	orange
  //--------------------------------------------------
  Theme palette4= new Theme();
  palette4.setBackGround(color(80, 80, 80));
  palette4.setPaletteBackGround(color(0, 180));
  palette4.setValuecolor(color(250, 250, 250));
  palette4.setLabelcolor(color(200, 200, 200));
  palette4.setForegcolor(color(220, 70, 30));
  palette4.setActivecolor(color(220, 70, 30));

  // 	sky
  //--------------------------------------------------
  Theme palette5= new Theme();
  palette5.setBackGround(color(60, 65, 70));
  palette5.setPaletteBackGround(color(20, 25, 29, 240));
  palette5.setValuecolor(color(250, 250, 250));
  palette5.setLabelcolor(color(200, 200, 200));
  palette5.setForegcolor(color(123, 140, 165));
  palette5.setActivecolor(color(90, 130, 190));

  // 	metallic 
  //--------------------------------------------------

  Theme palette6= new Theme();
  palette6.setBackGround(color(60, 65, 70));
  palette6.setPaletteBackGround(color(0, 220));
  palette6.setValuecolor(color(200));
  palette6.setLabelcolor(color(140));
  palette6.setForegcolor(color(120));
  palette6.setActivecolor(color(120, 120, 120));

  // 	white 
  //--------------------------------------------------
  Theme palette7= new Theme();
  palette7.setBackGround(color(160, 165, 170));
  palette7.setPaletteBackGround(color(250, 220));
  palette7.setValuecolor(color(10));
  palette7.setLabelcolor(color(50));
  palette7.setForegcolor(color(250));
  palette7.setActivecolor(color(100));
  palette7.setStageBackGround(color(170));

  // 	white 
  //--------------------------------------------------
  Theme palette8= new Theme();
  palette8.setStageBackGround(color(50, 55, 64));
  palette8.setBackGround(color(180));
  palette8.setPaletteBackGround(color(220, 220));
  palette8.setValuecolor(color(0));
  palette8.setLabelcolor(color(10));
  palette8.setForegcolor(color(250));
  palette8.setActivecolor(color(255));

  themeColor=new ArrayList();
  themeColor.add(palette1);
  themeColor.add(palette2);
  themeColor.add(palette3);
  themeColor.add(palette4);
  themeColor.add(palette5);
  themeColor.add(palette6);
  themeColor.add(palette7);
  themeColor.add(palette8);
}
void guiThemesCreateMenu(int px, int py) {

  if (themeColor==null) return;

  float row=0;
  int col=0;
  for (int i=0;i<themeColor.size();i++) {

    Bang btn=controlP5.addBang("theme"+i, px+22*col, (int)(py+10*row), 20, 8);
    btn.setGroup(menu_display);
    btn.setLabelVisible(false);

    col=(col+1)%4;
    row=round(i/5f);
  }
  guiThemesUpdateMenu();
}
void guiThemesUpdateMenu() {
  if (themeColor==null) return;
  for (int i=0;i<themeColor.size();i++) {
    Controller btn=controlP5.controller("theme"+i);
    Theme list=(Theme)themeColor.get(i);
    color c=list.getActivecolor();
    btn.setColorForeground(color(red(c)-30, green(c)-30, blue(c)-30));
    btn.setColorActive(c);
  }
}
void guiThemesSet(int n) {
  if (themeColor==null) return;
  Theme c=(Theme)themeColor.get(min(max(n, 0), themeColor.size()-1));

  backgroundcolor 	=c.getStageBackGround();
  gui_palettebgcolor	=c.getPaletteBackGround();
  gui_backcolor		=c.getBackGround();
  gui_forecolor		=c.getForegcolor();
  gui_activecolor		=c.getActivecolor();
  gui_valuecolor		=c.getValuecolor();
  gui_labelcolor		=c.getLabelcolor();

  // upade colors for gui 
  guiSetColors();

  // update menus background
  if (menu_display!=null)	menu_display.setBackgroundColor(gui_palettebgcolor);
  if (menu_render!=null)	menu_render.setBackgroundColor(gui_palettebgcolor);
  if (menu_sunsky!=null)	menu_sunsky.setBackgroundColor(gui_palettebgcolor);
  if (menu_view!=null)		menu_view.setBackgroundColor(gui_palettebgcolor);
  if (menu_gi!=null)		menu_gi.setBackgroundColor(gui_palettebgcolor);
  if (menu_camera!=null)	menu_camera.setBackgroundColor(gui_palettebgcolor);
  if (menu_plugin!=null)	menu_plugin.setBackgroundColor(gui_palettebgcolor);
  if (help!=null) {
    help.setColorBackground(0x00ff0000);
    help.setColor(0x888888);
  }
}
void guiThemesSelect(String selected) {

  if (themeColor==null) return;

  for (int i=0;i<themeColor.size();i++) {
    if (selected.equals("theme"+i)) {
      guiThemesSet(i);
      guiThemesUpdateMenu();
      continue;
    }
  }
}

//--------------------------------------------------
//	MENUS
//--------------------------------------------------
void 	initApplicationGUI() {
  menupos=MENU_SPACE;
  g3 = (PGraphics3D)g;
  controlP5.setAutoDraw(false);
  controlP5.setMoveable(false);

  //default colors 
  guiSetColors();


  guiThemesCreate();
  // choose colors theme 
  guiThemesSet(4);

  guiMenuDisplay();
  guiMenuLights();
  guiMenuRender();
  guiMenuGI();
  guiMenuCamera();
  guiMenuView();
  guiMenuPlugIn();
  guiToolBar();
  guiHelpMenu();
  guiResetDefault();
 
	

  initflag=true;
}
void 	guiSetColors() {
  controlP5.setColorBackground(gui_backcolor);
  controlP5.setColorForeground(gui_forecolor);
  controlP5.setColorActive(gui_activecolor);
  controlP5.setColorValue(gui_valuecolor);
  controlP5.setColorLabel(gui_labelcolor);
}
void    guiMenuDisplay() {

  menu_display=guiCreateMenu("menudisplay", menupos, 20, MENU_WIDTH);

  int px=10;
  int py=20;
  Toggle shadingflag=controlP5.addToggle("shadingflag", px, py, 20, 10);
  shadingflag.setMode(ControlP5.SWITCH);
  shadingflag.setGroup(menu_display); 

  py+=30;
  Toggle axisflag=controlP5.addToggle("axisflag", px, py, 20, 10);
  axisflag.setMode(ControlP5.SWITCH);
  axisflag.setLabel("show axis");
  axisflag.setGroup(menu_display);

  py+=30;
  addLabel(menu_display, "GRID MODE", px, py);
  py+=15;
  controlP5.RadioButton r = controlP5.addRadioButton("grid_", px, py);
  r.setColorLabel(gui_labelcolor);
  r.setItemsPerRow(1); 
  r.setGroup(menu_display);
  addToRadioButton(r, "none", 1);
  addToRadioButton(r, "dot", 2);
  addToRadioButton(r, "line", 3);

  py+=50;
  Slider quality=controlP5.addSlider("spheredetails", 1, 30, spheredetails, px, py, 70, 15);
  quality.setLabel("sphere details");
  quality.captionLabel().style().setMarginLeft(-72);
  quality.captionLabel().style().setMarginTop(20);
  quality.setGroup(menu_display);

  py+=40;
  Slider particlesq=controlP5.addSlider("scenedetailspercent", 1, 100, 25, px, py, 70, 15);
  particlesq.setLabel("scene details");
  particlesq.captionLabel().style().setMarginLeft(-72);
  particlesq.captionLabel().style().setMarginTop(20);
  particlesq.setGroup(menu_display);

  py+=50;
  addLabel(menu_display, "GUI COLORS", px, py);
  py+=15;

  guiThemesCreateMenu(10, 250);

  menupos+=MENU_WIDTH+MENU_SPACE;
}
void    guiMenuRender() {

  menu_render=guiCreateMenu("render parameters ", menupos, 20, MENU_WIDTH);

  int px=10;
  int py=10;

  addLabel(menu_render, "PRESETS", px, py);
  py+=15;
  Button b1=controlP5.addButton("renderpresetlow", 1, px, py, 30, 10);
  b1.setLabel("low render");
  b1.setGroup(menu_render);
  b1.captionLabel().style().moveMargin(10, 0, 0, -3);

  Button b2=controlP5.addButton("renderpresethi", 1, px+70, py, 30, 10) ;
  b2.setLabel("high render");
  b2.setGroup(menu_render);
  b2.captionLabel().style().moveMargin(10, 0, 0, -3); 
  py+=30;

  addLabel(menu_render, "ANTIALIASING QUALITY", px, py);
  py+=15;
  controlP5.RadioButton r = controlP5.addRadioButton("aa", px, py);
  r.setColorLabel(gui_labelcolor);
  r.setItemsPerRow(2);
  r.setSpacingColumn(40);
  r.setGroup(menu_render);
  addToRadioButton(r, "fast", 1);
  addToRadioButton(r, "preview", 2);
  addToRadioButton(r, "final", 3);
  addToRadioButton(r, "dof ", 4);


  py+=40;
  addLabel(menu_render, "RENDER MODE", px, py);
  py+=15;
  r = controlP5.addRadioButton("rendermode", px, py);
  r.setColorLabel(gui_labelcolor);
  r.setItemsPerRow(2); 
  r.setSpacingColumn(40);
  addToRadioButton(r, "ipr", 1);
  addToRadioButton(r, "bucklet", 2);
  r.setGroup(menu_render);

  py+=20;
  addLabel(menu_render, "IMAGE SIZE", px, py);
  py+=15;
  r = controlP5.addRadioButton("rendersize", px, py);
  r.setColorLabel(gui_labelcolor);
  r.setGroup(menu_render);
  r.setItemsPerRow(3);
  r.setSpacingColumn(40);
  addToRadioButton(r, "1/1", 1);
  addToRadioButton(r, "1/2", 2);
  addToRadioButton(r, "1/4", 3);
  r.activate(2);

  py+=30;
  addLabel(menu_render, "BACKGROUND", px, py);

  py+=15;
  Toggle alpha=controlP5.addToggle("backgroundflag", px, py, 20, 10);
  alpha.setLabel("background");
  alpha.setMode(ControlP5.SWITCH);
  alpha.setGroup(menu_render);

  py+=40;
  addLabel(menu_render, "ANIMATION", px, py);
  py+=15;
  Toggle rendeanimationflag=controlP5.addToggle("rendeanimationflag", px, py, 20, 10);
  rendeanimationflag.setMode(ControlP5.SWITCH);
  rendeanimationflag.setLabel("render");
  rendeanimationflag.setGroup(menu_render);



  menupos+=MENU_WIDTH+MENU_SPACE;
}
void    guiMenuLights() {

	menu_sunsky=guiCreateMenu("LIGHTS | SUNSKY | IBL", menupos, 20, MENU_WIDTH);
	int px=10;
	int py=10;
	
	addLabel(menu_sunsky, "SUNSKY PARAMETERS", px, py);
	py+=15;
	Toggle sunflag=controlP5.addToggle("sunflag", px, py, 20, 10);
	sunflag.setMode(ControlP5.SWITCH);
	sunflag.setLabel("sunsky");
	sunflag.setGroup(menu_sunsky); 
	
	py=50;
	gsunsky= controlP5.addGroup("gsunsky", px, py, 130);
	
	gsunsky.hideBar();
	//gsunsky.setBarHeight(20);
	//gsunsky.setLabel("sunsky parameters");
	gsunsky.captionLabel().style().marginTop = 3;
	gsunsky.captionLabel().style().marginLeft = 10;
	gsunsky.setGroup(menu_sunsky);
	px=0;
	py=5;
	addLabel(gsunsky, "LONGITUDE", 	px, py);
	addLabel(gsunsky, "LATITUDE", 	px+70, py);
	py+=15;
	Knob sunlongitude = controlP5.addKnob("sunlongitude", 0, 360, 0, px+5, py, 40);
	sunlongitude.setColorForeground(color(255, 255, 255));
	sunlongitude.setDragDirection(Controller.HORIZONTAL);
	sunlongitude.setDisplayStyle( Knob.ELLIPSE);
	sunlongitude.setRange(PI*2);
	sunlongitude.setStartAngle(0);
	sunlongitude.setGroup(gsunsky);
	
	Knob sunlatitude = controlP5.addKnob("sunlatitude", 0, 360, 0, px+70, py, 40);
	sunlatitude.setColorForeground(color(255, 255, 255));
	sunlatitude.setDragDirection(Controller.HORIZONTAL);
	sunlatitude.setDisplayStyle(Knob.LINE);
	sunlatitude.setStartAngle(0);
	sunlatitude.setRange(-PI*2);
	sunlatitude.setGroup(gsunsky);
	
	py+=60;
	Numberbox numsunlongitude = controlP5.addNumberbox("numsunlongitude",0,px+5,py,40,15);
	numsunlongitude.setGroup(gsunsky);
	numsunlongitude.setLabelVisible(false);
	numsunlongitude.captionLabel().setVisible(false);
	
	Numberbox numsunlatitude = controlP5.addNumberbox("numsunlatitude",20,px+70,py,40,15);
	numsunlatitude.setGroup(gsunsky);
	numsunlatitude.captionLabel().setVisible(false);
	
	py+=25;	
	Slider sunturbidity=controlP5.addSlider("sunturbidity", 2.0, 10, 3, px, py, 60, 15);
	sunturbidity.setLabel("turbidity");
	sunturbidity.setColorForeground(gui_activecolor);
	sunturbidity.captionLabel().style().setMarginLeft(-62);
	sunturbidity.captionLabel().style().setMarginTop(20);
	sunturbidity.setGroup(gsunsky); 
	
	Slider sunsamples=controlP5.addSlider("sunsamples", 4, 300, 32, px+70, py, 60, 15);
	sunsamples.setLabel("samples");
	sunsamples.setColorForeground(gui_activecolor);
	sunsamples.captionLabel().style().setMarginLeft(-62);
	sunsamples.captionLabel().style().setMarginTop(20);
	sunsamples.setGroup(gsunsky);
	
	px=10;
	py+=100;	
	addLabel(menu_sunsky, "IMAGE BASED LIGHT", px, py);
	py+=15;
	Toggle iblflag=controlP5.addToggle("iblflag", px, py, 20, 10);
	iblflag.setMode(ControlP5.SWITCH);
	iblflag.setLabel("ibl");
	iblflag.setGroup(menu_sunsky); 
	
	
	py+=30;	
	addLabel(menu_sunsky, "LIGHTS", px, py);
	py+=15;
	Toggle lightsflag=controlP5.addToggle("lightsflag", px, py, 20, 10);
	lightsflag.setMode(ControlP5.SWITCH);
	lightsflag.setLabel("lights flag");
	lightsflag.setGroup(menu_sunsky); 
	
	menupos+=MENU_WIDTH+MENU_SPACE;
	}
void    guiMenuView() {
	
	menu_view=guiCreateMenu("VIEWS", menupos, 20, MENU_WIDTH);
	int px=10;
	int py=10;
	
	addLabel(menu_view, "CAMERA VIEWS", px, py);
	py+=15;
	
	controlP5.RadioButton r = controlP5.addRadioButton("view", px, 25);
	r.setColorLabel(gui_labelcolor);
	r.setGroup(menu_view);
	r.setItemsPerRow(1);
	addToRadioButton(r, "front", 1);
	addToRadioButton(r, "top", 2);
	addToRadioButton(r, "bottom", 3);
	addToRadioButton(r, "right", 4);
	addToRadioButton(r, "left", 5);
	addToRadioButton(r, "iso", 6);
	r.deactivateAll();
	
	
	menupos+=MENU_WIDTH+MENU_SPACE;
}
void    guiMenuGI() {

  menu_gi=guiCreateMenu("global illumination", menupos, 20, MENU_WIDTH);
  int px=10;
  int py=10;


  addLabel(menu_gi, "RENDER OPTIONS", px, py);  
  py+=15;
  controlP5.RadioButton r = controlP5.addRadioButton("gi", px, py);
  r.setColorLabel(gui_labelcolor);
  r.setGroup(menu_gi);
  r.setItemsPerRow(1);

  addToRadioButton(r, "direct", 1);
  addToRadioButton(r, "path tracing", 2);
  addToRadioButton(r, "fake2", 3);
  addToRadioButton(r, "instant gi", 4);
  addToRadioButton(r, "ambient occlusion", 5);
  addToRadioButton(r, "irradiance", 6);
  addToRadioButton(r, "shader override", 7);


  py=150;
  gipath= controlP5.addGroup("gipath", 10, py, 120);
  gipath.setBarHeight(20);
  gipath.setLabel("path tracing");
  gipath.captionLabel().style().marginTop = 6;
  gipath.captionLabel().style().marginLeft = 10;

  px=0;
  py=10;
  addNumberBox(gipath, "guipathdiffuse", "diffusion", 1, 0, py);
  addNumberBox(gipath, "guipathreflection", "reflection", 4, 60, py);
  py+=40;
  addNumberBox(gipath, "guipathrefraction", "refraction", 4, 0, py);
  addNumberBox(gipath, "guipathsamples", "samplse", 32, 60, py);
  gipath.setGroup(menu_gi);
  gipath.setColorValue(color (254, 254, 254));
  gipath.close();

  py=150;
  giao= controlP5.addGroup("giao", 10, py, 120);
  giao.setBarHeight(20);
  giao.setLabel("ambient occlusion");
  giao.captionLabel().style().marginTop = 6;
  giao.captionLabel().style().marginLeft = 10;
  px=0;
  py=10;
  addNumberBox(giao, "aosamples", "samples", 64, 0, py);
  addNumberBox(giao, "aodistance", "distance", 32, 60, py);
  giao.setGroup(menu_gi);
  giao.setColorValue(color (254, 254, 254));
  giao.close();

  py=150;
  giinstant= controlP5.addGroup("giinstant", 10, py, 120);
  giinstant.setBarHeight(20);
  giinstant.setLabel("Instant GI");
  giinstant.captionLabel().style().marginTop = 6;
  giinstant.captionLabel().style().marginLeft = 10;
  addNumberBox(giinstant, "igisamples", "samples", 64, 0, 10);
  giinstant.setGroup(menu_gi);
  giinstant.setColorValue(color (254, 254, 254));


  gioverride= controlP5.addGroup("overrideshader", 10, py, 120);
  gioverride.setBarHeight(20);
  gioverride.setLabel("override shader");
  gioverride.captionLabel().style().marginTop = 6;
  gioverride.captionLabel().style().marginLeft = 10;

  addNumberBox(gioverride, "overridesample", "samples", 64, 0, 10);
  addNumberBox(gioverride, "overridedistance", "distance", 32, 60, 10);
  gioverride.setGroup(menu_gi);
  gioverride.close();



  menupos+=MENU_WIDTH+MENU_SPACE;
}
void    guiMenuCamera() {

  menu_camera=guiCreateMenu("CAMERA", menupos, 20, MENU_WIDTH);
  int px=10;
  int py=10;
  Slider fov=controlP5.addSlider("fieldofview", 1, 90, 60, px, py, 80, 20);
  fov.setLabel("fov");
  fov.setSliderMode(Slider.FLEXIBLE);
  fov.setGroup(menu_camera);

  py+=40;
  addLabel(menu_camera, "CAMERA TYPE", px, py);  
  py+=15;
  controlP5.RadioButton r = controlP5.addRadioButton("cameratype", px, py);
  r.setColorLabel(gui_labelcolor);
  r.setGroup(menu_camera);
  r.setItemsPerRow(2);
	r.setSpacingColumn(40);
	
  addToRadioButton(r, "pinhole", 1);
  addToRadioButton(r, "thinlens", 2);
  addToRadioButton(r, "fisheye", 3);
  addToRadioButton(r, "spherical", 4);

  py=90;
  ControlGroup camthins= controlP5.addGroup("thinlenspar", px, py, 120);
  camthins.hideBar();
  camthins.setLabel("thinlens options");
  camthins.captionLabel().style().marginTop = 0;
  camthins.captionLabel().style().marginLeft = 10;
  camthins.setGroup(menu_camera);

  px=0;
  py=10;
  Slider fd=controlP5.addSlider("focaldistance", 0, 500, 50, px, py, 80, 15);
  fd.setLabel("focal distance");
  fd.captionLabel().style().setMarginLeft(-82);
  fd.captionLabel().style().setMarginTop(15);
  fd.setColorValue(color (254, 254, 254));
  fd.setGroup(camthins);

  controlP5.addBang("setdof", 100, py, 20, 15).setGroup(camthins);
  py+=35;
  Slider lensr=controlP5.addSlider("lensr", 1, 30, 1, px, py, 80, 15);
  lensr.setLabel("lens radius");

  lensr.captionLabel().style().setMarginLeft(-82);
  lensr.captionLabel().style().setMarginTop(15);
  lensr.setGroup(camthins);

	menupos+=MENU_WIDTH+MENU_SPACE;
	
	px=10;
	py=180;
	
	Toggle jitterflag=controlP5.addToggle("cjitterflag", px, py, 20, 10);
  	jitterflag.setMode(ControlP5.SWITCH);
  	jitterflag.setLabel("jitter camera off");
  	jitterflag.setGroup(menu_camera);

	py+=25;
	ControlGroup camaction= controlP5.addGroup("camaction", px, py, 122);
	camaction.hideBar();
	camaction.captionLabel().style().marginTop = 6;
	camaction.captionLabel().style().marginLeft = 10;
	camaction.setGroup(menu_camera);
	camaction.hide();

	Slider ji=controlP5.addSlider("cjitterdetail", 0.001, .5, 0.02, 0, 5, 60, 20);
  	ji.setLabel("detail");
  	ji.captionLabel().style().setMarginLeft(-62);
  	ji.captionLabel().style().setMarginTop(20);
  	ji.setGroup(camaction);
  	
	ji=controlP5.addSlider("cjitteramplitude", 0, 10, 1, 63, 5, 60, 20);
  	ji.setLabel("amplitude");
  	ji.captionLabel().style().setMarginLeft(-62);
  	ji.captionLabel().style().setMarginTop(20);
  	ji.setGroup(camaction);

  	py=260;
  	Toggle cameraflag=controlP5.addToggle("camerapathflag", px, py, 20, 10);
  	cameraflag.setMode(ControlP5.SWITCH);
  	cameraflag.setLabel("show camera path");
  	cameraflag.setGroup(menu_camera);
}
void    guiMenuPlugIn() {
  	menu_plugin=guiCreateMenu("PLUGIN", menupos, 20, MENU_WIDTH);
}
void 	guiToolBar() {

  int px=1;
  int py=height-20;
  MENU_WIDTH=100;
  controlP5.Button b1=controlP5.addButton("rendertoScreen", 1, px, py, MENU_WIDTH, 20);
  b1.setLabel("render to scren");
  b1.setColorActive(color(200, 0, 0));
  px+=MENU_WIDTH+MENU_SPACE;
  b1=controlP5.addButton("rendertoFile", 1, px, py, MENU_WIDTH, 20);
  b1.setLabel("render to file");
  b1.setColorActive(color(200, 0, 0));

  px+=MENU_WIDTH+MENU_SPACE;
  b1=controlP5.addButton("saveimage", 1, px, py, MENU_WIDTH, 20);
  b1.setLabel("save image");
  b1.setColorActive(color(200, 0, 0));

  px+=MENU_WIDTH+MENU_SPACE;
  b1=controlP5.addButton("savecamera", 1, px, py, MENU_WIDTH, 20);
  b1.setLabel("save camera");
  b1.setColorActive(color(200, 0, 0));
  b1.setColorBackground(color(red(gui_backcolor), green(gui_backcolor)+10, blue(gui_backcolor)+10));

  px+=MENU_WIDTH+MENU_SPACE;
  b1=controlP5.addButton("loadcamera", 1, px, py, MENU_WIDTH, 20);
  b1.setLabel("load camera");
  b1.setColorActive(color(200, 0, 0));
  b1.setColorBackground(color(red(gui_backcolor), green(gui_backcolor)+10, blue(gui_backcolor)+10));

  Textlabel version =controlP5.addTextlabel("version", "EASYSUNFLOW V.02", width-130, 7);
  version.setColorValue(color(120)); 

  message = controlP5.addTextlabel("message", "", 0, 0);
  message.setColorValue(color(250));
}
void 	guiResetDefault() {
  guiCloseAllMenu();
   
  //scene
  setGuiParameter("shadingflag",0);
  setGuiParameter("dot",1);
  setGuiParameter("axisflag",1);
  //render
  setGuiParameter("direct",1);
  setGuiParameter("renderpresetlow",1);
  setGuiParameter("rendeanimationflag",0);
  setGuiParameter("backgroundflag",1);
  //sunsky/lights 
  setGuiParameter("sunlatitude",20);
  setGuiParameter("sunlongitude",0);
  setGuiParameter("sunturbidity",3.0);
  
  //camera
  setGuiParameter("pinhole",1);
  setGuiParameter("camerapathflag",0);
  
  
}
void 	guiRedraw() {
  if (!initflag) return;
  
  hint(DISABLE_DEPTH_TEST);
  pushMatrix(); 
  currCameraMatrix = new PMatrix3D(g3.camera);
  

  noLights();
  noStroke(); 
  noSmooth();

  perspective();
  camera();

  fill(gui_backcolor);
  rect(0, 0, width, 20);
  fill(30);
  rect(0, height-30, width, height);

	
  controlP5.draw();
  guiwriteMessage();
  guiShowCameraInfo();
  
  	// timeline
   	if (timeline!=null)  timeline.Loop();
 
  g3.camera = currCameraMatrix;
  popMatrix();
  hint(ENABLE_DEPTH_TEST);
  
  // disable proscene on controlP5
  thescene.disableMouseHandling();
  if (!controlP5.window(this).isMouseOver() ) thescene.enableMouseHandling();
}
void  	guiCloseAllMenu() {

  if (menu_display!=null) 	menu_display.close();
  if (menu_gi!=null) 		menu_gi.close();
  if (menu_render!=null) 	menu_render.close();
  if (menu_camera!=null) 	menu_camera.close();
  if (menu_sunsky!=null) 	menu_sunsky.close();
  if (menu_view!=null) 		menu_view.close();
  if (help!=null) 			help.hide();
  if (menu_plugin!=null) 	menu_plugin.close();
}
void 	guiHelpMenu() {


  int px=MENU_WIDTH*11;
  Button helpbtn = controlP5.addButton("helpbtn", 1, width-25, 2, 16, 16);
  helpbtn.setImages(loadImage("help_icon_off.png"), loadImage("help_icon_on.png"), loadImage("help_icon_on.png")); 

  helpbtn.setSwitch(true);
  help = controlP5.addTextarea("helptxt", "", px, 40, 300, 600);
  help.setColor(0x888888);
  help.setText("easySunflow v0.2\n\nPROSCENE SHORTCUT\nE > PERSPECTIVE/ORTHOGRAPHC\n\nGUI SHORTCUT\nB > CREATE SCENE\nX > CLOSE ALL MENUS\nR > RENDER TO SCREEN\nV > SHOW RENDER WINDOW\nW > WIREFRAME/SHADING\nO > SAVE GUI STATUS\nU > LOAD GUI STATUS\n\nTIMELINE\nSPACE > PLAY/PAUSE ANIMATION\nTAB > STOP ANIMATION\n3 > LOOP ANIMATION\n");
  help.hide();
}
void 	guiAddPlugin(String link, String label, boolean status) {
  Toggle menu =controlP5.addToggle(link, status, 2, 5+21*pluginid, MENU_WIDTH+45, 20);
  menu.setLabel(label);
  menu.captionLabel().style().moveMargin(-17, 0, 0, 12);
  menu.setGroup(menu_plugin); 
  pluginid++;
}
//--------------------------------------------------
//	GUI Events Controller
//--------------------------------------------------
void 	setGuiParameter(String parameter, float v) {
    controlP5.controller(parameter).setValue(v);
}
float	getGuiParameter(String parameter) {
    return controlP5.controller(parameter).value();
}
void 	controlEvent(ControlEvent theEvent) {

  //
  String 	selected=theEvent.name();

  if (theEvent.isGroup()) {
    int value=(int)theEvent.group().value();


    if (selected=="grid_") grid_=value;
    if (selected=="rendermode") {

      switch(value) {
      case 1:
        ESF.setRenderMode("ipr");
        break;
      case 2:
        ESF.setRenderMode("bucklet");
        break;
      }
    }
    if (selected=="rendersize") {
      switch(value) {
      case 1:
        ESF.setScaledOutput(1);
        break;
      case 2:

        ESF.setScaledOutput(2);
        break;
      case 3:

        ESF.setScaledOutput(4);
        break;
      }
    }
    if (selected=="view") {

      switch(value) {
      case 1:
        thecamera.setPosition(new PVector(0, -100, 1000));
        thecamera.lookAt( thecamera.sceneCenter() );
        thecamera.setUpVector(new PVector(0, 1, 0), true);
        break;
      case 2:
        thecamera.setUpVector(new PVector(0, 1, 0), true);
        thecamera.setPosition(new PVector(0, -1500, 1));
        thecamera.lookAt( thecamera.sceneCenter() );
        break;
      case 3:
        thecamera.setUpVector(new PVector(0, 1, 0), true);
        thecamera.setPosition(new PVector(0, 1500, 1));
        thecamera.lookAt( thecamera.sceneCenter() );
        break;
      case 4:
        thecamera.setPosition(new PVector(1000, -100, 0));
        thecamera.lookAt( thecamera.sceneCenter() );
        thecamera.setUpVector(new PVector(0, 1, 0), true);
        break;
      case 5:
        thecamera.setPosition(new PVector(-1000, -100, 0));
        thecamera.lookAt( thecamera.sceneCenter() );
        thecamera.setUpVector(new PVector(0, 1, 0), true);
        break;
      case 6:
        thecamera.setUpVector(new PVector(0, 1, 0), true);
        thecamera.setPosition(new PVector(700, -700, 700));
        thecamera.lookAt( thecamera.sceneCenter() );
        break;
      }
    }		
    if (selected=="gi") {

      // close palette gi
      gipath.hide();
      giao.hide();
      giinstant.hide();
      gioverride.hide();

      switch(value) {
      case 1:
        ESF.setGI_NONE();
        break;
      case 2:
        ESF.setGI_PATHTRACING();
        gipath.show();
        break;
      case 3:
        ESF.setGI_FAKE();
        break;
      case 4:
        ESF.setGI_INSTANT();
        giinstant.show();
        break;
      case 5:
        ESF.setGI_AO();
        giao.show();
        break;
      case 6:
        ESF.setGI_IRRADIANCE();
        break;
      case 7:
        ESF.setSHADEROVERRIDE();
        if (ESF.getOverrideShader().getClass().equals(ShaderAO.class)) gioverride.show();
        break;
      }
    }
    if (selected=="cameratype") {
    
    controlP5.group("thinlenspar").hide();
      switch(value) {
      case 1:
        ESF.setCameraType(ESF.PINHOLE);
        
        break;
      case 2:
        ESF.setCameraType(ESF.THINLENS);
        controlP5.group("thinlenspar").show();
        break;
      case 3:
        ESF.setCameraType(ESF.FISHEYE);
        break;
      case 4:
        ESF.setCameraType(ESF.SPHERICAL);
        break;
      }
    }
    if (selected=="aa") {
      switch(value) {
      case 1:
        ESF.setAA("quick");
        break;
      case 2:
        ESF.setAA("preview");
        break;
      case 3:
        ESF.setAA("final");
        break;
      case 4:
        ESF.setAA("dof");
        break;
      }
    }
  }
  else if (theEvent.isController()) {

	Controller item=theEvent.controller();
    float 	value=item.value();
    boolean flag=value>0;

    guiThemesSelect(selected);

    //display
    if (selected=="spheredetails") sphereDetail(spheredetails);
    if (selected=="shadingflag") {
      item.setLabel((flag)?"shading":"wireframe");
      ESF.setShadingMode(flag);
    }
    if (selected=="axisflag") 			item.setLabel((flag)?"show axis":"hide axis");
    if (selected=="scenedetailspercent")ESF.setSceneDetails(value);
    if (selected=="renderpresetlow") {
    
    	setGuiParameter("fast",1);
    	setGuiParameter("ipr",1);
    	setGuiParameter("1/2",1);

    }
    if (selected=="renderpresethi") {
    	setGuiParameter("final",1);
    	setGuiParameter("bucklet",1);
    	setGuiParameter("1/1",1);
    }

    //lights
    if (selected=="sunflag") {
      item.setLabel((flag)?"sunsky":"no sunsky");

      gsunsky.setVisible(flag);
      ESF.setSunVisible(flag);
    }
    if (selected=="iblflag") {
      item.setLabel((flag)?"ibl":"no ibl");
      ESF.setIBLLightsVisible(flag);
    }
    if (selected=="lightsflag") {
      item.setLabel((flag)?"lights":"no lights");
      ESF.setLightsVisible(flag);
    }

    ///
    // sun
    
    if (selected=="sunlongitude") 		{
    	ESF.thesun.setLongitude(value);
    	controlP5.controller("numsunlongitude").changeValue(value);
    }
    if (selected=="sunlatitude") 		{ 
    	ESF.thesun.setLatitude(value);	
    	controlP5.controller("numsunlatitude").changeValue(value);
    }
    if (selected=="numsunlongitude")  	setGuiParameter("sunlongitude",value);
    if (selected=="numsunlatitude") 	setGuiParameter("sunlatitude",value);
    
    if (selected=="sunturbidity") 		ESF.thesun.setTurbidity(value);
    if (selected=="sunsamples") 		ESF.thesun.setSamples((int)value);

    //render
    if (selected=="backgroundflag") 	item.setLabel((flag)?"background":"alpha");
    if (selected=="rendeanimationflag") {
      item.setLabel((flag)?"render animation":"render frame");
      ESF.setRenderAnimation(flag);
    }
    if (selected=="rendertoScreen") 	ESF.RenderToScreen();
    if (selected=="rendertoFile") 		ESF.RenderToFileProgressive();
    if (selected=="saveimage") 			ESF.SaveImage();

    // camera
    if (selected=="savecamera") 		ESF.SaveCamera();
    if (selected=="loadcamera") 		ESF.LoadCamera();
    if (selected=="fieldofview") {
      ESF.setFov(value);
      
    }
    if (selected=="focaldistance") 		ESF.setCameraFocalDistance(value);
    if (selected=="lensr") 				ESF.setCameraLensRadius(value);
    if (selected=="setdof") {
      	float d=(float)thecamera.distanceToSceneCenter();
      	
      	setGuiParameter("focaldistance",d);
      	controlP5.controller("focaldistance").setMax(d*2);
      	
    }
    if (selected=="camerapathflag") {
      item.setLabel((flag)?"show camera path":"hide camera path");
      camerapathflag=flag;
      thescene.setCameraPathsAreDrawn(camerapathflag);
    }

    // GI
    if (selected=="guipathdiffuse") 	ESF.giPathDiffuse	= (int)value;
    if (selected=="guipathreflection") 	ESF.giPathReflection= (int)value;
    if (selected=="guipathrefraction") 	ESF.giPathRefraction= (int)value;
    if (selected=="guipathsamples") 	ESF.giPathSamples	= (int)value;

    if (selected=="aosamples") 			ESF.giAOSamples		= (int)value;
    if (selected=="aodistance") 		ESF.giAODistance	= (int)value;

    // if shader override is AO 
    if (ESF.getOverrideShader().getClass().equals(ShaderAO.class)) {
      ShaderAO shader=(ShaderAO)ESF.getOverrideShader();
      if (selected=="overridesample") 	shader.setSamples((int)value);
      if (selected=="overridedistance") shader.setDistance((int)value);
    }
    
    if (selected=="helpbtn"  ) {
      if (help.isVisible()) help.hide();
      else help.show();
    }
    
    //camera action
    if (selected=="cjitterflag") 		{
    item.setLabel((flag)?"jitter camera  on":"jitter camera off");
    ESF.ActionCameraSwitch(flag);
    
   	if (flag){
     	controlP5.group("camaction").show();
     }else{
     	controlP5.group("camaction").hide();
     }

    }
    if (selected=="cjitterdetail") 		ESF.setActionCameraParameters(value,getGuiParameter("cjitteramplitude"));	
    if (selected=="cjitteramplitude") 	ESF.setActionCameraParameters(getGuiParameter("cjitterdetail"),value);	
     
  }
}

//--------------------------------------------------
//	utility 
//--------------------------------------------------
ControlGroup guiCreateMenu(String title, int x, int y, int width) {
  ControlGroup menu = controlP5.addGroup(title, x, y, width);
  menu.setBarHeight(20);
  menu.captionLabel().style().marginTop = 6;
  menu.captionLabel().style().marginLeft = 10;
  menu.setBackgroundHeight(MENU_HEIGHT);
  menu.setBackgroundColor(gui_palettebgcolor);
  menu.setMoveable(false);
  return menu;
}
Toggle 	addToRadioButton(RadioButton theRadioButton, String theName, int theValue ) {
  Toggle t = theRadioButton.addItem(theName, theValue);
  t.captionLabel().style().movePadding(2, 0, -1, 2);
  t.captionLabel().style().moveMargin(-2, 0, 0, -3);
  t.captionLabel().style().backgroundWidth = 60;
  return t;
}
void 	addNumberBox(ControlGroup g, String name, String label, int init, int x, int y) {
  Numberbox field= controlP5.addNumberbox(name, init, x, y, 50, 20);
  field.setMin(1);
  field.setLabel(label);
  field.setGroup(g);
}
void 	addLabel(ControlGroup g, String text, int x, int y) {
  Textlabel label = controlP5.addTextlabel("label"+idlabel++, text, x, y);
  label.setColorValue(color(100));
  label.setGroup(g);
}


//--------------------------------------------------
//  GUI WRAPPERS
//--------------------------------------------------
// AXIS/GRID
void Axis(int s) {
  stroke (200, 0, 0);
  line(0, 0, 0, s, 0, 0);
  stroke (0, 200, 0);
  line(0, 0, 0, 0, -s, 0);
  stroke (0, 200, 200);
  line(0, 0, 0, 0, 0, -s);
}
void LineGrid() {
  int d = 3000;
  int s =d/50;
  int m =d/2;
  int col1=(int)toR(backgroundcolor);

  strokeWeight(1);
  pushMatrix(); 
  for (int i =0; i <= d; i += s) {

    if (i%100==0) stroke(col1+30);
    else stroke(col1+10);
    
    line(-m, 0, -m+i, m, 0, -m+i); 
    line(-m+i, 0, -m, -m+i, 0, m);
  }
  popMatrix();
}
void DotGrid() {
  int d = 3000;
  int s =d/50;
  int m =d/2;

  int col1=100;
  int col2=140;

  for (int i =0; i <= d; i += s) {
    for (int j =0; j <= d; j += s) {

      if (i%100==0 && j%100==0) {
        stroke(col2); 
        strokeWeight(2);
      }
      else 
      {
        strokeWeight(1);
        stroke(col1);
      }
      point(-m+j, 0, -m+i);
    }
  }
  strokeWeight(1);
}

void guiShowCameraInfo() {

  String eye="CAMERA POSITION: "+thecamera.position();
  String target="CAMERA AT: "+thecamera.at();
  String orient="CAMERA ORIENTATION: "+thecamera.orientation().eulerAngles();
  
  fill(128);
  textSize(8);
  textMode(SCREEN);
  text(eye+"\n"+target+"\n"+orient, 10, AppletH-80);
}
void guiMessage(String s) {
  currentMessage=s;
}
void guiwriteMessage() { 
 if (currentMessage==lastmessage) return;

  message.setColorValue(color(100));
  message.setValue(currentMessage.toUpperCase()); 
  message.setPosition(530, AppletH-14);

  lastmessage=currentMessage;
}
void guiConsole(String s) {
  System.out.println("easySunflow : "+s);
}

//lights controller
public void	guiSetSunVisible(boolean flag) {
   	setGuiParameter("sunflag",(flag)?1:0);
  
}
public void	guiSetIBLVisible(boolean flag) {
  setGuiParameter("iblflag",(flag)?1:0);
}
public void	guiSetLightsVisible(boolean flag) {
 	setGuiParameter("lightsflag",(flag)?1:0);
}
public void	guiSetStudioLightsVisible(boolean flag) {
 		if (studioLightsPlugIn!=null) studioLightsPlugIn.setVisible(flag);
}

//sun controller
void guiSunPosition(float longitude,float latitude){
	setGuiParameter("sunlongitude",longitude);
	 setGuiParameter("sunlatitude",latitude);
}
void guiSunLongitude(float v) {
  setGuiParameter("sunlongitude",v);
}
void guiSunLatitude(float v) {
  setGuiParameter("sunlatitude",v);
}
void guiSunTurbidity(float v) {
  setGuiParameter("sunturbidity",v);
}
void guiSunsamples(int n) {
  setGuiParameter("sunsamples",n);
}

//scene controller
public void guiSetSceneDetails(float v) {
   setGuiParameter("scenedetailspercent",v);
}
public void	guiSetShadingMode(boolean flag) {
  setGuiParameter("shadingflag",(flag)?1:0);
}
public void	guiSetFOV(float v) {
  setGuiParameter("fieldofview",v);
}

public void	guisetActionCamera(boolean flag){
	setGuiParameter("cjitterflag",(flag)?1:0);
}
public void	guiSetActionCameraParameters(float details,float amplitude) {
  	setGuiParameter("cjitterdetail",details);
  	setGuiParameter("cjitteramplitude",amplitude);
}
public void guiSetCameraOrbitTarget(PVector pos){
	CameraOrbitPlugIn.setTarget(pos);
}
void guiSaveStatus(){
	controlP5.saveProperties(("data/guistatus.txt"));
}
void guiLoadStatus(){
	controlP5.loadProperties(("data/guistatus.txt"));
}
void guisetOverrideShader(){
	 setGuiParameter("shader override",1);
}



//--------------------------------------------------
//  THEMES CLASS
// 	define gui theme colors 
//--------------------------------------------------
class Theme {
  color _stagebackcolor;
  color _palettebackcolor;
  color _backcolor;
  color _forecolor;
  color _activecolor;
  color _valuecolor;
  color _labelcolor;

  Theme() {
    _backcolor=		color(78, 81, 83);
    _forecolor=		color(120, 120,120);
    _activecolor=	color(130, 130,130);
    _valuecolor=	color(250, 250, 250);
    _labelcolor=	color(255, 255, 255);
    _stagebackcolor=	color(50);
    _palettebackcolor=	color(0, 180);
  }

  // Getter Setter
  public void setStageBackGround(color c) {
    _stagebackcolor=c;
  }

  public void setPaletteBackGround(color c) {
    _palettebackcolor=c;
  }

  public void setBackGround(color c) {
    _backcolor=c;
  }
  public void setForegcolor(color c) {
    _forecolor=c;
  }
  public void setActivecolor(color c) {
    _activecolor=c;
  }
  public void setValuecolor(color c) {
    _valuecolor=c;
  }
  public void setLabelcolor(color c) {
    _labelcolor=c;
  }
  //
  public color getStageBackGround() {
    return _stagebackcolor;
  }
  public color getPaletteBackGround() {
    return _palettebackcolor;
  }

  public color getBackGround() {
    return _backcolor;
  }
  public color getForegcolor() {
    return _forecolor;
  }
  public color getActivecolor() {
    return _activecolor;
  }
  public color getValuecolor() {
    return _valuecolor;
  }
  public color getLabelcolor() {
    return _labelcolor;
  }
}


//--------------------------------------------------
// 	PALETTE CLASS
//	create parameters palette
//--------------------------------------------------
public class Palette {

  public ControlP5  gui;
  public ControlWindow palette;
  int backgroundcolor;
  int x, y, lar, alt;
  String name;
  ControlListener myListener; 

  /**
   *  create a Palette
   *
   * @param _controller ControlP5
   * @param _name String
   * @param _x String
   */
  public Palette(ControlP5 _controller, String _name, ControlListener _myListener, int _x, int _y, int _lar, int _alt) {


    myListener=_myListener;
    name=_name;
    gui=_controller;
    x=_x;
    y=_y;
    lar=_lar;
    alt=_alt;
    backgroundcolor= 40;

    palette = gui.addControlWindow(_name, x, y, lar, alt);
    palette.hideCoordinates();
    palette.setTitle(name);
    palette.setBackground(backgroundcolor);
   
    palette.papplet().frame.setAlwaysOnTop(true);
     palette.hide();
  }

  //---------------------------------------------------------------
  public void setBackground(int c) {
    backgroundcolor=c;
    palette.setBackground(backgroundcolor);
  }
  public void setFieldValue(String s, float value) {
    gui.controller(s).setValue(value);
  }
  public float getFieldValue(String s) {
    return gui.controller(s).value();
  }

  /**
   *  add a slider 
   *
   * @param _name String
   */
  public Slider addSlider(String _name, float _min, float _max, float _val, int _x, int _y, int _lar, int _alt) {
    Slider mySlider = gui.addSlider(_name, _min, _max, _val, _x, _y, _lar, _alt);
    mySlider.setWindow(palette);
    mySlider.addListener(myListener);
    return mySlider;
  }

  /**
   *  add a toggle
   * 
   * @param _name String
   */
  public Toggle addToggle(String _name, boolean _type, int _x, int _y, int _lar, int _alt) {
    Toggle myToggle = gui.addToggle(_name, _type, _x, _y, _lar, _alt);
    myToggle.setWindow(palette);
    myToggle.addListener(myListener);
    return myToggle;
  }

  /**
   *  add a button
   * 
   * @param _name String
   */
  public Button addButton(String _name, float _def, int _x, int _y, int _lar, int _alt) {
    Button myButton = gui.addButton(_name, _def, _x, _y, _lar, _alt);
    myButton.setWindow(palette);
    myButton.addListener(myListener);
    return myButton;
  }
  public Bang addBang(String _name, int _x, int _y, int _lar, int _alt) {
    Bang myBang = gui.addBang(_name, _x, _y, _lar, _alt);
    myBang.setWindow(palette);
    myBang.addListener(myListener);
    return myBang;
  }

  /**
   * show palette
   */
  public void show() {
    palette.show();
  }
  /**
   * hide palette
   */
  public void hide() {
    palette.hide();
  }
}