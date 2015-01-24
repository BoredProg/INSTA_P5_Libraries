// Sponge.pde by Martin Prout
class Sponge {
  color[] col = new int[] {
    0xffc0c0c0, 0xffffc000, 0xff66c033, 0xff669933, 0xffff9900, 0xff999999
  };

  int MIN_SIZE = 20; // crank up max memory to 2048 to use 10 (worked for me)
  ArrayList<CubeData> cubeData;
  PShape menger = createShape(PShape.GROUP);  
  Sponge(float sz) {
    cubeData = new ArrayList<CubeData>();
    fillCubeData(0, 0, 0, sz);
    createMenger();
  }

  void fillCubeData(float x, float y, float z, float sz) {
    float u = sz/3;
    if (sz < MIN_SIZE) { // recursion limited by minimum cube size
      CubeData data = new CubeData(x, y, z, sz);
      cubeData.add(data);
    }
    else {
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          for (int k = -1; k <= 1; k++) {
            if ((abs(i) + abs(j) + abs(k)) > 1 ) {
              fillCubeData(x + (i * u), y + (j * u), z + (k * u), u);
            }
          }
        }
      }
    }
  }

  void createMenger() {
    for (CubeData data : cubeData) {
      myBox(data.x, data.y, data.z, data.sz);
    }
  }


  void myBox(float x, float y, float z, float sz) {
    noStroke();
    float shiftX = x;
    float shiftY = y;
    float shiftZ = z;
    // Original had different color faces
    PShape cube = createShape();
    cube.beginShape(QUADS);
    // Front face
    cube.enableStyle();
    cube.ambient(80);
    cube.specular(40);
    cube.fill(col[0]);
    cube.normal(0, 0, 1);
    cube.vertex(-sz/2 + shiftX, -sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, -sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, +sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(-sz/2 + shiftX, +sz/2 + shiftY, -sz/2 + shiftZ); 

    // Back face
    cube.fill(col[1]);
    cube.normal(0, 0, -1);
    cube.vertex(-sz/2 + shiftX, -sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, -sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, +sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(-sz/2 + shiftX, +sz/2 + shiftY, +sz/2 + shiftZ);

    // Left face
    cube.fill(col[2]);
    cube.normal(1, 0, 0);
    cube.vertex(-sz/2 + shiftX, -sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(-sz/2 + shiftX, -sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(-sz/2 + shiftX, +sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(-sz/2 + shiftX, +sz/2 + shiftY, -sz/2 + shiftZ); 

    // Right face
    cube.fill(col[3]);
    cube.normal(-1, 0, 0);
    cube.vertex(+sz/2 + shiftX, -sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, -sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, +sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, +sz/2 + shiftY, -sz/2 + shiftZ); 

    // Top face
    cube.fill(col[4]);
    cube.normal(0, 1, 0);
    cube.vertex(-sz/2 + shiftX, -sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, -sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, -sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(-sz/2 + shiftX, -sz/2 + shiftY, +sz/2 + shiftZ); 

    // Bottom face
    cube.fill(col[5]);
    cube.normal(0, -1, 0);
    cube.vertex(-sz/2 + shiftX, +sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, +sz/2 + shiftY, -sz/2 + shiftZ); 
    cube.vertex(+sz/2 + shiftX, +sz/2 + shiftY, +sz/2 + shiftZ); 
    cube.vertex(-sz/2 + shiftX, +sz/2 + shiftY, +sz/2 + shiftZ);  
    cube.endShape();    
    menger.addChild(cube);
  }
  
  void render() {
    shape(menger);
  }
}

