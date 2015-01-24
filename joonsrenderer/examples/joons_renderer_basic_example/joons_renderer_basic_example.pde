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

void setup() {
  size(1280, 720, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("bucket");
  jr.setSizeMultiplier(4);
  jr.setAA(0,2);
}

void draw() {
  jr.beginRecord(); //Make sure to include things you want rendered.

  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  perspective(fov, aspect, zNear, zFar);

  
  jr.background("cornell_box", 300, 250, 100); //Cornell Box: width, height, depth.
  jr.background("gi_instant"); //Global illumination.
  
  translate(0,10,-10);
  rotateY(-PI/8);
  rotateX(-PI/8);
  jr.fill("diffuse", 255, 255, 255);
  box(20);

  jr.endRecord(); //Make sure to end record.
  jr.displayRendered(true); //Display rendered image if render is completed, and the argument is true.
}

void keyPressed() {
  if (key == 'r' || key == 'R') jr.render(); //Press 'r' key to start rendering.
}
