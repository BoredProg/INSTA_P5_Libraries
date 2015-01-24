import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

float[][] points;
int numpoints;
HE_Mesh container;
HE_Mesh[] cells;
int numcells;
HET_ProgressReporter pr;
WB_Render render;

void setup() {
  size(1200, 1200, OPENGL);
  smooth(8);
  // Brute force approach to 3D Voronoi inside a container mesh. Very inefficient, useful
  // for prototyping tens to hundreds of points, painfully slow
  // for more...


  //create a container mesh
  container=new HE_Mesh(new HEC_Geodesic().setRadius(250));
  container=new HE_Mesh(new HEC_Geodesic().setB(4).setC(0).setRadius(200));
  
  container.modify(new HEM_Extrude().setDistance(125));
  container.smooth();
  //generate points
  numpoints=20;
  points=new float[numpoints][3];
  for (int i=0; i<numpoints; i++) {
    points[i][0]=random(-250, 250);
    points[i][1]=random(-250, 250);
    points[i][2]=random(-250, 250);
  }

  // generate voronoi cells
  HEMC_VoronoiCells multiCreator=new HEMC_VoronoiCells();
  multiCreator.setPoints(points);
  // alternatively points can be WB_Point[], any Collection<WB_Point> and double[][];
  multiCreator.setN(numpoints);//number of points, can be smaller than number of points in input. 
  multiCreator.setContainer(container);// cutoff mesh for the voronoi cells, complex meshes increase the generation time
  multiCreator.setOffset(0);// offset of the bisector cutting planes, sides of the voronoi cells will be separated by twice this distance
  multiCreator.setSurface(false);// is container mesh a volume (false) or a surface (true)
  multiCreator.setCreateSkin(false);// create the combined outer skin of the cells as an additional mesh? This mesh is the last in the returned array.


  pr=new HET_ProgressReporter(100);
  pr.start();
  cells=multiCreator.create();
  numcells=cells.length;

  render=new WB_Render(this);
}

void draw() {
  background(255);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(600, 600, 0);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  for (int i=0; i<numcells; i++) {
    WB_Point p=cells[i].getCenter();
    pushMatrix();
    translate(0.4*p.xf(), 0.4*p.yf(), 0.4*p.zf());
    noStroke();
    fill(255);
    render.drawFaces(cells[i]);
    stroke(0);
    render.drawEdges(cells[i]);
    popMatrix();
  }
}



void stop() {
  pr.interrupt();
}

