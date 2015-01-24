import povexport.ui.arcball.*;
import povexport.ui.*;
import povexport.*;
import povexport.povwriter.*;

PovExporter export;
ArcBall arcball;

Sponge sponge;
void setup() {
  size(600, 600, P3D);
  export = new PovExporter(this);
  arcball = new ArcBall(this);
  noStroke();
  sponge = new Sponge(width/2);
  export.createIniFile(dataPath("menger.ini"));  // default is MEDIUM quality
}

void draw() {
  if (export.traced()) { // begin tracing
    display();
  } 
  else { 
    background(0xff66c0ff); 
    lights();        // lights should be outside the record loop
    ambientLight(100, 100, 100);    
    export.beginRaw(dataPath("menger.pov"));
    sponge.render();
    export.endRaw();  //end tracing
  }  
}

void display() {
  background(loadImage(dataPath("menger.png"), "png"));
}
