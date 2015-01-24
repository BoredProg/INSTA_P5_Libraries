
/*
* Created: by Carl-Johan Rosén as a part of the 
* course Procedural Methods for Images.
* At: Linköping Univeristy, Sweden.
* Date: 20060302
* Contact: cj(dot)rosen(at)gmail(dot)com
* Based on the work and research by Steven Worley.
*/

/* Importing the library. */
import CellNoise.*;

/*
* One instance of the main class is needed to get access to the 
* noise functions.
* The main function is the noise() function, which is used to 
* collect a set of values depending on the position in space or 
* plane. It takes an instance of the CellDataStruct class as its
* only argument. (See below for more info on CellDataStruct)
* The second public function is the constructor, which is used 
* to initialize the noise. It takes an instance of PApplet as
* its only argument.
*/
CellNoise cn;

/*
* One instance of the data structure is needed to send data to 
* and from the noise() function. It is through this class the 
* cell noise is controled.
* The user will use the only available function (the constructor)
* to set the properties of the noise. The properties are listed 
* below, as the are expected by the function CellDataStruct():
* - controler applet (PApplet parent).
* - order of feature points to measure distances to (int max_order).
* - position in space or plane (int[] at)
* - type of distance measure (int dist_type)
*   [EUCLIDEAN | CITYBLOCK | MANHATTAN | QUADRATIC]
*
* After calling the noise() function with a specific CellDataStruct,
* this instance contains the information connected to the position
* defined in this instance before the function call. The available 
* return data is listed below:
* - F[0 .. max_order] is the distance to the closest feature points, 
*   calculated using the distance measure specified.
* - ID[0 .. max_order] is a unique ID number for each feature point.
* - delta[0 .. max_order][0 .. dimensions] is an array of the vectors
*   pointing from the sample position towards each of the first 
*   feature points.
*/
CellDataStruct cd;
double[] at = {0, 0, 0};
double t = 0;
PImage im;
int x, y, i;

void setup() {
  size(200, 50);
  cn = new CellNoise(this);
  cd = new CellDataStruct(this, 2, at, cn.EUCLIDEAN);
}

void draw() {
  loadPixels();
  
  at[2] += 0.05;
  for (x = 0; x < width; x++) {
    at[0] = 0.05 * ( x + 20);
    for (y = 0; y < height; y++) {
      at[1] = 0.05 * ( y + 700 );
      
      /*
      * The CellDataStruct's (cd) position vector is set to current
      * position. In this case in 2D, adding a translation in
      * each call to draw().
      */
      cd.at = at;
      /*
      * The main work is done here. The result of the operation 
      * will be available in the CellDataStruct, cd, after the call.
      */
      cn.noise(cd);
      
      pixels[x + y*width] = color(
          (float)(cd.F[1]-cd.F[0]) * 200,
          (float)(cd.F[1]-cd.F[0]) * 170,
          (float)(cd.F[1]-cd.F[0]) * 60
      );
    }
  }
  updatePixels();
}
