package cooladaLoader;

/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 *
 * <p>this class is a intern helper to load or save the model. 
 * It starts kmz-unzipping, xml parsing and loads texture images if needed.
 * The helper can be flushed when all triangles and lines of this model are ready to draw</p>
 *
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.1.0
 */


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import cooladaLoader.xmlMapping.ColladaRawLoader;

import processing.core.PApplet;
import processing.core.PImage;
import processing.data.XML;

class LoadingHelper{

    private Triangle[] triangles;
    private Line[] lines ;
    private LoadingHelper(){}
	
	LoadingHelper(String fileName, PApplet applet)
	{
		if (fileName.endsWith("dat"))
		{
			ModelData c = loadModel(fileName, applet);
			lines = c.getLines();
			triangles = c.getTriangles();
			c=null; //make GC flush
		}
		else
		{
			try {
				URL daeLocation;
		        ColladaRawLoader rawLoader;
	            if (fileName.endsWith("kmz"))
	            {
	            	unzip(fileName, applet);
	            	daeLocation = new File(readDOCkml(applet).getPath()).toURI().toURL();
	            }
	            else
	            	daeLocation = new File(applet.dataPath(fileName)).toURI().toURL();
	            
	            //read raw data
	            rawLoader = new ColladaRawLoader(daeLocation,applet);
	            triangles = rawLoader.getTriangles();
	            lines = rawLoader.getLines();
	            rawLoader = null; //activate GC to flush
	            
	            //do finish
	            File daeRootDir = new File(daeLocation.toURI()).getParentFile();
	            HashMap<String, PImage> pics = loadTextures(triangles, daeRootDir, applet);
	            assembleTextures(triangles, pics);
	            convertSkpCoordsToProcessing(triangles, lines);
	            //delete tmp zip files (if exist)
	           	deleteRecursive(new File(applet.dataPath("tempDir")));
	                     			
		  	} 
			catch (MalformedURLException e1) {throw new RuntimeException("could not find .dae file",e1);} 
		  	catch (URISyntaxException e2) {throw new ColladaLoaderException("could not find .dae root directory", e2);} 
		  	catch (IOException e) {throw new ColladaLoaderException("could not unzip kmz file", e);}
			}
		 
	}
	
