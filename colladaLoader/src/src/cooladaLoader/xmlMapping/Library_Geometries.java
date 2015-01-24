package cooladaLoader.xmlMapping;
import processing.data.XML;
import java.util.*;

import cooladaLoader.ColladaLoaderException;
/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 *<p> this class maps the Library_Geometries-tag</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Library_Geometries {

    private HashMap<String,Geometry> library_geometries = new HashMap<String, Geometry>();

    Library_Geometries(XML[] geometries)
    {
    	if (geometries.length==0) throw new ColladaLoaderException("library_geometries tag not found");
        for (XML geo : geometries)
        {
            Geometry g = new Geometry(geo);
            library_geometries.put(g.getID(), g);
            //System.out.println(g); //useful on debugging

        }

    }
/**
 *
 * @param id of the Geometry-Tag
 * @return a mapped Geometry
 */
    Geometry getGeometryByID(String id)
    {
        return library_geometries.get(id);
    }
    /**
     *
     * @return all Geometries that has been found in the xml-File
     */
    Collection<Geometry> getGeometries()
    {
        return library_geometries.values();
    }

}
