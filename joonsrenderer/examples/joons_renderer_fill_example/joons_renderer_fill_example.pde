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
float aspect = 4/3f;  
float zNear = 5;
float zFar = 10000;

void setup() {
  size(800, 600, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("ipr"); //Rendering mode, either "ipr" or "bucket".
  jr.setSizeMultiplier(2); //Set size of PNG file as a multiple of Processing sketch size.
  jr.setAA(-2, 0); //Set anti aliasing, (aaMin, aaMax, aaSamples). aaMin & aaMax = .. -2, -1, .. , 1, 2 ..; aaMin < aaMax.
  jr.setCaustics(10); //Set caustics. 1, 5, 10 .., affects quality of light reflected & refracted through glass.
}

void draw() {
  jr.beginRecord(); //Make sure to include things you want rendered.
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  perspective(fov, aspect, zNear, zFar);

  jr.background(0, 255, 255); //(gray), or (r, g, b), like Processing.
  jr.background("gi_instant"); //Global illumination.
  //jr.background("gi_ambient_occlusion"); //Global illumination, ambient occlusion mode.

  jr.background("cornell_box", 100, 100, 100); //Cornell box, width, height, depth.

  pushMatrix();
  translate(-40, 20, -20);
  pushMatrix();
  rotateY(-PI/8);

  //jr.fill("light", r, g, b);
  jr.fill("light", 5, 5, 5);
  sphere(13);
  translate(27, 0, 0);

  //jr.fill("mirror", r, g, b);    
  jr.fill("mirror", 255, 255, 255);
  sphere(13);
  translate(27, 0, 0);

  //jr.fill("diffuse", r, g, b);
  jr.fill("diffuse", 150, 255, 255);
  sphere(13);
  translate(27, 0, 0);

  //jr.fill("shiny", r, g, b, shininess);
  jr.fill("shiny", 150, 255, 255, 0.1f);
  sphere(13);
  
  translate(27, 0, 0);
  popMatrix();
  rotateY(PI/8);
  translate(-10, -27, 30);

  //jr.fill("ambient_occlusion", bright r, g, b, dark r, g, b, maximum distance, int samples);
  jr.fill("ambient_occlusion", 150, 255, 255, 0, 0, 255, 50, 16);
  sphere(13);
  translate(27, 0, 0);

  //jr.fill("phong", r, g, b);
  jr.fill("phong", 150, 255, 255);
  sphere(13);
  translate(27, 0, 0);

  //jr.fill("glass", r, g, b);
  jr.fill("glass", 255, 255, 255);
  sphere(13);
  translate(27, 0, 0);

  //jr.fill("constant", r, g, b);
  jr.fill("constant", 150, 255, 255);
  sphere(13);
  popMatrix();

  jr.endRecord(); //Make sure to end record.
  jr.displayRendered(true); //Display rendered image if render is completed, and the argument is true.
}

void keyPressed() {
  if (key == 'r' || key == 'R') jr.render(); //Press 'r' key to start rendering.
}