	/**
	 * unzips to the same dataPath as the zipfile is
	 * @throws IOException 
	 */
    private void unzip(String filename, PApplet applet) throws IOException
    {

        ZipFile zipfile = new ZipFile(applet.dataPath(filename));//=fullPath incl filename
        Enumeration<? extends ZipEntry> e = zipfile.entries();
        while(e.hasMoreElements()) {
           ZipEntry entry = (ZipEntry) e.nextElement();
           
           File outfile = new File(applet.dataPath("tempDir/"+entry.getName()));//=fullPath incl filename
           if (outfile.exists()) 
           	outfile.delete(); //be shure to overwrite an existing file
           
           //if to create a directory needed
           if (!outfile.getParentFile().exists())
           	outfile.getParentFile().mkdirs();

           //unzip file
           int len;
           byte[] buffer = new byte[16384];
           BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(outfile));
           BufferedInputStream bis = new BufferedInputStream(zipfile.getInputStream(entry));
           while ((len = bis.read(buffer)) > 0)
               bos.write(buffer, 0, len);
           bos.flush();
           bos.close();
           bis.close();

        }

    }
	    
    /**
     * reads where to find the .dae file
     * @return a valid .dae file location
     */
    private File readDOCkml(PApplet applet)
    {
        XML root = applet.loadXML(applet.dataPath("tempDir/doc.kml"));
        XML dae = root.getChild("Folder/Placemark/Model/Link/href");
        String file = dae.getContent();
        return new File(applet.dataPath("tempDir/"+file));

    }
    
    
    /**
     * caches all Texture-Images only once (memory efficiency)
     * @param triangles
     * @param daeRootDir Rootdir where the .dae File is located (i.e ./.../data/models/)
     * @param applet
     * @return
     */
    private HashMap<String,PImage> loadTextures(Triangle[] triangles, File daeRootDir, PApplet applet)
    {

        HashMap<String,PImage> pictures = new HashMap<String, PImage>();
    	if (daeRootDir.isDirectory())
    	{
	        for (Triangle tri : triangles)
	        {
	        	String texName = tri.imageFileName;
	            if (tri.containsTexture && pictures.get(texName)== null)
	            {
		        	File picfile = new File(daeRootDir, texName);
	            	PImage tex = applet.loadImage(picfile.getPath());
	            	if (tex == null) throw new ColladaLoaderException("texture File "+picfile.getPath()+" doesn't exist");
	            	pictures.put(texName, tex);
	            }
	        }
    	}
        return pictures;
    
    }
    
    
    /**
     * <p>The method links texture references from cache to each triangles
     * if needed</p>
     * 
     * <p>Width and height definitions are different in sketchup and processing 
     * what is recalculated as well. The Formulas is:</p>
     * 
     * <p>textureProcessing x = textureSketchup x * picture.width</p>
     * <p>textureProcessing y = picture.height - textureSketchup y * picture.height</p>
     */	    
    private void assembleTextures(Triangle[] triangles, HashMap<String,PImage> pictures)
    {
        for (Triangle tri : triangles)
        {
            if (tri.containsTexture)
            {
            	//picture linking
                String texName = tri.imageFileName;
                PImage tex = pictures.get(texName);
                tri.imageReference = tex;
                
                //recalculation of x,y
                float AprocX = tri.texA.x * tex.width; float AprocY = tex.height - tri.texA.y * tex.height;
                float BprocX = tri.texB.x * tex.width; float BprocY = tex.height - tri.texB.y * tex.height;
                float CprocX = tri.texC.x * tex.width; float CprocY = tex.height - tri.texC.y * tex.height;

                tri.texA.x = AprocX; tri.texA.y = AprocY;
                tri.texB.x = BprocX; tri.texB.y = BprocY;
                tri.texC.x = CprocX; tri.texC.y = CprocY;
            }
        }
    }
    
	    
    /**
     * <p>Converts all Vertice Coordinates of Lines and Triangles from 
     * Sketchup standart to processing compatible values</p>
     * 
     * <p>per definition is:</p>
     * <p>processing x = sketchup x</p>
     * <p>processing y = sketchup -z</p>
     * <p>processing z = sketchup -y</p>
     */
       private void convertSkpCoordsToProcessing(Triangle[] triangles, Line[] lines)
       {
           for (Triangle tri : triangles)
           {
               float AprocX = tri.A.x; float AprocY = -tri.A.z; float AprocZ = -tri.A.y;
               float BprocX = tri.B.x; float BprocY = -tri.B.z; float BprocZ = -tri.B.y;
               float CprocX = tri.C.x; float CprocY = -tri.C.z; float CprocZ = -tri.C.y;

               tri.A.x = AprocX; tri.A.y = AprocY; tri.A.z = AprocZ;
               tri.B.x = BprocX; tri.B.y = BprocY; tri.B.z = BprocZ;
               tri.C.x = CprocX; tri.C.y = CprocY; tri.C.z = CprocZ;
           }

           for (Line lin : lines)
           {
               float AprocX = lin.A.x; float AprocY = -lin.A.z; float AprocZ = -lin.A.y;
               float BprocX = lin.B.x; float BprocY = -lin.B.z; float BprocZ = -lin.B.y;

               lin.A.x = AprocX; lin.A.y = AprocY; lin.A.z = AprocZ;
               lin.B.x = BprocX; lin.B.y = BprocY; lin.B.z = BprocZ;
           }
       }
       
       private void deleteRecursive(File file) throws FileNotFoundException
       {
    	   if (file.isDirectory()) {
    		    for (File c : file.listFiles())
    		      deleteRecursive(c);
    		  }
    		  file.delete();
       }
       
       /**
        * Deserializes a ColladaLoader object from disk
        * @param datFileName should end with .dat
        * @param applet
        * @return valid model
        */
       private ModelData loadModel(String datFileName, PApplet applet)
       {
       		ModelData mod = null;
       		try {
       			FileInputStream f=new FileInputStream(applet.dataPath(datFileName));
       			ObjectInputStream o=new ObjectInputStream(f);
       			mod =(ModelData)o.readObject();
       			o.close();
       		}
       		catch (Exception e) {throw new ColladaLoaderException("",e);} 
            
            //restore PImage texture because it's not (de-)serializable
            mod.recoverPImages(applet);
            return mod;
       }
       
       /**
        * Serializes a ColladaLoader object
        * @param fileName should end with .dat
        * @param export
        * @param applet
        */
       static void storeModel(String fileName, ColladaLoader model, PApplet applet)
       {
       	//store texture data from PImage (because it's not serializable)
          ModelData export = new ModelData(model);
          
          try {
                 FileOutputStream f=new FileOutputStream(applet.dataPath(fileName));
                 ObjectOutputStream o=new ObjectOutputStream(f);
                 o.writeObject(export);
                 o.flush();
                 o.close();
          }
          catch (Exception e) {throw new ColladaLoaderException("",e);} 
       }
       
        
	    
   /**
    * returns the prepared Triangeles from the file to use whatever you want
    * @return Triangles
    */
    Triangle[] getTriangles()
    {
           return triangles;
    }
   /**
    * returns the prepared Lines from the file to use whatever you want
    * @return the Lines
    */
   Line[] getLines()
   {
         return lines;
   }

}
