package cooladaLoader.xmlMapping;
import java.util.HashMap;
import java.util.HashSet;

import cooladaLoader.ColladaLoaderException;
import processing.data.XML;

/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 *
 *<p> this class maps the Geometry -tag</p>
 *
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Geometry {

    private String ID;
    private HashSet<Triangles> trianglesSet;
    private HashSet<Lines> linesSet;


    Geometry(XML geometry)
    {
        ID = geometry.getString("id");
        if (ID==null) throw new ColladaLoaderException("geometry tag not parsed (id attribute)");

        XML mesh = geometry.getChild("mesh");
       
        //dump the source-Tags
        HashMap<String,SubTag> sources = new HashMap<String, SubTag>();
        XML[] _srcs = mesh.getChildren("source");
        if (_srcs.length==0) throw new ColladaLoaderException("geometry tag not parsed (no src subtags)");
        
        for (XML src : _srcs)
        {
            Source s = new Source(src);
            sources.put(s.getID(), s);
        }
        //dump the vertice-tag to the sources
        Vertices v = new Vertices(mesh.getChild("vertices"));
        sources.put(v.getID(), v);
 
        XML[] shapes;

        //dump triangles
        if ((shapes = mesh.getChildren("triangles")).length !=0)
        {
            trianglesSet = new HashSet<Triangles>();
            for (XML triangles : shapes)
            {
                trianglesSet.add(new Triangles(triangles, sources));
            }

        }
        int _c = shapes.length; 
        //dump lines
        if ((shapes = mesh.getChildren("lines")).length !=0)
        {
            linesSet = new HashSet<Lines>();
            for (XML lines : shapes)
            {
                linesSet.add(new Lines(lines, sources));
            }
        }
        if ((_c + shapes.length) ==0) 
        	throw new ColladaLoaderException("geometry tag not parsed (no triangles and no lines subtag exist)");
      
    }
    /**
     * sets all to the Lines and Triangles its materials
     * @param matlib
     * @param bindmap in the format Hashmap&lt;materialSymbol, materialID&gt;
     */
    void bindMaterials(Library_Materials matlib, HashMap<String,String> bindmap)
    {
        if (trianglesSet != null)
        {
            for (Triangles triangles : trianglesSet) {
                String matSymbol = triangles.getNextSource();
                String matID = bindmap.get(matSymbol);
                Material m = matlib.getMaterialByID(matID);
                if (m==null)throw new ColladaLoaderException("bad created materialBinds variable in Visual_Scene_sketchup8 or bad created Library_Materials");
                triangles.setMaterial(m);
            }
        }
        if (linesSet != null)
        {
                for (Lines lines : linesSet) {
                String matSymbol = lines.getNextSource();
                String matID = bindmap.get(matSymbol);
                Material m = matlib.getMaterialByID(matID);
                if (m==null)throw new ColladaLoaderException("bad created materialBinds variable in Visual_Scene or bad created Library_Materials");
                lines.setMaterial(m);
            }
        }

    }

/**
 *
 * @return the ID of the Geometry-Tag
 */
    String getID()
    {
        return ID;
    }
    /**
     * returns if any triangles found in xml-File, null if not
     * @return
     */
    HashSet<Triangles> getTriangles()
    {
        return trianglesSet;
    }
    /**
     * returns if any lines found in xml-File, null if not
     * @return
     */
    HashSet<Lines> getLines()
    {
        return linesSet;
    }


    @Override
    public String toString() {
        
        String s = "";
        s+= "Geometry "+ID+" contains: \n";
        if (trianglesSet != null)
            for (Triangles t : trianglesSet)
                s+= "a set of "+t+"\n";
        if (linesSet != null)
            for (Lines t : linesSet)
                s+= "a set of "+t+"\n";
        return s;
        
    }
  
}
