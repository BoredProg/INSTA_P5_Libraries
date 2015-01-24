package cooladaLoader;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import processing.core.PApplet;
import processing.core.PImage;

/**
 * This class wrapps all required model data to make it
 * serializable. The goal is to make PImage serializable 
 * and avoid copies of same textures when save to disk
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.0
 */
class ModelData implements Serializable
{
    private Triangle[] triangles;
    private Line[] lines ;
    private HashMap<String, SerializablePImage> textures;
    
    ModelData(ColladaLoader model) {
		triangles = model.getTriangles();
		lines = model.getLines();
		mapImageData();
	}
    
    /**
     * this method initiates the hashmap with textures. the idea
     * is to serialize no doubled referred images and save performance
     */
    private void mapImageData()
    {
    	textures = new HashMap<String, SerializablePImage>();
    	for (Triangle tri:triangles)
    	{
       	 	if (tri.containsTexture && textures.get(tri.imageFileName)==null)
	    	{
	         	SerializablePImage img = new SerializablePImage(tri.imageReference);
	         	textures.put(tri.imageFileName, img);
	    	}
    	}
    }
    /**
     * Wraps texture data back into PImage and links to all 
     * referenced triangles. Call that right after deserializing
     * @param applet
     */
    void recoverPImages(PApplet applet)
    {
    	//convert SerializableImage to PImage
    	HashMap<String, PImage> pImages = new HashMap<String, PImage>();

    	for (Map.Entry<String,SerializablePImage> entry : textures.entrySet())
    	{
    		String fileName = entry.getKey();
    		SerializablePImage img = entry.getValue();
    		
    		PImage pImg = applet.createImage(img.width, img.height, img.format);
       		pImg.loadPixels();
    		pImg.pixels = img.pixels;
    		pImg.updatePixels();
    		
    		pImages.put(fileName, pImg);
    	}
    	//link triangles to images
    	for (Triangle tri:triangles)
    	{
    		if (tri.containsTexture)
	    	{
    			PImage img = pImages.get(tri.imageFileName);
 	        	tri.imageReference = img;
	     	}
    	}
    	
    	textures = null; // not used anymore-> make GC to flush
    }
    
    private class SerializablePImage implements Serializable
    {
        private int[] pixels;
        private int width, height, format;
        
        private SerializablePImage(PImage imageReference)
        {
        	imageReference.loadPixels();
	    	pixels = imageReference.pixels;
	    	width = imageReference.width;
	    	height = imageReference.height;
	    	format = imageReference.format;
        }
    }

    
	Triangle[] getTriangles() {
		return triangles;
	}
	Line[] getLines() {
		return lines;
	}
    
    
}
