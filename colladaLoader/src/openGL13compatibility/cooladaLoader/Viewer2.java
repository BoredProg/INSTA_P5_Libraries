package cooladaLoader;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.swing.JFrame;

import processing.core.*;
/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 * <p>This Viewer is designed only for development environment and 
 * uses an old JOGL Version ( < GL2.0). Compiling of this class is
 * not nessessary</p>
 * 
 * <p>ColladaLoader class line 88 + 113 need to be uncommented 
 * to view models. JOGL libs are required (see <a href="http://jogamp.org/wiki/index.php/Downloading_and_installing_JOGL">jogamp.org</a></p> 
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 2.0
 */
public class Viewer2 extends PApplet implements MainScetch
{
	
    float rotX = -0.048000026f;
    float rotY = -0.32000035f;
    int x = 250;
    int y = 250;
    float changeSize = 2.5f;
    OpenGL11Adapter adapter;
    ColladaLoader model1;
    ColladaLoader model2;
    ColladaLoader model3;



    @Override
    public void setup()
    {
      size(500, 500);
      model1 = new ColladaLoader("truck.dae", this);
      model2 = new ColladaLoader("duff.kmz", this);
      model3 = new ColladaLoader("ghostly_susan_at_glasswall.kmz", this);
      

      adapter = new OpenGL11Adapter(500, 500, this);
      frameRate(5);

    }

    @Override
    public void draw(){
    	
    	adapter.repaint();
    }
	@Override
	public void draw(OpenGL11Adapter pApplet) {
		
		pApplet.background(200);
		pApplet.lights();//better call that in setup() on 'real' Viewer (otherwise it draws lines only on linux64)
		pApplet.translate(x, y, 0);
		pApplet.rotateX(rotX);
		pApplet.rotateY(rotY);
		pApplet.scale(changeSize); 
		
		pApplet.strokeWeight(2);
		pApplet.stroke(125, 0, 0);
		pApplet.line(0, 0, 0, width, 0, 0); 
		pApplet.stroke(0, 125, 0);
		pApplet.line(0, 0, 0, 0, 0, -width);
		pApplet.stroke(0, 0, 125);
		pApplet.line(0, 0, 0, 0, -height, 0);

		model1.draw(pApplet,pApplet);
		model2.draw(pApplet,pApplet);
		model3.draw(pApplet,pApplet);

		
	}
 
	
    public void mouseDragged()
    {
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
    
    public void keyPressed()
    {
        if (key=='p')
        	colorManipulations(model1);
        if (key=='o')
        	shapeManipulations(model2);
        if (key=='j')
        	model2.save("duff.dat");
    }
    
    //demo how to change colors at runtime (origin file wont be changed)
    private void colorManipulations(ColladaLoader model)
    {
    	Triangle[] tris = model.getTriangles();
    	for (Triangle t:tris) {
			float r=t.colour.red;
			float g=t.colour.green;
			float b=t.colour.blue;
			t.colour.red = g;
			t.colour.green = b;
			t.colour.blue = r;
		}

    }
    //demo how to change shapes at runtime (origin file wont be changed)
    private void shapeManipulations(ColladaLoader model)
    {
    	Triangle tri = model.getTriangles()[50];
    	tri.A.x +=10.0f;
    }
    




    public static void main(String[] args)
    {
        //Deprecated
    	//PApplet.main(new String[]{"cooladaLoader.Viewer"});
    	
    	//run as applett
    	PApplet.main(new String[] { "--present", "cooladaLoader.Viewer2" });
    }



    

}



