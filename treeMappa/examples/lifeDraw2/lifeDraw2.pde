import org.gicentre.treemappa.*;     // For treemappa classes
import org.gicentre.utils.colour.*;  // Colours needed by treemappa.
import org.gicentre.utils.move.*;    // For the ZoomPan class.

// Simple example to draw a simple treemap with some appearance 
// customisation and a zoomable dispaly.
// Jo Wood, giCentre
// V1.4, 23rd March, 2011.

PTreeMappa pTreeMappa;
ZoomPan zoomer;

void setup()
{
  size(400,250);
  smooth();
  zoomer = new ZoomPan(this);  
  
  // Display labels in a serif font
  textFont(createFont("serif",40));

  // Create an empty treemap.    
  pTreeMappa = new PTreeMappa(this);
  
  // Load the data and build the treemap.
  pTreeMappa.readData("life.csv"); 
  
  // Customise the appearance of the treemap
  pTreeMappa.getTreeMapPanel().setBorders(4);
  pTreeMappa.getTreeMapPanel().setBorder(0,0);
   
  pTreeMappa.getTreeMapPanel().setShowBranchLabels(true);
  pTreeMappa.getTreeMapPanel().setBranchMaxTextSize(0,80);
  pTreeMappa.getTreeMapPanel().setBranchMaxTextSize(1,30);
  pTreeMappa.getTreeMapPanel().setLeafMaxTextSize(12);
  pTreeMappa.getTreeMapPanel().setAllowVerticalLabels(true);
  pTreeMappa.getTreeMapPanel().setBranchTextColours(color(0,50));
  pTreeMappa.getTreeMapPanel().setLeafTextColour(color(0,0,80));
  
  pTreeMappa.getTreeMapPanel().setColourTable(ColourTable.readFile(createInput("life.ctb")));
  
  pTreeMappa.getTreeMapPanel().setLayouts("strip");
  
  // Layout needs updating because we have changed border size and the
  // treemap layout algorithm.
  pTreeMappa.getTreeMapPanel().updateLayout();
}

void draw()
{
  background(255);
  
  // Allow zooming and panning.
  zoomer.transform();
  
  // Get treemappa to draw itself.
  pTreeMappa.draw();
}
