import org.gicentre.treemappa.*;     // For treemappa classes
import org.gicentre.utils.colour.*;  // Colours needed by treemappa.

// Minimal example to draw a simple treemap directly in a sketch.
// Jo Wood, giCentre
// V1.2, 23rd March, 2011.

PTreeMappa pTreeMappa;    // Stores the treemap.

void setup()
{
  size(400,250);
  smooth();
  noLoop();
 
  // Create an empty treemap.    
  pTreeMappa = new PTreeMappa(this);
  
  // Load the data and build the treemap.
  pTreeMappa.readData("life.csv"); 
}

void draw()
{
  background(255);
  
  // Get treemappa to draw itself.
  pTreeMappa.draw();
}
