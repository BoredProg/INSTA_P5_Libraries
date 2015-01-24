/*
 * This example produces 120 PNGs, which you can convert into a 4 second (30 fps) movie,
 * using Processing's Movie Maker tool (Processing IDE > Tools > Movie Maker, for Processing 2.0 and over).
 * For complete video, visit https://github.com/joonhyublee/joons-renderer/wiki/Example-Sketches#wiki-Animation%20Example
 */

import joons.JoonsRenderer;

JoonsRenderer jr;

//Camera Setting.
float eyeX = 0;
float eyeY = 0;
float eyeZ = 120;
float centerX = 0;
float centerY = 0;
float centerZ = -1;
float upX = 0;
float upY = 1;
float upZ = 0;
float fov = PI / 4; 
float aspect = 1280/720f;  
float zNear = 5;
float zFar = 10000;

int i = 0;
float r = 35;
String fileName;

void setup() {
  size(1280, 720, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("bucket");
  //jr.setSizeMultiplier(4);
  jr.setAA(0,2);
  }

void draw() {
  jr.render(); //The draw() loop that comes right after this method is called is rendered.
  jr.beginRecord(); //Make sure to include things you want rendered.l

  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  perspective(fov, aspect, zNear, zFar);

  jr.background("ambient", 100, 100, 100); //Cornell Box: width, height, depth.
  jr.background("gi_ambient_occlusion"); //Global illumination.

  //Sun.
  translate(0, -15, 0);
  jr.fill("light", 1, 60, 60);
  sphere(5);

  //Planet, revolving at +3 degrees per frame.
  //translate(r*cos(i*3*2*PI/360f), 0, r*sin(i*3*2*PI/360f));
  translate(r*cos(i*0.5*2*PI/360f), 0, r*sin(i*0.5*2*PI/360f));
  jr.fill("mirror");
  sphere(5);

  jr.endRecord(); //Make sure to end record.
  jr.displayRendered(true); //Display rendered image if render is completed, and the argument is true.

  if (i < 10) fileName = "00"+i;
  if (i >= 10 && i < 100) fileName = "0"+i;
  if (i >= 100 && i < 1000) fileName = ""+i;
  saveFrame(fileName+".PNG");

  i++;
  if (i == 720) exit();
}
