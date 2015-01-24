import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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

public class drawVerticalLineStrip extends PApplet {






Surface s;
int[]  colors= { -23142912, -18415604, -18088052, -16813052, -16859606, -24200991, -19600897, -17435660};
int resolution=80;
int cnt;

public void setup(){
  size(400,300,OPENGL);
  s=new DoubleCone(g,resolution,resolution);
  noStroke();
  smooth();
}

public void draw(){
  background(0xffFFF9D1);
  lights();

  translate(width/2,height/2);
  rotateX(radians(frameCount));
  rotateY(radians(frameCount));
  rotateZ(radians(frameCount));
  s.setScale((mouseX));
  
  for(int i=0;i<resolution;i+=2){
    stroke(colors[(i/2)%colors.length]);
    s.drawVerticalLineStrip(i);
  }
}


public void keyPressed(){
  cnt++;
  if(cnt>14)cnt=0;
  switch (cnt){
  case 0 : 
    s= new DoubleCone(g,resolution,resolution); 
    break;
  case 1 : 
    s= new EnnepersSurface(g,resolution,resolution); 
    break;
  case 2 : 
    s= new FishSurface(g,resolution,resolution); 
    break;
  case 3 : 
    s= new Horn(g,resolution,resolution); 
    break;
  case 4 : 
    s= new JetSurface(g,resolution,resolution); 
    break;
  case 5 : 
    s= new MoebiusStrip(g,resolution,resolution); 
    break;
  case 6 : 
    s= new Pillow(g,resolution,resolution); 
    break;
  case 7 : 
    s= new Shell(g,resolution,resolution); 
    break;
  case 8 : 
    s= new SnailSurface(g,resolution,resolution); 
    break;
  case 9 : 
    s= new Sphere(g,resolution,resolution); 
    break;
  case 10 : 
    s= new Spring(g,resolution,resolution); 
    break;
  case 11 : 
    s= new SuperShape(g,resolution,resolution); 
    break;
  case 12 : 
    s= new TearDrop(g,resolution,resolution); 
    break;
  case 13 : 
    s= new TetrahedralEllipse(g,resolution,resolution); 
    break;
  case 14 : 
    s= new WhitneyUmbrella(g,resolution,resolution); 
    break;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "drawVerticalLineStrip" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
