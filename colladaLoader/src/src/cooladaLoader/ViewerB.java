package cooladaLoader;
import processing.core.*;

/**
 * This class is designed for tests only. It's not required part
 * of that package. Same code can be found at demo.pde
 */
public class ViewerB extends PApplet
{
	
   ColladaLoader model1=null;
   ColladaLoader model2=null;
   ColladaLoader model3=null;
   
   //enable models you want
   boolean mod1Enab = true;
   boolean mod2Enab = true;
   boolean mod3Enab = true;

	
    @Override
    public void setup()
    {
    	
	    noLoop(); //give all attention to this method. It seems that for setup() and draw() run two threads in same time. That makes processing to terminate without errors
	    size(500, 500,OPENGL); //use opengl
	    //lights(); //call lights in setup, not in draw, otherwise triangles wont be drawn, just lines apear (Bug arise in ubuntu64 only)
	    frameRate(10);
	    
	   
	   if (mod1Enab) model1 = new ColladaLoader("truck.dae", this);
	   if (mod2Enab) model2 = new ColladaLoader("duff.kmz", this);
	   if (mod3Enab) model3 = new ColladaLoader("ghostly_susan_at_glasswall.kmz", this);
	   
	   //IF YOU WANT TO SEE MODEL DRWAWN DRAG WITH MOUSE FIRST OVER SKETCH

    }

    @Override
    public void draw(){


	   lights(); // Note that ubuntu 64 bit hides triangles when lights called in draw(), call it in setup() instead
	   background(200);
	   
	   //shift coords skethup like -> point zero should appear in the center
	   translate(250, 250, 0);
	   rotateX(-0.048000026f);
	   rotateY(-0.32000035f);
	   scale(2.5f); 
	   
	   //draw the same x,y,z lines that you see in google sketchup	
	   strokeWeight(2);
	   stroke(125, 0, 0);
	   line(0, 0, 0, width, 0, 0); 
	   stroke(0, 125, 0);
	   line(0, 0, 0, 0, 0, -width);
	   stroke(0, 0, 125);
	   line(0, 0, 0, 0, -height, 0);
	
	   //now draw the model
	   if (mod1Enab) model1.draw();
	   if (mod2Enab) model2.draw();
	   if (mod3Enab) model3.draw();
       	       	
    	
    }

    public void mouseDragged()
    {
	  loop(); //release blocked draw() thread
	  
	    //theese functions demonstrate built in tools for model positionings
	    
	   if (key == 'a' )
	   {
	     if(mod1Enab)
	     {
	       model1.rotate((mouseX - pmouseX) * 0.004f, 'y');
	       model1.rotate((mouseY - pmouseY) * 0.004f, 'x');
	     }
	     if(mod2Enab)
	     {
	       model2.rotate((mouseX - pmouseX) * 0.004f, 'y');
	       model2.rotate((mouseY - pmouseY) * 0.004f, 'x');
	     }
	     if (mod3Enab)
	     {
	       model3.rotate((mouseX - pmouseX) * 0.004f, 'y');
	       model3.rotate((mouseY - pmouseY) * 0.004f, 'x');
	     }
	
	 
	   }
	   if (key == 'd')
	   {
	       if (mod1Enab) model1.scale(1+(pmouseY - mouseY) * 0.01f);
	       if (mod2Enab) model2.scale(1+(pmouseY - mouseY) * 0.01f);
	       if (mod3Enab) model3.scale(1+(pmouseY - mouseY) * 0.01f);
	   }
	   if (key == 's' )
	   {
	     if (mod1Enab)
	     {
	       model1.shift((mouseX - pmouseX)*5, 'x');
	       model1.shift((mouseY - pmouseY)*5,'y');
	     }
	     if (mod2Enab)
	     {
	       model2.shift((mouseX - pmouseX)*5, 'x');
	       model2.shift((mouseY - pmouseY)*5,'y');
	     }
	     if (mod3Enab)
	     {
	       model3.shift((mouseX - pmouseX)*5, 'x');
	       model3.shift((mouseY - pmouseY)*5,'y'); 
	     }      
	   }
	
	   if (key == 'y'||key == 'x'||key == 'c' )
	   {
	       char axis = (key == 'y')?'x':(key == 'x')?'y':(key == 'c')?'z':'0';
	       if (mod1Enab) model1.shift((mouseY - pmouseY)*5, axis);
	       if (mod2Enab) model2.shift((mouseY - pmouseY)*5, axis);
	       if (mod3Enab) model3.shift((mouseY - pmouseY)*5, axis);
	   }
	   if (key == '1'||key == '2'||key == '3' )
	   {
	       char axis = (key == '1')?'x':(key == '2')?'y':(key == '3')?'z':'0';
	       if (mod1Enab) model1.rotate((mouseY - pmouseY) * 0.004f, axis);
	       if (mod2Enab) model2.rotate((mouseY - pmouseY) * 0.004f, axis);
	       if (mod3Enab) model3.rotate((mouseY - pmouseY) * 0.004f, axis);
	   }     


    }

    public void keyPressed() 
    {
      
	    //theese shortcuts demonstrate the possibilities what else you could do 
	   if (key=='p'&& mod1Enab)
	   	colorManipulations(model1); //change colors
	   if (key=='o'&& mod2Enab)
	   	shapeManipulations(model2); //change the shape itself
	   if (key=='j')
	       {  
	           //save what you have done persistently (Note: .dat suffix is a reserved expression)
	           if (mod1Enab) model1.save("truck.dat");
	           if (mod2Enab) model2.save("duff.dat");
	           if (mod3Enab) model3.save("ghostly_susan_at_glasswall.dat");
	       }
    }

    //demo how to change colors at runtime (origin dae/kmz wont be changed)
    private void colorManipulations(ColladaLoader model)
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
   private  void shapeManipulations(ColladaLoader model)
    {
       Triangle tri = model.getTriangles()[50];
       tri.A.x +=10.0f;
    }
        
 
	
  




    public static void main(String[] args)
    {
    	
    	//run as applett
    	PApplet.main(new String[] { "--present", "cooladaLoader.ViewerB" });
    }



    

}



