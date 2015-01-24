
//------------------------------------------------------------------
//  Timeline Class
//------------------------------------------------------------------
public class Timeline  implements ControlListener {

  //----------------------------------------------------------------
  //  Constant
  //----------------------------------------------------------------
  int FPS=25;
  int Seconds=10;

  //----------------------------------------------------------------
  //  Properties
  //----------------------------------------------------------------

  PApplet 	applet;
  int			_timeline_first;
  int			_timeline_end;
  public int	_timeline_now;
  boolean		active;
  boolean 	renderflag; 
  boolean 	repeatflag; 

  Slider slidertimeline;
  Button startbtn;
  Object obj_;
  String function_;
  ArrayList animatorlist;


  // constructor
  Timeline(PApplet applet) {
    this.applet=applet;

    _timeline_first=1;
    _timeline_end=TimeCodeToFrames("00:00:10:00");
    _timeline_now=0;
    active=false;
    renderflag=false;
    repeatflag=false;

    function_=null;
    animatorlist =new ArrayList();


    ControlGroup menu_timeline = controlP5.addGroup("menu_timeline", 0, 0, AppletW);
    menu_timeline.setBackgroundHeight(30); 
    menu_timeline.setBackgroundColor(color(20));
    menu_timeline.hideBar();
    menu_timeline.setPosition(0, AppletH-50); 

    slidertimeline=controlP5.addSlider("_timeline_", 1, 100);
    slidertimeline.setMoveable(false);
    slidertimeline.addListener(this);
    slidertimeline.setLabel(null);
    slidertimeline.setSize(AppletW-100, 20);
    slidertimeline.setPosition(0, 4); 
    //slidertimeline.setColorBackground(color(40));
    //slidertimeline.setColorForeground(color(50));
    //slidertimeline.setColorActive(color(60));

    slidertimeline.setGroup(menu_timeline);
    slidertimeline.valueLabel().style().marginLeft= 5; 

    startbtn = controlP5.addButton("startBtn", 1, AppletW-90, 2, 24, 24);
    startbtn.setImages(loadImage("play_off.png"), loadImage("play_on.png"), loadImage("play_on.png")); 
    startbtn.updateSize();
    startbtn.setSwitch(true);
    startbtn.addListener(this);
    startbtn.setColorBackground(color(0));
    startbtn.setGroup(menu_timeline);

    Button pausebtn = controlP5.addButton("pauseBtn", 2, AppletW-60, 2, 24, 24);
    pausebtn.setImages(loadImage("pause_off.png"), loadImage("pause_on.png"), null); 
    pausebtn.updateSize();
    pausebtn.addListener(this);
    pausebtn.setColorBackground(color(0));
    pausebtn.setGroup(menu_timeline);

    Button stopbtn = controlP5.addButton("stopBtn", 3, AppletW-30, 2, 32, 32);
    stopbtn.setImages(loadImage("stop_off.png"), loadImage("stop_on.png"), null); 
    stopbtn.updateSize();
    stopbtn.addListener(this);
    stopbtn.setColorBackground(color(0));
    stopbtn.setGroup(menu_timeline);
  }
  
  public void 	addAnimator (Animator a) {
    animatorlist.add(a);
  }
  private void 	updateInfoTimeline() {
    guiMessage("FRAME: "+Zerofill4(_timeline_now)+" / "+_timeline_end+"  TIMECODE: "+FramesToTimecode(_timeline_now));
  } 
  public int  	TimeCodeToFrames(String timecode) {


    timecode=timecode.trim();

    String[] items = timecode.split(":");

    String hrsstr	=items[0];
    String minstr	=items[1];
    String secstr	=items[2];
    String frmstr	=items[3];



    int hrsint=Integer.parseInt(hrsstr);
    int minint=Integer.parseInt(minstr);
    int secint=Integer.parseInt(secstr);
    int frmint=Integer.parseInt(frmstr);

    int hrstoframe=hrsint*3600*FPS;
    int mintoframe=minint*60*FPS;
    int sectoframe=secint*FPS;

    int totalframes=hrstoframe+mintoframe+sectoframe+frmint;
    //println(hrsstr+":"+minstr+":"+secstr+":"+frmstr+"= "+totalframes);
    return totalframes;
  }
  public String FramesToTimecode(int framenumber) {

    int seconds = framenumber / FPS;
    int minutes = seconds / 60;
    int hours 	= minutes / 60;

    int frames 	= framenumber % FPS;
    seconds = seconds % 60;
    minutes = minutes % 60;
    hours 	= hours % 24;

    String FramesStr=str(frames);
    String SecsStr=str(seconds);
    String MinsStr=str(minutes);
    String HrsStr=str(hours);

    String FramesFinalStr=(FramesStr.length()==1)?"0"+FramesStr:FramesStr;
    String SecsFinalStr=(SecsStr.length()==1)?"0"+SecsStr:SecsStr;
    String MinsFinalStr=(MinsStr.length()==1)?"0"+MinsStr:MinsStr;
    String HrsFinalStr=(HrsStr.length()==1)?"0"+HrsStr:HrsStr;

    return  HrsFinalStr + ":" + MinsFinalStr + ":" + SecsFinalStr + ":" + FramesFinalStr;
  }


