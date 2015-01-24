import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import processing.opengl.*;

HE_Mesh mesh;
HE_Mesh[] meshes;
WB_Render3D render;
WB_DebugRender3D drender;


void setup() {
  size(800, 800, OPENGL);
  smooth(8);
  create();

  //Explode the mesh into separate submeshes
  //meshes=new HE_Mesh[0];
  meshes=new HEMC_Explode().setMesh(mesh).create();
  colorMode(HSB);
  int c=0;
  for (HE_Mesh m : meshes) {
    m.validate();
 
    m.setColor(color((c++)*256.0/meshes.length, 255, 160));
  }
  colorMode(RGB);
  render=new WB_Render3D(this);
  drender=new WB_DebugRender3D(this);
}

void draw() {
  background(120);
  lights();
  translate(400, 400, 0);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  noStroke();
  
  for (HE_Mesh m : meshes) {
    if(m.getNumberOfFaces()>4){
    fill(m.getColor()); 
    render.drawFaces(m);
    }
  }

  stroke(0);
  render.drawEdges(mesh);
}

void create() {
  float[][][] values=new float[41][41][41];
  for (int i = 0; i < 41; i++) {
    for (int j = 0; j < 41; j++) {
      for (int k = 0; k < 41; k++) {
        values[i][j][k]=noise(0.07*i, 0.07*j, 0.07*k);if(k%13==2||k%13==3) values[i][j][k]+=0.2;
      }
    }
  }
  HEC_IsoSurfaceSNAP creator;
  creator=new HEC_IsoSurfaceSNAP();
  creator.setGamma(0.3).setResolution(40, 40, 40).setSize(10, 10, 10).setValues(values);
  creator.setIsolevel(0.61);
  creator.setBoundary(-100);
  mesh=new HE_Mesh(creator);
}

