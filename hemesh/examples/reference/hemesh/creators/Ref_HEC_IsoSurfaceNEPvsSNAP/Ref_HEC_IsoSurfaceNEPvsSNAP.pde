import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import processing.opengl.*;

HE_Mesh mesh1, mesh2;
WB_Render3D render;
WB_DebugRender3D drender;
void setup() {
  size(1600, 800, OPENGL);
  smooth(8);

// Create an isosurface from an explicit grid of values.
// Potentially uses a lot of memory.

  
  
  float[][][] values=new float[41][41][41];
  for (int i = 0; i < 41; i++) {
    for (int j = 0; j < 41; j++) {
      for (int k = 0; k < 41; k++) {
        values[i][j][k]=noise(0.07*i, 0.07*j, 0.07*k);if(k%13==2||k%13==3) values[i][j][k]+=0.2;
      }
    }
  }

  HEC_IsoSurfaceNEP creator=new HEC_IsoSurfaceNEP();
  creator.setResolution(40,40,40);// number of cells in x,y,z direction
  creator.setSize(10, 10, 10);// cell size
  creator.setValues(values);// values corresponding to the grid points
  // values can also be double[][][]
  creator.setIsolevel(0.61);// isolevel to mesh
 // creator.setInvert(true);// invert mesh
 creator.setBoundary(-100);// value of isoFunction outside grid
  // use creator.clearBoundary() to rest boundary values to "no value".
  // A boundary value of "no value" results in an open mesh
  mesh1=new HE_Mesh(creator);
 HEC_IsoSurfaceSNAP creator2=new HEC_IsoSurfaceSNAP();
  creator2.setGamma(0.3);
  creator2.setResolution(40,40,40);// number of cells in x,y,z direction
  creator2.setSize(10, 10, 10);// cell size
  creator2.setValues(values);// values corresponding to the grid points
  // values can also be double[][][]
  creator2.setIsolevel(0.61);// isolevel to mesh
 // creator2.setInvert(true);// invert mesh
 creator2.setBoundary(-100);// value of isoFunction outside grid
  // use creator.clearBoundary() to rest boundary values to "no value".
  // A boundary value of "no value" results in an open mesh
  mesh2=new HE_Mesh(creator2);
  
  render=new WB_Render3D(this);
  drender=new WB_DebugRender3D(this);
  colorMode(HSB);
}

void draw() {
  background(120);
  ortho();
  //directionalLight(255, 255, 255, 1, 1, -1);
 // directionalLight(127, 127, 127, -1, -1, 1);
 lights();
  pushMatrix();
  translate(450, 400, 200);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  noStroke();
  render.drawFaces(mesh1);
  stroke(0);
  render.drawEdges(mesh1);
  popMatrix();
   pushMatrix();
  translate(1150, 400, 0);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  noStroke();
  render.drawFaces(mesh2);
  stroke(0);
  render.drawEdges(mesh2);
  popMatrix();
}