  //------------------------------------------------------------------
  //  GETTER/SETTER
  //------------------------------------------------------------------

  public 	void setRange(int first, int end) {
    setEnd(end);
    slidertimeline.setMin(1);
    slidertimeline.setMax(end);
    updateInfoTimeline();
  }
  public 	void setDuration(String timecode) {
    int end=TimeCodeToFrames(timecode);
    setEnd(end);
    slidertimeline.setMin(1);
    slidertimeline.setMax(end);
    updateInfoTimeline();
  }
  public	void setFPS(int n) {
    FPS=n;
  }
  public	void setEnd(int n) {
    _timeline_end=n;
  } 
  public	int getEnd() {
    return _timeline_end;
  }
  public	int getNow() {
    return _timeline_now;
  } 
  public 	float getPercent() {
    return (float)_timeline_now/_timeline_end;
  }  
  boolean 	isActive() {
    return active;
  }
  public void setRepeat(boolean flag) {
    repeatflag=flag;
  }
  public boolean isLoop() {
    return repeatflag;
  }

  //------------------------------------------------------------------
  public void controlEvent(ControlEvent theEvent) {
    Controller selected=theEvent.controller();

    if (selected.name()=="startBtn") {
      Start();
      return;
    }
    if (selected.name()=="pauseBtn") {
      Pause();
      return;
    }
    if (selected.name()=="stopBtn") {

      Stop();
      return;
    }
    if (selected.name()=="_timeline_") {
      int frame = (int)selected.value();
      _timeline_now=frame;
      // animators
      for (Iterator<Animator> itr = animatorlist.iterator(); itr.hasNext(); ) {
        Animator item = itr.next();
        if (item.HasKeyframes()) item.update(frame);
      }   	 

      selected.setValueLabel(str(frame));
      updateInfoTimeline();
    }
  }
  public void Start() {
    active=true;
    //if (ESF.getRenderAnimation()==true) slidertimeline.setColorForeground(gui_activecolor);
    //else slidertimeline.setColorForeground(color(50));
  }
  public void Pause() {
    startbtn.setOff();
    active=false;
  }
  public void Stop() {
    startbtn.setOff();

    _timeline_now=0;
    slidertimeline.changeValue(_timeline_now);
    active=false;
  }
  public void Loop() {

   
    if (!ESF.getRenderProgress() && isActive()) {


      // if active render animation
      if (ESF.getRenderAnimation()) {
        String path="/render/frame_"+Zerofill4(_timeline_now)+ESF.getImageFormat();
        ESF.RenderToFile(sketchPath(path));
      }

      if (isActive()) slidertimeline.changeValue(_timeline_now);
      updateInfoTimeline();

      // at the end
      if (_timeline_now >=_timeline_end) {

        if (!repeatflag) 
        {
          Pause();
        }
        else {
          Stop();
          Start();
        }
      }
      _timeline_now++;
    }
    
     if (ESF.getRenderAnimation()) {
     
      stroke(255, 0, 0,80);
      strokeWeight(4);
      float yp=slidertimeline.absolutePosition().y+18;
      line(0, yp, slidertimeline.getWidth(), yp);
      
      strokeWeight(1);
    }
    
    
  }
  void showKeyFrames() {

    int maxAnimator=animatorlist.size();
    float step=20f/maxAnimator;
    float posy=slidertimeline.absolutePosition().y;

    strokeWeight(1);
    int id=0;
    for (Iterator<Animator> itr = animatorlist.iterator(); itr.hasNext(); ) {
      Animator item = itr.next();
      if (item.HasKeyframes()) {


        int keys1=item.getFirstFrame();
        int keys2=item.getLastFrame();

        color c=color(posy%250, 100, 0);

        float x0=(float)keys1/_timeline_end*slidertimeline.getWidth();
        float x1=(float)keys2/_timeline_end*slidertimeline.getWidth();

        //stroke(x0%250,x1%250,posy%250,70);
        //stroke(50+id*50/maxAnimator);
        stroke(30 );
        line(x0, posy, x1, posy);


        stroke(128);
        int[] frames=item.getAllKeyFrames();
        for (int i=0;i<frames.length;i++) {

          float x=(float)frames[i]/_timeline_end*slidertimeline.getWidth();
          point(x, posy+1);
        }



        id++;

        posy+=step;
      }
    }
  }
}

