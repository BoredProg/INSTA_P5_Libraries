import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import surface.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class superShapes extends PApplet {



SuperShapes s;
Slider[] sliders;

public void setup(){
  size(400,300,P3D);
  textFont(loadFont("dialog.vlw"));
  s=new SuperShapes(g, 20, 20);
  sliders=new Slider[6];
  sliders[0]=new Slider(20,50,100,10,20,4,55, "vertical Resolution");
  sliders[1]=new Slider(20,90,100,10,20,4,55, "horizontal Resolution");
  sliders[2]=new Slider(20,130,100,10,20,0,20, "n1");
  sliders[3]=new Slider(20,170,100,10,20,0,20, "n2");
  sliders[4]=new Slider(20,210,100,10,20,0,20, "n3");
  sliders[5]=new Slider(20,250,100,10,20,0,20, "m");
}

public void draw(){
  background(255);
  lights();
  boolean moved=false;
  for(int i=0;i<sliders.length;i++){
    fill(200);
    stroke(100);
    sliders[i].update();
    sliders[i].draw();
    if(sliders[i].moved)moved=true;
  }
  if(moved){
    int vResolution=floor(sliders[0].getPos());
    int hResolution=floor(sliders[1].getPos());
    float n1=sliders[2].getPos();
    float n2=sliders[3].getPos();
    float n3=sliders[4].getPos();
    float m=sliders[5].getPos();
    s=new SuperShapes(g, vResolution, hResolution);
    s.setParameter(n1,n2,n3,m,n1,n2,n3,m);
  }
  
  translate(250,150);
  rotateX(radians(frameCount));
  rotateY(radians(frameCount));
  rotateZ(radians(frameCount));
  s.setScale(40);
  
  noStroke();
  fill(0xffA6D3EA);
  
  s.draw();
}
class Slider
{
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;         // x and y position of bar
  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  boolean moved;
  float sLength,vLength, vMin, vMax;
  String label;
  
  Slider (int xp, int yp, int sw, int sh, int l, float mn, float mx, String lb) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    vMin=mn;
    vMax=mx;
    vLength=vMax-vMin;
    sLength=swidth-sheight;
    label=lb;
  }

  public void update() {
    if(over()) {
      over = true;
    } 
    else {
      over = false;
    }
    if(mousePressed && over) {
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
    }
    if(locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if(abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
      moved=true;
    }
    else{
      moved=false;
    }
  }

  public int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  public boolean over() {
    if(mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } 
    else {
      return false;
    }
  }

  public void draw() {
    rectMode(CORNER);
    fill(255);
    rect(xpos, ypos, swidth, sheight);
    if(over || locked) {
      fill(240, 200, 0);
    } 
    else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
    fill(50);
    text(label,xpos,ypos-10);
  }

  public float getPos() {
    return   max(min((vMin+((spos-xpos)*vLength)/sLength),vMax),vMin) ;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "superShapes" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
