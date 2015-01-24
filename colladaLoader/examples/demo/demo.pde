/**
 * this demo is an overview about its (partly new) features
 * The Loader parses Collada-XML files (.dae, .kmz) of Google Sketchup version 8 
 * (latest update dec 12). The files must be placed to the data path.
 * It also transfers model coordinates, changes colors and saves it (to .dat)
 * Press some keys then drag with mouse over the sketch
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 2.0
 */


import cooladaLoader.*;
import cooladaLoader.xmlMapping.*;


   ColladaLoader model1=null;
   ColladaLoader model2=null;
   ColladaLoader model3=null;
   
    
void setup()
{
    size(500, 500,OPENGL); //use opengl
    frameRate(10);

    model1 = new ColladaLoader("truck.dae", this);
    model2 = new ColladaLoader("duff.kmz", this);
    model3 = new ColladaLoader("ghostly_susan_at_glasswall.kmz", this);
   
   
   
}

void draw()
{
   lights(); 
   background(200);
   
   //shift point zero view into center (skethup like)
   translate(250, 250, 0);
   rotateX(-0.048000026f);
   rotateY(-0.32000035f);
   scale(2.5f); 
   
   //draw the same x,y,z helper lines like Google Sketchup	
   strokeWeight(2);
   stroke(125, 0, 0);
   line(0, 0, 0, width, 0, 0); 
   stroke(0, 125, 0);
   line(0, 0, 0, 0, 0, -width);
   stroke(0, 0, 125);
   line(0, 0, 0, 0, -height, 0);

   //now draw the model
   model1.draw();
   model2.draw();
   model3.draw();

    
}

void mouseDragged()
{
   //theese functions demonstrate built in tools for model transformations
   //key usage: {a,s,d} or {1,2,3} or {y,x,c} and mouse dragging
   if (key == 'a' )
   {
       model1.rotate((mouseX - pmouseX) * 0.004f, 'y');
       model1.rotate((mouseY - pmouseY) * 0.004f, 'x');

       model2.rotate((mouseX - pmouseX) * 0.004f, 'y');
       model2.rotate((mouseY - pmouseY) * 0.004f, 'x');

       model3.rotate((mouseX - pmouseX) * 0.004f, 'y');
       model3.rotate((mouseY - pmouseY) * 0.004f, 'x');
  
   }
   if (key == 'd')
   {
       model1.scale(1+(pmouseY - mouseY) * 0.01f);
       model2.scale(1+(pmouseY - mouseY) * 0.01f);
       model3.scale(1+(pmouseY - mouseY) * 0.01f);
   }
   if (key == 's' )
   {
       model1.shift((mouseX - pmouseX)*5, 'x');
       model1.shift((mouseY - pmouseY)*5,'y');

       model2.shift((mouseX - pmouseX)*5, 'x');
       model2.shift((mouseY - pmouseY)*5,'y');

       model3.shift((mouseX - pmouseX)*5, 'x');
       model3.shift((mouseY - pmouseY)*5,'y'); 
   }

   if (key == 'y'||key == 'x'||key == 'c' )
   {
       char axis = (key == 'y')?'x':(key == 'x')?'y':(key == 'c')?'z':'0';
       model1.shift((mouseY - pmouseY)*5, axis);
       model2.shift((mouseY - pmouseY)*5, axis);
       model3.shift((mouseY - pmouseY)*5, axis);
   }
   if (key == '1'||key == '2'||key == '3' )
   {
       char axis = (key == '1')?'x':(key == '2')?'y':(key == '3')?'z':'0';
       model1.rotate((mouseY - pmouseY) * 0.004f, axis);
       model2.rotate((mouseY - pmouseY) * 0.004f, axis);
       model3.rotate((mouseY - pmouseY) * 0.004f, axis);
   }     

}

void keyPressed() 
{

   //theese shortcuts demonstrate the possibilities what else you could do 
   //key usage: p,o,j

   if (key=='p')
   	colorManipulations(model1); //change colors
   if (key=='o')
   	shapeManipulations(model2); //change the shape itself
   if (key=='j')
       {  
           //save what you have done persistently (Note: .dat suffix is a reserved expression)
           model1.save("truck.dat");
           model2.save("duff.dat");
           model3.save("ghostly_susan_at_glasswall.dat");
       }
}

//demo how to change colors at runtime (origin dae/kmz wont be changed)
void colorManipulations(ColladaLoader model)
{
   Triangle[] tris = model.getTriangles();
   for (Triangle t:tris) 
   {
     if (!t.containsTexture)
     {
      float r=t.colour.red;
      float g=t.colour.green;
      float b=t.colour.blue;
      t.colour.red = g;
      t.colour.green = b;
      t.colour.blue = r;
     }
   }

}
//demo how to change shapes at runtime (origin dae/kmz wont be changed)
void shapeManipulations(ColladaLoader model)
{
   Triangle tri = model.getTriangles()[50];
   tri.A.x +=10.0f;
}


    
