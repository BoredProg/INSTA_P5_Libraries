import joons.JoonsRenderer;

JoonsRenderer jr;
ArrayList<Float> boxes = new ArrayList<Float> ();

//Camera Setting.
float eyeX = 0;
float eyeY = 120;
float eyeZ = 80;
float centerX = 0;
float centerY = 0;
float centerZ = 10;
float upX = 0;
float upY = 0;
float upZ = -1;
float fov = PI / 4; 
float aspect = 4/3f;  
float zNear = 5;
float zFar = 10000;

void setup() {
  size(800, 600, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("bucket");
  jr.setSizeMultiplier(1);
  jr.setAA(0, 2, 4); //setAA(minAA, maxAA, AASamples), increase AASamples to increase blur fidelity.
  jr.setCaustics(20);
  jr.setDOF(130, 3); //setDOF(focusDepth, lensRadius), bigger the lens radius, the blurrier the unfocused objects.

  for (int i = 0; i < 200; i++) {
    boxes.add(random(150)-75);
    boxes.add(random(150)-75);
    boxes.add(random(150)-20);
  }
}

void draw() {
  jr.beginRecord(); //Make sure to include things you want rendered.

  jr.background(0);
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  perspective(fov, aspect, zNear, zFar);

  //Floor.
  jr.fill("diffuse", 100, 100, 100);
  int w = 10000;
  beginShape(QUADS);
  vertex(w, -w, 0);
  vertex(-w, -w, 0);
  vertex(-w, w, 0);
  vertex(w, w, 0);
  endShape();

  //Lighting.
  jr.fill("light", 30, 30, 30, 64);
  int z = 50;
  beginShape(QUADS);
  vertex(-z, -z, 150);
  vertex(-z, z, 150);
  vertex(z, z, 150);
  vertex(z, -z, 150);
  endShape();

  //Random Boxes.
  jr.fill("diffuse", 255, 255, 255);
  for (int i = 0; i < boxes.size()/3; i++) {
    translate(boxes.get(i*3), boxes.get(i*3+1), boxes.get(i*3+2));
    box(2);
    translate(-boxes.get(i*3), -boxes.get(i*3+1), -boxes.get(i*3+2));
  }

  translate(-10, 0, 20);
  jr.fill("glass");
  sphere(15);
  translate(20, 0, 0);
  jr.fill("mirror");
  sphere(15);

  endShape();

  jr.endRecord(); //Make sure to end record.
  jr.displayRendered(true); //Display rendered image if render is completed, and the argument is true.
}

void keyPressed() {
  if (key == 'r' || key == 'R') jr.render(); //Press 'r' key to start rendering.
}
