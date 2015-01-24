/*
 * Written by: Carl-Johan Rosén, Linköping University
 * Date: 2006-02-23
 * Contact: cj dot rosen at gmail dot com
 * 
 * The class serves as a data structure for cell data in 
 * the cellular noise library for Processing. 
 *
 */


package CellNoise;
import processing.core.*;

public class CellDataStruct {
	
	// Dimensions.
	public int dim;
	// Max number of 'closest' points.
	public int max_order;
	// Position in space/plane.
	public double[] at;
	// Distance to closest points.
	public double[] F;
	// Vector to closest points.
	public double[][] delta;
	// Uniqe id depending on the seed of the closest point.
	public long[] ID;
	// Distance measure type.
	public int dist_type;
	
	
	
	// Constructor initiating the structure.
	public CellDataStruct(PApplet parent, int max_order, double[] at, int dist_type) {
		this.dim = at.length;
		this.max_order = max_order;
		this.at = at;
		this.dist_type = dist_type;
		F = new double[max_order];
		delta = new double[max_order][this.dim];
		ID = new long[max_order];
		parent.registerDispose(this);
	}
	
	
	
	// Function required by Processing library standards. Called at shut-down.
	public void dispose() {
		// empty
	}
}