//------------------------------------------------------------------
//  KeyFrame Class
//------------------------------------------------------------------
public class KeyFrame<T> implements Comparable<KeyFrame> {

  public int 	frame;
  public T 	value; 

  public KeyFrame(int _frame, T _value) {
    this.frame=(int)_frame;
    this.value=_value;
  }
  public int compareTo(KeyFrame f) {
    return  (frame-f.frame);
  }
}

//------------------------------------------------------------------
//  Animator Class
//------------------------------------------------------------------
public class Animator {

  public final String LINEAR_INTERPOLATION ="linear";
  public final String COSINE_INTERPOLATION ="cosine";
  public final String SIGMOID_INTERPOLATION ="sigmoid";

  public Object obj;
  public String field;
  public ArrayList keyframes;
  ArrayList interpolation;
  int valueType=1;
  int lastframe=-1;
  String interpolationType=COSINE_INTERPOLATION;


  public Animator(Object _obj, String _field) {
    this.obj=_obj;
    this.field=_field;
    this.keyframes=new ArrayList();
    
  }
  public void Interpolate() {

    if (!HasKeyframes()) {
      guiConsole("Animator : error-> no keyframe found");
      return;
    }

    // 	keyframes range
    int n=keyframes.size();
    KeyFrame f1=(KeyFrame)keyframes.get(0);
    KeyFrame f2=(KeyFrame)keyframes.get(n-1);
    int range=f2.frame-f1.frame;


    // calculate interpolation
    interpolation=new ArrayList();
    int id=0;
    for (int i=1;i<n;i++) {

      f1=(KeyFrame)keyframes.get(i-1);
      f2=(KeyFrame)keyframes.get(i);
      int partialrange=f2.frame-f1.frame;
      float step=1.0/(partialrange-1);

      // 
      if (f1.value instanceof Float  ) 			valueType=1;
      if (f1.value instanceof Integer ) 		valueType=2;
      if (f1.value instanceof Point3  ) 		valueType=3;
      if (f1.value instanceof PVector ) 		valueType=4;
      if (f1.value instanceof SunflowColor ) 	valueType=5;

		//guiConsole("Animator :field="+field+", value="+ f1.value.getClass());
	   

      float x, y, z;
      for (float t = 0; t<=1.0; t += step) {

        switch (valueType) {
          case (1):
          float v1=(Float)f1.value;
          float v2=(Float)f2.value;
          interpolation.add(InterpotaleWithMethod(v1, v2, t));
          break;

          case (2):
          
          int i1=new Integer((Integer)f1.value);
          int i2=new Integer((Integer)f2.value);
          interpolation.add((int)InterpotaleWithMethod(i1, i2, t));
          break;

          case (3):
          Point3 p1=(Point3)f1.value;
          Point3 p2=(Point3)f2.value;
          x=InterpotaleWithMethod(p1.x, p2.x, t);
          y=InterpotaleWithMethod(p1.y, p2.y, t);
          z=InterpotaleWithMethod(p1.z, p2.z, t);
          interpolation.add(new Point3(x, y, z));

          break;
          case (4):
          PVector pv1=(PVector)f1.value;
          PVector pv2=(PVector)f2.value;
          x=InterpotaleWithMethod(pv1.x, pv2.x, t);
          y=InterpotaleWithMethod(pv1.y, pv2.y, t);
          z=InterpotaleWithMethod(pv1.z, pv2.z, t);
          interpolation.add(new PVector(x, y, z));

          break;
          case (5):
          // interpolate SunflowColor
          int c1= ((SunflowColor)f1.value).toColor();
          int c2= ((SunflowColor)f2.value).toColor();
          interpolation.add(lerpColor( c1, c2, t));
          
          
          
          break;

        default:
          break;
        }


        id++;
      }

    }
  } 

