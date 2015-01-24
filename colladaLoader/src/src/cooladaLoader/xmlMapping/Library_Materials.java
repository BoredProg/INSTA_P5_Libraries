package cooladaLoader.xmlMapping;
import processing.data.XML;
import java.util.HashMap;

import cooladaLoader.ColladaLoaderException;
/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 *<p> this class maps the Library_Materials -tag</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Library_Materials {

    private HashMap<String,Material> library_materials = new HashMap<String, Material>();

    Library_Materials(XML[] materials, Library_Effects libeff)
    {
    	if (materials.length==0) throw new ColladaLoaderException("library_materials tag not found");
        for (XML mat : materials)
        {
            Material m = new Material(mat, libeff);
            library_materials.put(m.getID(), m);
        }
    }
/**
 *
 * @param id of the Material-Tag
 * @return a mapped Material
 */
    Material getMaterialByID(String id)
    {
        return library_materials.get(id);
    }

    public String toString()
    {
        String s = "List of Materials: \n";
        for (Material m : library_materials.values())
            s += m+"\n";

        return s;

    }

}