  float InterpotaleWithMethod(float v1, float v2, float t) {
    float value=0;
    if (interpolationType=="linear") 	value= Linear_interpolate(v1, v2, t);
    if (interpolationType=="cosine") 	value= Cosine_Interpolate(v1, v2, t);
    if (interpolationType=="sigmoid") 	value= SigmoidInterpolation(v1, v2, t);
    return value;
  }

  public void addKeyFrame(int _frame, Object _value) {


	if (_frame==lastframe) _frame+=25;
    keyframes.add(new KeyFrame(_frame, _value));
	lastframe=_frame;
	
    if (keyframes.size()>1) {
      Collections.sort(keyframes);
      Interpolate();
    }
    
    
    
  } 
  public ArrayList getKeyFrames() {
    return keyframes;
  } 
  public int getKeyframesNum() {
    return keyframes.size();
  } 
  public int getFirstFrame() {
    KeyFrame frame=(KeyFrame)keyframes.get(0);
    return frame.frame;
  } 
  public int getLastFrame() {
    KeyFrame frame=(KeyFrame)keyframes.get(keyframes.size()-1);
    return frame.frame;
  } 
  public int[] getAllKeyFrames() {
    int[] frames = new int[keyframes.size()];
    for (int i=0;i<keyframes.size();i++) {
      KeyFrame f=(KeyFrame)keyframes.get(i);
      frames[i]=f.frame;
    }
    return frames;
  } 

  float getInterpolationFloatAt(int frame) {

    int n=keyframes.size()-1;
    KeyFrame f1=(KeyFrame)keyframes.get(0);
    KeyFrame f2=(KeyFrame)keyframes.get(n);
    int range=interpolation.size()-1;
	
    float value=(Float)interpolation.get(0);
    float t=0;

    if ((frame>f1.frame) && (frame<=f2.frame)) {
      t=(float)(frame-f1.frame)/(f2.frame-f1.frame);
    }

    if (frame<=f1.frame) {
      t=0.0;
    }
    if (frame>f2.frame) {
      t=1.0;
    }

    int id =floor(t*range);
    value=(Float)interpolation.get((int)id);
    return value;
  }
   
  int 	getInterpolationIntAt(int frame)		{
   	
   		int n=keyframes.size()-1;
   		KeyFrame f1=(KeyFrame)keyframes.get(0);
   		KeyFrame f2=(KeyFrame)keyframes.get(n);
   		int range=interpolation.size()-1;
   		
   		int value=(Integer)interpolation.get(0);
   		float t=0;
   		
   		if((frame>f1.frame) && (frame<=f2.frame)){
   		t=(float)(frame-f1.frame)/(f2.frame-f1.frame);
   		}
   		
   		if (frame<=f1.frame){
   			t=0.0;
   		}
   		if (frame>f2.frame){
   			t=1.0;
   		}
   		
   		int id =floor(t*range);
   		value=(Integer)interpolation.get((int)id);
   		return value;
   		
   		
   	}
 

  Point3 	getInterpolationPoint3At(int frame) {

    int n=keyframes.size()-1;
    KeyFrame f1=(KeyFrame)keyframes.get(0);
    KeyFrame f2=(KeyFrame)keyframes.get(n);
    int range=interpolation.size()-1;

    Point3 value=new Point3(0, 0, 0);

    if ((frame>f1.frame) && (frame<=f2.frame)) {
      float t=(float)(frame-f1.frame)/(f2.frame-f1.frame);
      int id =floor(t*range);
      value=(Point3)interpolation.get((int)id);
    } 
    if (frame<f1.frame) {
      value=(Point3)interpolation.get(0);
    }
    if (frame>f2.frame) {
      value=(Point3)interpolation.get(range);
    }

    return value;
  }
  PVector 	getInterpolationPVector3At(int frame) {

    int n=keyframes.size()-1;
    KeyFrame f1=(KeyFrame)keyframes.get(0);
    KeyFrame f2=(KeyFrame)keyframes.get(n);
    int range=interpolation.size()-1;

    PVector value=new PVector(0, 0, 0);

    if ((frame>f1.frame) && (frame<=f2.frame)) {
      float t=(float)(frame-f1.frame)/(f2.frame-f1.frame);
      int id =floor(t*range);
      value=(PVector)interpolation.get((int)id);
    } 
    if (frame<f1.frame) {
      value=(PVector)interpolation.get(0);
    }
    if (frame>f2.frame) {
      value=(PVector)interpolation.get(range);
    }

    return value;
  }

  public void 		update(int frame) {
    if (interpolation==null) return;
    switch (valueType) {
      case (1):
      CallMethod(obj, field, getInterpolationFloatAt(frame));
      break;
      case (2):
      CallMethod(obj, field, (int)getInterpolationFloatAt(frame));
      break;			
      case (3):
      CallMethod(obj, field, getInterpolationPoint3At(frame));
      break;
      case (4):
      CallMethod(obj, field, getInterpolationPVector3At(frame));
      break;
      case (5):
      CallMethod(obj, field, (int)getInterpolationIntAt(frame));
      break;

    default:
      break;
    }
  }
  public boolean	HasKeyframes() {
    return keyframes.size()>0;
  }
  public void 		setInterpolationType(String s) {
    interpolationType=s;
    if (keyframes.size()>0) Interpolate();
  }
  public void 		Dump() {
    println ("Animator for: "+field);
    for (Iterator<KeyFrame> itr = keyframes.iterator(); itr.hasNext(); ) {
      KeyFrame item = itr.next();
      println("frame: "+item.frame+" value: "+item.value);
    }
  }



  // interpolation methods
  float Cosine_Interpolate(float v1, float v2, float t) {
    float t2 = (1-cos(t*PI))*.5;
    return (v1*(1-t2)+v2*t2);
  }
  float Linear_interpolate(float v1, float v2, float t) {
    return v1 + (v2 - v1) * t;
  }
  float SigmoidInterpolation(float v1, float v2, float t) {
    float  sharp=(5.0F * .5);
    t = (t * 2.0F - 1.0F) * sharp;
    t = (float)(1.0D / (1.0D + Math.exp(-t)));
    return v1 + (v2 - v1) * t;
  }


  private void CallMethod(Object obj, String name, int value) {
    try {
      Class cl=obj.getClass();

      Class[] parameterType= {
        Integer.TYPE
      };
      Method mthd=cl.getMethod(name, parameterType);

      Integer[] parameters= {
        new Integer(value)
      };
      mthd.invoke(obj, parameters);
    }
    catch (Throwable e) {
      System.err.println(e);
    }
  } 
  private void CallMethod(Object obj, String name, float value) {
    try {

      Class cl=obj.getClass();

      Class[] parameterType= {
        Float.TYPE
      };
      Method mthd=cl.getMethod(name, parameterType);

      Float[] parameters= {
        new Float(value)
      };
      mthd.invoke(obj, parameters);
    }
    catch (Throwable e) {
      System.err.println(e);
    }
  } 
  private void CallMethod(Object obj, String name, Point3 value) {
    try {

      Class cl=obj.getClass();

      Class[] parameterType= {
        value.getClass()
      };
      Method mthd=cl.getMethod(name, parameterType);
      Point3[] parameters= {
        value
      };
      mthd.invoke(obj, parameters);
    }
    catch (Throwable e) {
      System.err.println(e);
    }
  }
  private void CallMethod(Object obj, String name, PVector value) {
    try {

      Class cl=obj.getClass();

      Class[] parameterType= {
        value.getClass()
      };
      Method mthd=cl.getMethod(name, parameterType);
      PVector[] parameters= {
        value
      };
      mthd.invoke(obj, parameters);
    }
    catch (Throwable e) {
      System.err.println(e);
    }
  } 
  private void CallMethod(Object obj, String name) {
    try {
      Class cl=obj.getClass();
      Method mthd=cl.getMethod(name);
      mthd.invoke(obj);
    }
    catch (Throwable e) {
      System.err.println(e);
    }
  } 
  /*
	private void SetFieldValue(Object _object,String _field,float _value)	{
   		try {
   			Class cl=_object.getClass();
   			Field _myField = cl.getDeclaredField(_field);
   			_myField.set(_object,_value); 
   			 
   		 
   		}catch (Throwable e) {
   	 System.err.println(e);
   	}
   	} 
   	*/
}

